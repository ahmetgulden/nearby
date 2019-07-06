//
//  PermissionGrantViewModel.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

/// Permission state change enum
///
/// - approved: Fires when user approves the permission.
/// - rejected: Fires when user rejects the permission.
enum PermissionStateChange: StateChange {

    case approved
    case rejected
}

/// Permission grant view model for handling permissions.
final class PermissionGrantViewModel: StatefulViewModel<PermissionStateChange> {

    /// Permission to ask for grant.
    let permission: Permission

    /// Creates grant view model with given permission.
    ///
    /// - Parameter permission: Permission to ask for grant.
    init(withPermission permission: Permission) {
        self.permission = permission
    }
}

// MARK: - Actions

extension PermissionGrantViewModel {

    /// Approves the permission.
    func approve() {
        PermissionManager.shared.ask(forPermission: permission)
        emit(.approved)
    }

    /// Rejects the permission.
    func reject() {
        emit(.rejected)
    }
}
