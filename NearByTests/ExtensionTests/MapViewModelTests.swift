//
//  MapViewModelTests.swift
//  NearByTests
//
//  Created by Ahmet Gülden on 9.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import XCTest
import CoreData
@testable import NearBy

final class MapViewModelTests: XCTestCase {

    func testViewModel() {
        let viewModel = MapViewModel(context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
        XCTAssert(viewModel.items == nil, "Items found when they need to be nil")
        XCTAssert(viewModel.userLatitude == nil, "Location found when they need to be nil")
        XCTAssert(viewModel.userLongitude == nil, "Location found when they need to be nil")

        var expectedStateChange: MapStateChange?
        viewModel.setStateChangeHandler{ stateChange in
            XCTAssert(stateChange == expectedStateChange, "Unexpected state change")
        }

        expectedStateChange = .loadingStateChanged(isLoading: true)
        viewModel.emit(.loadingStateChanged(isLoading: true))

        expectedStateChange = .userLocationDetected
        viewModel.setUserLocation(latitude: 10.0, longitude: 15.0)
        XCTAssert(viewModel.userLatitude == 10.0 && viewModel.userLongitude == 15.0, "User location is not correct")
        expectedStateChange = .loadingStateChanged(isLoading: false)
        viewModel.emit(.loadingStateChanged(isLoading: false))
    }
}
