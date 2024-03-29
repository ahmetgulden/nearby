//
//  Global.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import UIKit

enum Global {

    enum UI {

        static let margin: CGFloat = 15.0
        static let buttonHeight: CGFloat = 44.0
        static let animationDuration: TimeInterval = 0.15
    }

    enum Notification {

        static let userLocationChanged = NSNotification.Name(rawValue: "userLocationChanged")
        static let locationPermissionStateChanged = NSNotification.Name(rawValue: "locationPermissionStateChanged")
    }
}
