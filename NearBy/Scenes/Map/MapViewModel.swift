//
//  MapViewModel.swift
//  NearBy
//
//  Created by Ahmet Gülden on 7.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

enum MapStateChange: StateChange {

    case itemsReceived
    case userLocationDetected
}

final class MapViewModel: StatefulViewModel<MapStateChange> {

    private(set) var items: [FetchItemResponse.Results.Item]?
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
        fetchItems(with: request)
    }

    func search(text: String) {
        guard let latitude = userLatitude, let longitude = userLongitude else {
            return
        }
        let request = SearchRequest(text: text,
                                    latitude: latitude,
                                    longitude: longitude)
        fetchItems(with: request)
    }

}

// MARK: - Network call

private extension MapViewModel {

    func fetchItems(with request: Request) {
        NetworkManager().send(request) { [weak self] (result: NetworkResult<FetchItemResponse>) in
            switch result {
            case .success(let response):
                self?.items = response.results.items
                DispatchQueue.main.async {
                    self?.emit(.itemsReceived)
                }
            case .failure(let error):
                // TODO
                break
            }
        }
    }
}
