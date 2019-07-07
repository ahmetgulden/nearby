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
}

final class MapViewModel: StatefulViewModel<MapStateChange> {

    private(set) var exploredItems: ExploreResponse?
}

// MARK: - Actions

extension MapViewModel {

    func explore(category: HereAPI.Category, latitude: Double, longitude: Double) {
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
                break
            }
        }
    }
}
