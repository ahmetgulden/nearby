//
//  PermissionManager.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

/// Singleton permission manager.
final class PermissionManager {

    /// Shared instance of permission manager
    static let shared = PermissionManager()

    private init() {}

    /// Returns state of the permission.
    ///
    /// - Parameter permission: Related permission.
    /// - Returns: State of the permission.
    func stateOfPermission(_ permission: Permission) -> PermissionState {
        switch permission {
        case .location:
            return LocationManager.shared.permissionState
        }
    }

    /// Asks user for related permission.
    ///
    /// - Parameter permission: Permission to be asked.
    func ask(forPermission permission: Permission) {
        let state = stateOfPermission(permission)

        switch permission {
        case .location:
            switch state {
            case .notAsked:
                LocationManager.shared.askForLocationChanges()
            case .granted, .askedButRefused, .notAvailable:
                return
            }
        }
    }
}
