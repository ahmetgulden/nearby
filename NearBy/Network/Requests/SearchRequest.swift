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

//curl \
//--compressed \
//-H 'Accept-Encoding:gzip' \
//-H 'Accept-Language:en-us' \
//--get 'https://places.demo.api.here.com/places/v1/discover/search' \
//--data-urlencode 'app_code=AJKnXv84fjrb0KIHawS0Tg' \
//--data-urlencode 'app_id=DemoAppId01082013GAL' \
//--data-urlencode 'in=40.7592,-73.9846;r=500' \
//--data-urlencode 'pretty=true' \
//--data-urlencode 'q=pharmacy'
