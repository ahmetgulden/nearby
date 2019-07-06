//
//  MapViewController.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

final class MapViewController: LocationAwareViewController {

    @IBOutlet private weak var mapView: MKMapView!

    private var locationServicesNotAvailableInfoView: InfoView?

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.showsUserLocation = true
        mapView.mapType = MKMapType.hybrid
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        startUpdatingUserLocation()
    }

    override func coordinatesAreUpdated(_ coordinates: [CLLocationCoordinate2D]) {
        super.coordinatesAreUpdated(coordinates)

        navigateToUserCoordinate(coordinates.last)
    }

    override func locationsPermissionStateChanged() {
        super.locationsPermissionStateChanged()

        startUpdatingUserLocation()
    }
}

// MARK: - MapView Update
private extension MapViewController {

    func navigateToUserCoordinate(_ coordinate: CLLocationCoordinate2D?) {
        guard let coordinate = coordinate else {
            return
        }

        let viewRegion = MKCoordinateRegion(center: coordinate,
                                            latitudinalMeters: 200,
                                            longitudinalMeters: 200)
        mapView.setRegion(viewRegion, animated: false)
    }
}

// MARK: - Location Update

private extension MapViewController {

    func startUpdatingUserLocation() {
        locationServicesNotAvailableInfoView?.removeFromSuperview()
        let state = PermissionManager.shared.stateOfPermission(.location)

        switch state {
        case .granted:
            LocationManager.shared.updateLocation()
        case .notAsked:
            guard !PermissionManager.shared.isPermissionAsked(.location) else {
                showLocationPermissionNeededInfo()
                return
            }
            showPermissionView()
        case .askedButRefused:
            showLocationPermissionNeededInfo()
        case .notAvailable:
            showLocationServicesNotAvailableInfo(with: Permission.location.permissionIsNotAvailableText)
        }
    }

    func showPermissionView() {
        let viewModel = PermissionGrantViewModel(withPermission: .location)
        let router = PermissionGrantRouter()
        let viewController = PermissionGrantViewController()
        viewController.viewModel = viewModel
        viewController.router = router
        present(viewController, animated: true)
    }

    func showLocationPermissionNeededInfo() {
        guard let text = Permission.location.permissionIsNeededText else {
            return
        }
        showLocationServicesNotAvailableInfo(with: text)
    }

    func showLocationServicesNotAvailableInfo(with message: String) {
        locationServicesNotAvailableInfoView = InfoView.show(message: message,
                                                             in: self)
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(locationServicesNotAvailableInfoViewTapped))
        locationServicesNotAvailableInfoView?.addGestureRecognizer(recognizer)
    }

    @objc
    private func locationServicesNotAvailableInfoViewTapped() {
        let state = PermissionManager.shared.stateOfPermission(.location)
        switch state {
        case .askedButRefused:
            Utility.openSettingsApplication()
        case .notAsked:
            locationServicesNotAvailableInfoView?.removeFromSuperview()
            showPermissionView()
        case .notAvailable, .granted:
            return
        }
    }
}
