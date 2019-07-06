//
//  LocationAwareViewController.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import UIKit

/// View controller that can be notified when user locations are changed or
/// location permission state has changed.
class LocationAwareViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(locationUpdateHandler(_:)),
                                               name: Global.Notification.userLocationChanged,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(locationPermissionStateUpdateHandler(_:)),
                                               name: Global.Notification.locationPermissionStateChanged,
                                               object: nil)
    }

    /// Fired when user locations are updated.
    ///
    /// - Parameter locations: Updated locations. Most recent locations are at
    /// the end of the array.
    func locationsAreUpdated(_ locations: [Location]) {
        // Subclasses can override this method.
    }

    /// Fired when location permission state has changed.
    func locationsPermissionStateChanged() {
        // Subclasses can override this method.
    }
}

// MARK: - Notification Handlers

extension LocationAwareViewController {

    @objc
    private func locationUpdateHandler(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        locationsAreUpdated(userInfo.nrb_locations)
    }

    @objc
    private func locationPermissionStateUpdateHandler(_ notification: NSNotification) {
        locationsPermissionStateChanged()
    }
}
