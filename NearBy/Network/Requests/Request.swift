//
//  Request.swift
//  NearBy
//
//  Created by Ahmet Gülden on 7.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

/// HTTP method
enum RequestMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
    case patch = "PATCH"
}

/// Enum that has all the hosts that this application reaches.
enum Host: String {
    case hereApi = "https://places.demo.api.here.com/places/v1/"

    /// Additional parameters needed for requests to reach this host.
    var additionalParameters: [String: String] {
        switch self {
        case .hereApi:
            return [
                "app_code": "AJKnXv84fjrb0KIHawS0Tg",
                "app_id": "DemoAppId01082013GAL",
            ]
        }
    }
}

/// Request protocol.
protocol Request {

    /// Host to be connected.
    var host: Host { get }

    /// Endpoint to be connected.
    var endpoint: String { get }

    /// HTTP method for the connection.
    var method: RequestMethod { get }

    /// Parameters related to the request.
    var parameters: [String: String] { get }
}
