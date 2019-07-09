//
//  PermissionManagerTests.swift
//  NearByTests
//
//  Created by Ahmet Gülden on 9.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import XCTest
@testable import NearBy

final class PermissionManagerTests: XCTestCase {

    func testPermissionState() {
        let permission: Permission = .location
        var isAsked = PermissionManager.shared.isPermissionAsked(permission)
        XCTAssertFalse(isAsked, "Permission state tracking failed")
        PermissionManager.shared.setPermissionAsAsked(permission)
        isAsked = PermissionManager.shared.isPermissionAsked(permission)
        XCTAssertTrue(isAsked, "Permission state tracking failed")
    }
}
