//
//  Dictionary+LocationConvertion.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import CoreLocation

private enum Constants {

    static let coordinatesKey = "Coordinates"
}

extension Dictionary where Key == AnyHashable, Value == Any {

    /// Constructs a dictionary with locations.
    ///
    /// - Parameter locations: Locations.
    /// - Returns: Constructed dictionary with location data.
    static func nrb_formUserInfo(from locations: [CLLocation]) -> [AnyHashable: Any]? {
        let locationArray = locations.map{ (location) -> CLLocationCoordinate2D in
            return location.coordinate
        }
        return [Constants.coordinatesKey: locationArray]
    }

    /// Creates a coordinate array from dictionary.
    var nrb_coordinates: [CLLocationCoordinate2D] {
        guard let coordinates = self[Constants.coordinatesKey] as? [CLLocationCoordinate2D] else {
            return []
        }
        return coordinates
    }
}
