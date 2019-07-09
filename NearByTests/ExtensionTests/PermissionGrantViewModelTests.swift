//
//  PermissionGrantViewModelTests.swift
//  NearByTests
//
//  Created by Ahmet Gülden on 9.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import XCTest
@testable import NearBy

final class PermissionGrantViewModelTests: XCTestCase {

    func testViewModel() {
        let viewModel = PermissionGrantViewModel(withPermission: .location)
        var expectedStateChange: PermissionStateChange?

        viewModel.setStateChangeHandler{ stateChange in
            XCTAssert(stateChange == expectedStateChange, "Unexpected state change")
        }

        expectedStateChange = .rejected
        viewModel.reject()

        expectedStateChange = .approved
        viewModel.approve()
    }
}
