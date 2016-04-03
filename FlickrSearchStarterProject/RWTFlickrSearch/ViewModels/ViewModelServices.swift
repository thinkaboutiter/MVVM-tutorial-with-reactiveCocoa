//
//  ViewModelServices.swift
//  RWTFlickrSearch
//
//  Created by Boyan Yankov on W13 03/04/2016 Sun.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import Foundation

class ViewModelServices: NSObject, ViewModelServicable {
    
    // MARK: - Properties
    
    lazy var searchService: FlickrSearcher = {
        let lazy_searchService = FlickrSearcher()
        return lazy_searchService
    }()
    
    // MARK: - Initialize
    
    // MARK: - Life cycle
    
    deinit {
        debugPrint("\(self) \(#line) \(#function) » Deinitialized")
    }
    
    // MARK: - `ViewModelServicable` protocol
    
    /** Creates an instance of `FlickrSearchable`, the **Model** layer service for searching *Flickr*, 
        and provides it to the **ViewModel** upon request.
     */
    func getFlickrSearchService() -> FlickrSearchable {
        return self.searchService
    }
}