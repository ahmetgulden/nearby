//
//  SearchRequest.swift
//  NearBy
//
//  Created by Ahmet Gülden on 8.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

struct SearchRequest: Request {

    let host: Host = .hereApi
    let endpoint: String = "discover/search"
    let method: RequestMethod = .get
    let parameters: [String : String]

    init(text: String, latitude: Double, longitude: Double) {
        self.parameters = [
            "q": text,
            "pretty": "true",
            "in": "\(latitude),\(longitude);r=500"
        ]
    }
}
