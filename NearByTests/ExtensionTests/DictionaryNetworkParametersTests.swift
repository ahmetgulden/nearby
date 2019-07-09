//
//  DictionaryNetworkParametersTests.swift
//  NearByTests
//
//  Created by Ahmet Gülden on 9.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import XCTest
@testable import NearBy

final class DictionaryNetworkParametersTests: XCTestCase {

    func testGetParameters() {

        let dictionary = [
            "latitude": "4.0",
            "longitude": "5.0"
        ]

        let query = dictionary.nrb_parametersForGet
        XCTAssert(query == "latitude=4.0&longitude=5.0", "Forming query from dictionary failed")
    }
}
