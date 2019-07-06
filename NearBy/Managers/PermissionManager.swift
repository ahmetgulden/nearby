//
//  PermissionManager.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

private enum Constants {

    static let permissionStoragePrefix = "permission_is_asked"
}

/// Singleton permission manager.
final class PermissionManager {

    /// Shared instance of permission manager
    static let shared = PermissionManager()

    private init() {}

    /// Returns wheter or not user permission view has presented to the user
    /// for this permission.
    ///
    /// - Parameter permission: Related permission.
    /// - Returns: Wheter or not user permission view has presented.
    func isPermissionAsked(_ permission: Permission) -> Bool {
        let value = UserDefaults(suiteName: nil)?.bool(forKey: permissionKey(permission))
        return value ?? false
    }

    /// Marks this permission as asked in user permission view.
    ///
    /// - Parameter permission: Related permission.
    func setPermissionAsAsked(_ permission: Permission) {
        UserDefaults(suiteName: nil)?.set(true, forKey: permissionKey(permission))
    }

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

// MARK: - Helpers

extension PermissionManager {

    private func permissionKey(_ permission: Permission) -> String{
        return "\(Constants.permissionStoragePrefix)\(permission.rawValue)"
    }
}
