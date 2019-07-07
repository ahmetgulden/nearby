//
//  Request.swift
//  NearBy
//
//  Created by Ahmet Gülden on 7.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

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

enum Host: String {
    case hereApi = "https://places.demo.api.here.com/places/v1/"
}

protocol Request {

    var host: Host { get }
    var endpoint: String { get }
    var method: RequestMethod { get }
    var parameters: [String: String] { get }
}

extension Request {

    func parametersForPost() -> Data {
        return Data() // TODO
    }

    func parametersForGet() -> String {
        return parameters.reduce(into: "", { (result, tuple) in
            if !result.isEmpty {
                result.append("&")
            }
            result.append(tuple.key)
            result.append("=")
            result.append(tuple.value)
        })
    }
}
