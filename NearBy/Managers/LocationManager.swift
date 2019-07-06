//
//  LocationManager.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import CoreLocation

/// Singleton location manager.
final class LocationManager: NSObject {

    /// Shared location manager instance
    static let shared = LocationManager()

    private let locationManager: CLLocationManager

    private override init() {
        locationManager = CLLocationManager()
    }

    /// Updates current location of user.
    func askForLocationChanges() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    /// Updates current location of user.
    func updateLocation() {
        locationManager.startUpdatingLocation()
    }

    /// Permission state of location services.
    var permissionState: PermissionState {
        guard CLLocationManager.locationServicesEnabled() else {
            return .notAvailable
        }

        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways,
             .authorizedWhenInUse:
            return .granted
        case .denied,
             .restricted:
            return .askedButRefused
        case .notDetermined:
            return .notAsked
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // TODO
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // TODO
    }
}
