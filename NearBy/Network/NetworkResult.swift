//
//  NetworkResult.swift
//  NearBy
//
//  Created by Ahmet Gülden on 7.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

/// Result of the network operation.
///
/// - success: Success result with object.
/// - failure: Failure result with error.
enum NetworkResult<Value> {

    case success(response: Value)
    case failure(error: NetworkError)
}
