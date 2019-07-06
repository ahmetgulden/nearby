//
//  ViewModel.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

protocol StateChange {

}

class StatefulViewModel<SC: StateChange> {

    private var handler: ((SC) -> ())?

    func setStateChangeHandler(_ handler: @escaping ((SC) -> ())) {
        self.handler = handler
    }

    func emit(_ stateChange: SC) {
        handler?(stateChange)
    }
}
