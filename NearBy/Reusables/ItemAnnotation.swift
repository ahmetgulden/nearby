//
//  ItemAnnotation.swift
//  NearBy
//
//  Created by Ahmet Gülden on 9.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import MapKit

final class ItemAnnotation: NSObject {

    let item: FetchItemResponse.Results.Item

    init(item: FetchItemResponse.Results.Item) {
        self.item = item
    }
}

extension ItemAnnotation: MKAnnotation {

    var coordinate: CLLocationCoordinate2D {
        guard item.position.count >= 2 else {
            return CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
        return CLLocationCoordinate2D(latitude: item.position[0],
                                      longitude: item.position[1])
    }

    var title: String? {
        return item.title
    }

    var subtitle: String? {
        return "Distance: \(item.distance)"
    }
}
