//
//  NetworkResult.swift
//  NearBy
//
//  Created by Ahmet Gülden on 7.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

enum NetworkResult<Value> {

    case success(response: Value)
    case failure(error: NetworkError)
}
