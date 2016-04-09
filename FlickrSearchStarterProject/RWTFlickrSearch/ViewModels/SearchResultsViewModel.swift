//
//  SearchResultsViewModel.swift
//  RWTFlickrSearch
//
//  Created by Boyan Yankov on W14 09/04/2016 Sat.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import Foundation
import SimpleLogger

/**
 ViewModel to *back* the search results View
 */
@objc class SearchResultsViewModel: NSObject {
    
    // MARK: - Properties
    
    var title: String
    var searchResults: [FlickrPhoto]
    
    // MARK: - Initialization
    
    @objc init(withSearchResults results: FlickrSearchResults, services: ViewModelServicable) {
        self.title = results.searchString
        self.searchResults = results.photosArray
        
        super.init()
    }
    
    deinit {
        Logger.logInfo().logMessage("\(self) \(#line) \(#function) » `\(String(SearchResultsViewModel.self))` Deinitialized")
    }
}
