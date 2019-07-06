//
//  Dictionary+LocationConvertion.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import CoreLocation

private enum Constants {

    static let locationsKey = "Locations"
}

extension Dictionary where Key == AnyHashable, Value == Any {

    static func nrb_formUserInfo(from locations: [CLLocation]) -> [AnyHashable: Any]? {
        let locationArray = locations.map{ (location) -> Location in
            return Location(latitude: location.coordinate.latitude,
                            longitude: location.coordinate.longitude)
        }
        return [Constants.locationsKey: locationArray]
    }

    var nrb_locations: [Location] {
        guard let locations = self[Constants.locationsKey] as? [Location] else {
            return []
        }
        return locations
    }
}
