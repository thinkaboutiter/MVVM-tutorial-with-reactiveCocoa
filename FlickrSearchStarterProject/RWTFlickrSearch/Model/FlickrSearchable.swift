//
//  FlickrSearchable.swift
//  RWTFlickrSearch
//
//  Created by Boyan Yankov on W13 03/04/2016 Sun.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import Foundation
import ReactiveCocoa

/** Define interface for the Model layer */
protocol FlickrSearchable: NSObjectProtocol {
    func flickrSearchSignal(searchString: String) -> RACSignal
}
