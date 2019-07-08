//
//  LocationAwareViewController.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import UIKit
import CoreLocation

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

    /// Fired when user coordinates are updated.
    ///
    /// - Parameter coordinates: Updated coordinates. Most recent coordinates are at
    /// the end of the array. If user location can not be found, returns an empty
    /// array.
    func coordinatesAreUpdated(_ coordinates: [CLLocationCoordinate2D]) {
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
        let coordinates = notification.userInfo?.nrb_coordinates ?? []
        coordinatesAreUpdated(coordinates)
    }

    @objc
    private func locationPermissionStateUpdateHandler(_ notification: NSNotification) {
        locationsPermissionStateChanged()
    }
}
