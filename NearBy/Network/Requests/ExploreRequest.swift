//
//  ExploreRequest.swift
//  NearBy
//
//  Created by Ahmet Gülden on 7.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

struct ExploreRequest: Request {

    let host: Host = .hereApi
    let endpoint: String = "discover/explore"
    let method: RequestMethod = .get
    let parameters: [String : String]

    init(category: HereAPI.Category, latitude: Double, longitude: Double) {
        self.parameters = [
            "cat": category.rawValue,
            "pretty": "true",
            "in": "\(latitude),\(longitude);r=500"
        ]
    }
}
