//
//  FlickrPhotoMetadata.swift
//  RWTFlickrSearch
//
//  Created by Boyan Yankov on W14 10/04/2016 Sun.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import UIKit

class FlickrPhotoMetadata: NSObject {
    var favourites: UInt = 0
    var comments: UInt = 0
    
    override var description: String {
        return "metadata: comments = \(self.comments), faves = \(self.favourites)"
    }
}
