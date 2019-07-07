//
//  SearchViewModel.swift
//  NearBy
//
//  Created by Ahmet Gülden on 7.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import Foundation

enum SearchStateChange: StateChange {

    case requestedSearch(text: String)
    case requestedExplory(category: HereAPI.Category)
}

final class SearchViewModel: StatefulViewModel<SearchStateChange> {

    let searchTitleText = "You can search nearby locations by entering search text below"
    let exploreTitleText = "Or you can simply explore by selecting a category"
    let searchTextPlaceholder = "Enter a search key"
    let closeButtonText = "Close"
}
