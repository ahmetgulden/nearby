//
//  MapViewModel.swift
//  NearBy
//
//  Created by Ahmet Gülden on 7.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import CoreData

enum MapStateChange: StateChange, Equatable {

    case itemsFetched
    case loadingStateChanged(isLoading: Bool)
    case fetchingItemsFailed(message: String)
    case userLocationDetected
}

final class MapViewModel: StatefulViewModel<MapStateChange> {

    private(set) var items: [MapItemPresentation]?
    private(set) var userLatitude: Double?
    private(set) var userLongitude: Double?
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
}

// MARK: - Actions

extension MapViewModel {

    /// Saves the user location.
    ///
    /// - Parameters:
    ///   - latitude: Latitude of user location.
    ///   - longitude: Longitude of user location.
    func setUserLocation(latitude: Double, longitude: Double) {
        userLatitude = latitude
        userLongitude = longitude
        emit(.userLocationDetected)
    }

    /// Explores the surrondings with category.
    ///
    /// - Parameter category: Places with this category to be explored.
    func explore(category: HereAPI.Category) {
        guard let latitude = userLatitude, let longitude = userLongitude else {
            return
        }
        let request = ExploreRequest(category: category,
                                     latitude: latitude,
                                     longitude: longitude)
        fetchItems(with: request)
    }

    /// Searches nearby places with a query.
    ///
    /// - Parameter text: Query text.
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
        if let cachedResponse = cachedSearchResponse(for: request) {
            updateItems(fromCache: cachedResponse)
            return
        }
        emit(.loadingStateChanged(isLoading: true))
        NetworkManager().send(request) { [weak self] (result: NetworkResult<FetchItemResponse>) in
            self?.emit(.loadingStateChanged(isLoading: false))
            switch result {
            case .success(let response):
                self?.cacheSearchResponse(response, for: request)
                self?.updateItems(fromResponse: response)
            case .failure(let error):
                self?.emit(.fetchingItemsFailed(message: error.localizedDescription))
            }
        }
    }
}

// MARK: - Core Data

private extension MapViewModel {

    func cachedSearchResponse(for request: Request) -> FetchResultEntity? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = FetchResultEntity.fetchRequest()
        let endPointPredicate = NSPredicate(format: "endpoint = %@", request.endpoint)
        let parametersPredicate = NSPredicate(format: "parameters = %@", request.parameters.nrb_parametersForGet)
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [endPointPredicate, parametersPredicate])
        let results = try? context.fetch(fetchRequest) as? [FetchResultEntity]
        return results??.first
    }

    func cacheSearchResponse(_ response: FetchItemResponse, for request: Request) {
        let resultEntity = FetchResultEntity(context: context)
        resultEntity.endpoint = request.endpoint
        resultEntity.parameters = request.parameters.nrb_parametersForGet
        response.results.items.forEach { item in
            guard item.position.count >= 2 else {
                return
            }
            let itemEntity = ItemEntity(context: context)
            itemEntity.title = item.title
            itemEntity.distance = item.distance
            itemEntity.latitude = item.position[0]
            itemEntity.longitude = item.position[1]
            resultEntity.addToResultToItem(itemEntity)
        }
        try? context.save()
    }
}

// MARK: - Presentation update

private extension MapViewModel {

    func updateItems(fromResponse response: FetchItemResponse) {
        items = response.results.items.compactMap { item -> MapItemPresentation? in
            guard item.position.count >= 2 else {
                return nil
            }
            return MapItemPresentation(title: item.title,
                                       distance: item.distance,
                                       latitude: item.position[0],
                                       longitude: item.position[1])
        }
        emit(.itemsFetched)
    }

    func updateItems(fromCache cache: FetchResultEntity) {
        items = (cache.resultToItem ?? []).compactMap { item -> MapItemPresentation? in
            guard let item = item as? ItemEntity else {
                return nil
            }
            return MapItemPresentation(title: item.title ?? "",
                                       distance: item.distance,
                                       latitude: item.latitude,
                                       longitude: item.longitude)
        }
        emit(.itemsFetched)
    }
}
