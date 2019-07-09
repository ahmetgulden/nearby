//
//  DictionaryLocationConversionTests.swift
//  NearByTests
//
//  Created by Ahmet Gülden on 9.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import XCTest
import CoreLocation
@testable import NearBy

final class DictionaryLocationConversionTests: XCTestCase {

    func testLocationToDictionaryConversion() {
        let locations = [
            CLLocation(latitude: 10.0, longitude: 2.0),
            CLLocation(latitude: 1.0, longitude: 24.0),
            CLLocation(latitude: 55.0, longitude: -44.0),
            CLLocation(latitude: 77.5, longitude: 5.5)
        ]
        guard let dictionary = Dictionary.nrb_formUserInfo(from: locations) else {
            XCTAssertTrue(false, "Dictionary creation from locations failed")
            return
        }

        XCTAssert(dictionary.count == 1, "Dictionary content mismatched")
        guard let coordinates = dictionary["Coordinates"] as? [CLLocationCoordinate2D] else {
            XCTAssertTrue(false, "Dictionary content mismatched")
            return
        }
        XCTAssert(coordinates.count == 4, "Coordinates from dictionary mismatched")
        XCTAssert(coordinates[0].latitude == 10.0 && coordinates[0].longitude == 2.0, "Coordinate is not correct")
        XCTAssert(coordinates[1].latitude == 1.0 && coordinates[1].longitude == 24.0, "Coordinate is not correct")
        XCTAssert(coordinates[2].latitude == 55.0 && coordinates[2].longitude == -44.0, "Coordinate is not correct")
        XCTAssert(coordinates[3].latitude == 77.5 && coordinates[3].longitude == 5.5, "Coordinate is not correct")
    }

    func testDictionaryToLocaitonsConversion() {
        let dictionary: [AnyHashable: Any] = [
            "Coordinates": [
                CLLocationCoordinate2D(latitude: 24.0, longitude: 33.0),
                CLLocationCoordinate2D(latitude: 34.5, longitude: -53.0),
                CLLocationCoordinate2D(latitude: 6.46, longitude: 66.0),
                CLLocationCoordinate2D(latitude: 75.7, longitude: 37.88),
            ]]
        let coordinates = dictionary.nrb_coordinates
        XCTAssert(coordinates.count == 4, "Coordinates from dictionary mismatched")
        XCTAssert(coordinates[0].latitude == 24.0 && coordinates[0].longitude == 33.0, "Coordinate is not correct")
        XCTAssert(coordinates[1].latitude == 34.5 && coordinates[1].longitude == -53.0, "Coordinate is not correct")
        XCTAssert(coordinates[2].latitude == 6.46 && coordinates[2].longitude == 66.0, "Coordinate is not correct")
        XCTAssert(coordinates[3].latitude == 75.7 && coordinates[3].longitude == 37.88, "Coordinate is not correct")
    }
}
