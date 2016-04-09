//
//  ViewModelServicable.swift
//  RWTFlickrSearch
//
//  Created by Boyan Yankov on W13 03/04/2016 Sun.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import Foundation

/** Allows the ViewModel to obtain a reference to an implementation of the `FlickrSearchable` protocol */
@objc protocol ViewModelServicable: NSObjectProtocol {
    func getFlickrSearchService() -> FlickrSearchable
    func pushViewModel(viewModel: AnyObject)
}