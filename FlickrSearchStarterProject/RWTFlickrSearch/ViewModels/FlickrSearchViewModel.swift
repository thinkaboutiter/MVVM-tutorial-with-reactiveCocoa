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
    var executeSearchCommand: RACCommand!
    
    private unowned let service: ViewModelServicable
    
    // MARK: - Initialize
    
    init(withService service: ViewModelServicable) {
        self.service = service
        
        super.init()
        
        // create `validSearchSignal`
        let validSearchSignal: RACSignal = RACObserve(self, "searchText").map { (value: AnyObject!) -> AnyObject! in
            (value as! String).characters.count > 3
        }.distinctUntilChanged()
        
        validSearchSignal.subscribeNext { (value: AnyObject!) in
            debugPrint("\(self) \(#line) \(#function) search text valid » \((value as! Bool) ? "YES" : "NO")")
        }
        
        // create a command that is enabled when the validSearchSignal emits `true`
        self.executeSearchCommand = RACCommand(enabled: validSearchSignal) { (input: AnyObject!) -> RACSignal! in
            return self.executeSearchSignal()
        }
    }
    
    // MARK: - Signals
    
    /** Delegates to the model to perform the search */
    private func executeSearchSignal() -> RACSignal {
        let signal = self.service.getFlickrSearchService().flickrSearchSignal(forSearchString: self.searchText)
        return signal
    }
}