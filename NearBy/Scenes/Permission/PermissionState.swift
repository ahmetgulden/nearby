//
//  PermissionState.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

/// State of the permission.
enum PermissionState {
    case granted
    case askedButRefused
    case notAsked
    case notAvailable
}
