//
//  SearchResultsItemViewModel.swift
//  RWTFlickrSearch
//
//  Created by Boyan Yankov on W14 10/04/2016 Sun.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import UIKit
import ReactiveCocoa
import SimpleLogger

class SearchResultsItemViewModel: NSObject {
    
    // MARK: - Properties
    
    var isVisible: Bool = false
    
    // exposing underlying `Model` object properties
    var title: String?
    var url: NSURL?
    
    // updated dynamically when metadata is fetched
    var favourites: NSNumber = 0
    var comments: NSNumber = 0
    
    // private
    private weak var services: ViewModelServicable?
    private var photo: FlickrPhoto

    // MARK: - Initializer
    
    init(withPhoto photo: FlickrPhoto, services: ViewModelServicable) {
        self.photo = photo
        
        super.init()
        
        self.title = photo.title
        self.url = photo.url
        self.services = services
        
        self.createSignals()
    }
    
    // MARK: - Configurations (private)
    
    private func createSignals() {
        let fetchMetadataSignal: RACSignal = RACObserve(self, "isVisible").filter { (value: AnyObject!) -> Bool in
            return (value as! NSNumber).boolValue
        }
        
        fetchMetadataSignal.subscribeNext { [unowned self] (value: AnyObject!) in
            self.services?
                .getFlickrSearchService()
                .flickrImageMetadata(forPhotoId: self.photo.identifier!)
                .subscribeNext({ (value: AnyObject!) in
                    if let validMeta: FlickrPhotoMetadata = value as? FlickrPhotoMetadata {
                        self.favourites = NSNumber(unsignedInteger: validMeta.favourites)
                        self.comments = NSNumber(unsignedInteger: validMeta.comments)
                    }
                    else {
                        Logger.logError().logMessage("\(self) \(#line) \(#function) » unable to downcast `FlickrPhotoMetadata` object").logObject(value)
                    }
                })
        }
    }
}
