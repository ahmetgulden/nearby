//
//  Permission.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation
import UIKit

/// Permission enum file to hold all permissions.
enum Permission {

    /// Location grant permission.
    case location

    /// Icon of the permission when asking user for grant.
    var icon: UIImage {
        switch self {
        case .location:
            return UIImage(imageLiteralResourceName: "icon-location")
        }
    }

    /// Description of the permission when asking user for grant.
    var descriptionText: String {
        switch self {
        case .location:
            return "Let \(Utility.getAppName()) access your location to show you nearest places"
        }
    }

    /// Approve text of the permission when asking user for grant.
    var approveText: String {
        switch self {
        case .location:
            return "Enable location"
        }
    }

    /// Reject text of the permission when asking user for grant.
    var rejectText: String {
        switch self {
        case .location:
            return "Not now"
        }
    }
}
