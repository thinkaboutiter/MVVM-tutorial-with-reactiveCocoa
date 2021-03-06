//
//  FlickrSearchResults.swift
//  RWTFlickrSearch
//
//  Created by Boyan Yankov on W13 03/04/2016 Sun.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import Foundation

class FlickrSearchResults: NSObject {
    
    // MARK: - Properties
    
    var searchString: String = ""
    var photosArray: [FlickrPhoto] = [FlickrPhoto]()
    var totalResults: Int64 = 0
    
    override var description: String {
        return "searchString: `\(self.searchString)`,\ntotalResults: \(self.totalResults),\nphotos: \(self.photosArray)"
    }
}