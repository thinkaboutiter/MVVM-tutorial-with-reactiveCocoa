//
//  FlickrSearchViewModel.swift
//  RWTFlickrSearch
//
//  Created by Boyan Yankov on W13 02/04/2016 Sat.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import Foundation
import ReactiveCocoa

class FlickrSearchViewModel: NSObject {
    var searchText: String = ""
    var title: String = "Flickr Search"
    
    override init() {
        super.init()
        
        let validSearchSignal: RACSignal = RACObserve(self, "searchText").map { (value: AnyObject!) -> AnyObject! in
            (value as! String).characters.count > 3
        }.distinctUntilChanged()
        
        validSearchSignal.subscribeNext { (value: AnyObject!) in
            debugPrint("\(self) \(#line) \(#function) search text valid » \((value as! Bool) ? "YES" : "NO")")
        }
    }
}