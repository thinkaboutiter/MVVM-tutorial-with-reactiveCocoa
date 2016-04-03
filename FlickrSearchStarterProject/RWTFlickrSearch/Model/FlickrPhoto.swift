//
//  FlickrPhoto.swift
//  RWTFlickrSearch
//
//  Created by Boyan Yankov on W13 03/04/2016 Sun.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import Foundation

class FlickrPhoto: NSObject {
    
    // MARK: - Properties
    
    var title: String?
    var url: NSURL?
    var identifier: String?
    
    override var description: String {
        return self.title ?? "FlickrPhoto object"
    }
    
    // MARK: - Initialize
    
    // MARK: - Life cycle
}