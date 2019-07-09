//
//  ItemAnnotation.swift
//  NearBy
//
//  Created by Ahmet Gülden on 9.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import MapKit

final class ItemAnnotation: NSObject {

    let item: MapItemPresentation

    init(item: MapItemPresentation) {
        self.item = item
    }
}

extension ItemAnnotation: MKAnnotation {

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: item.latitude,
                                      longitude: item.longitude)
    }

    var title: String? {
        return item.title
    }

    var subtitle: String? {
        return "Distance: \(item.distance)"
    }
}
