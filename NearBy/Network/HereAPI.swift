//
//  HereAPI.swift
//  NearBy
//
//  Created by Ahmet Gülden on 7.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

enum HereAPI {

    enum Category: String, CaseIterable {
        case eatDrink = "eat-drink"
        case restaurant
        case coffeeTea = "coffee-tea"
        case snacksFastFood = "snacks-fast-food"
        case goingOut = "going-out"
        case sightsMuseums = "sights-museums"
        case transport
        case airport
        case accommodation
        case shopping
        case leisureOutdoor = "leisure-outdoor"
        case administrativeAreasBuildings = "administrative-areas-buildings"
        case naturalGeographical = "natural-geographical"
        case petrolStation = "petrol-station"
        case atmBankExchange = "atm-bank-exchange"
        case toiletRestArea = "toilet-rest-area"
        case hospitalHealthCareFacility = "hospital-health-care-facility"
    }
}
