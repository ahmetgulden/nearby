//
//  MapViewModel.swift
//  NearBy
//
//  Created by Ahmet Gülden on 7.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

enum MapStateChange: StateChange {

    case exploreItemsReceived
    case userLocationDetected
}

final class MapViewModel: StatefulViewModel<MapStateChange> {

    private(set) var exploredItems: ExploreResponse?
    private(set) var userLatitude: Double?
    private(set) var userLongitude: Double?
}

// MARK: - Actions

extension MapViewModel {

    func setUserLocation(latitude: Double, longitude: Double) {
        userLatitude = latitude
        userLongitude = longitude
        emit(.userLocationDetected)
    }

    func explore(category: HereAPI.Category) {
        guard let latitude = userLatitude, let longitude = userLongitude else {
            return
        }
        let request = ExploreRequest(category: category,
                                     latitude: latitude,
                                     longitude: longitude)
        NetworkManager().send(request) { [weak self] (result: NetworkResult<ExploreResponse>) in
            switch result {
            case .success(let response):
                self?.exploredItems = response
                DispatchQueue.main.async {
                    self?.emit(.exploreItemsReceived)
                }
            case .failure(let error):
                // TODO
                break
            }
        }
    }
}
