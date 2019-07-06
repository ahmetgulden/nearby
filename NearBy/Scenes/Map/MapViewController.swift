//
//  MapViewController.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import MapKit
import UIKit

final class MapViewController: LocationAwareViewController {

    @IBOutlet private weak var mapView: MKMapView!

    private var locationServicesNotAvailableInfoView: InfoView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        startUpdatingUserLocation()
    }

    override func locationsAreUpdated(_ locations: [Location]) {
        super.locationsAreUpdated(locations)

        // TODO
    }

    override func locationsPermissionStateChanged() {
        super.locationsPermissionStateChanged()

        startUpdatingUserLocation()
    }
}

// MARK: - Location Update

private extension MapViewController {

    func startUpdatingUserLocation() {
        locationServicesNotAvailableInfoView?.removeFromSuperview()
        let permission = Permission.location
        let state = PermissionManager.shared.stateOfPermission(permission)

        switch state {
        case .granted:
            LocationManager.shared.updateLocation()
        case .notAsked:
            guard !PermissionManager.shared.isPermissionAsked(.location) else {
                showLocationPermissionNeededInfo()
                return
            }
            let viewModel = PermissionGrantViewModel(withPermission: permission)
            let router = PermissionGrantRouter()
            let viewController = PermissionGrantViewController()
            viewController.viewModel = viewModel
            viewController.router = router
            present(viewController, animated: true)
        case .askedButRefused:
            showLocationPermissionNeededInfo()
        case .notAvailable:
            locationServicesNotAvailableInfoView = InfoView.show(
                message: permission.permissionIsNotAvailableText,
                in: self)
        }
    }

    func showLocationPermissionNeededInfo() {
        guard let text = Permission.location.permissionIsNeededText else {
            return
        }
        locationServicesNotAvailableInfoView = InfoView.show(message: text,
                                                             in: self)
    }
}
