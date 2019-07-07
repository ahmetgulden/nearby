//
//  FetchItemResponse.swift
//  NearBy
//
//  Created by Ahmet Gülden on 7.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

struct FetchItemResponse: Response {

    struct Results: Response {

        struct Item: Response {

            struct Category: Response {

                let id: String
                let title: String
                let system: String
            }
            let position: [Double]
            let distance: Double
            let title: String
            let averageRating: Int
            let category: Category
            let icon: String
            let vicinity: String
        }

        let items: [Item]
    }

    let results: Results
}
