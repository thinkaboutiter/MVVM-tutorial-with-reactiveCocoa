//
//  FlickrSearcher.swift
//  RWTFlickrSearch
//
//  Created by Boyan Yankov on W13 03/04/2016 Sun.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import Foundation
import ReactiveCocoa

/** Exposes services and is responsible for providing business logic for the application */
class FlickrSearcher: NSObject, FlickrSearchable {
    
    // MARK: - Initialization
    
    // MARK: - Life cycle
    
    // MARK: - `FlickrSearchable` protocol
    
    func flickrSearchSignal(forSearchString searchString: String) -> RACSignal {
        let signal: RACSignal = RACSignal.empty().logAll().delay(2.0).logAll()
        return signal
    }
}