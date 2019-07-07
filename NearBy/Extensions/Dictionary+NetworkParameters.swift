//
//  Dictionary+NetworkParameters.swift
//  NearBy
//
//  Created by Ahmet Gülden on 7.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == String {

    var nrb_parametersForPost: Data {
        return Data() // TODO
    }

    var nrb_parametersForGet: String {
        return reduce(into: "", { (result, tuple) in
            if !result.isEmpty {
                result.append("&")
            }
            result.append(tuple.key)
            result.append("=")
            result.append(tuple.value)
        })
    }
}
