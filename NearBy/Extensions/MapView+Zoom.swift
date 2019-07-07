//
//  MapView+Zoom.swift
//  NearBy
//
//  Created by Ahmet Gülden on 8.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import MapKit

private enum Constants {
    static let pointRectangleSize = 0.01
    static let edgePaddingInsets = UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
}

extension MKMapView {

    func nrb_fitAllAnnotationsAndUser() {
        var zoomRect = MKMapRect.null;
        zoomRect.union(MKMapRect(x: userLocation.coordinate.latitude,
                                 y: userLocation.coordinate.longitude,
                                 width: Constants.pointRectangleSize,
                                 height: Constants.pointRectangleSize))
        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x,
                                      y: annotationPoint.y,
                                      width: Constants.pointRectangleSize,
                                      height: Constants.pointRectangleSize);
            zoomRect = zoomRect.union(pointRect);
        }
        setVisibleMapRect(zoomRect,
                          edgePadding: Constants.edgePaddingInsets,
                          animated: true)
    }
}
