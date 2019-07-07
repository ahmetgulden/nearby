//
//  NetworkError.swift
//  NearBy
//
//  Created by Ahmet Gülden on 7.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

enum NetworkError: Error {

    case brokenURL
    case responseError(message: String)
    case decodeError
}
