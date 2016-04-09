//
//  FlickrSearchViewModel.swift
//  RWTFlickrSearch
//
//  Created by Boyan Yankov on W13 02/04/2016 Sat.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import Foundation
import ReactiveCocoa
import SimpleLogger

/** Represents the *view-state* of the application.
    It also responds to user interactions and *events* that come from the **Model layer**,
    each of which are reflected by changes in *view-state* */
@objc class FlickrSearchViewModel: NSObject {
    var searchText: String = ""
    var title: String = "Flickr Search"
    var executeSearchCommand: RACCommand!
    
    private unowned let services: ViewModelServicable
    
    // MARK: - Initialize
    
    @objc init(withServices services: ViewModelServicable) {
        self.services = services
        
        super.init()
        
        // create `validSearchSignal`
        let validSearchSignal: RACSignal = RACObserve(self, "searchText").map { (value: AnyObject!) -> AnyObject! in
            (value as! String).characters.count > 2
        }.distinctUntilChanged()
        
        validSearchSignal.subscribeNext { (value: AnyObject!) in
            Logger.logInfo().logMessage("\(self) \(#line) \(#function) search text valid » \((value as! Bool) ? "YES" : "NO")")
        }
        
        // create a command that is enabled when the validSearchSignal emits `true`
        self.executeSearchCommand = RACCommand(enabled: validSearchSignal) { (input: AnyObject!) -> RACSignal! in
            return self.executeSearchSignal()
        }
    }
    
    // MARK: - Life cycle
    
    deinit {
        Logger.logInfo().logMessage("\(self) \(#line) \(#function) » `FlickrSearchViewModel` Deinitialized")
    }
    
    // MARK: - Signals
    
    /** Delegates to the model to perform the search */
    private func executeSearchSignal() -> RACSignal {
        let signal = self.services.getFlickrSearchService().flickrSearchSignal(forSearchString: self.searchText).logAll()
        return signal
    }
}