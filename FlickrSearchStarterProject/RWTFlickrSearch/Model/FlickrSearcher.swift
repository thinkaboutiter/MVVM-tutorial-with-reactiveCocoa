//
//  FlickrSearcher.swift
//  RWTFlickrSearch
//
//  Created by Boyan Yankov on W13 03/04/2016 Sun.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import Foundation
import ReactiveCocoa
import objectiveflickr
import SimpleLogger

/** Exposes services and is responsible for providing business logic for the application */
class FlickrSearcher: NSObject, FlickrSearchable, OFFlickrAPIRequestDelegate {
    
    // MARK: - Properties
    
    private let OFSampleAppAPIKey: String = "31c81c0723bb9302e4b5001316dea74e"
    private let OFSampleAppAPISharedSecret: String = "fc9c69079f325a17"
    
    private var requests: NSMutableSet = NSMutableSet()
    private lazy var flickrContext: OFFlickrAPIContext = {
        let lazy_flickrContext: OFFlickrAPIContext = OFFlickrAPIContext(APIKey: self.OFSampleAppAPIKey, sharedSecret: self.OFSampleAppAPISharedSecret)
        return lazy_flickrContext
    }()
    
    // MARK: - Initialization
    
    // MARK: - Life cycle
    
    private func signalFromAPIMethod(method: String,
                                     arguments: [NSObject : AnyObject],
                                     transform: (response: AnyObject!) -> AnyObject) -> RACSignal
    {
        // create signal for this reques
        let signal = RACSignal.createSignal { (subscriber: RACSubscriber!) -> RACDisposable! in
            // create Flicr request object
            let flickrRequest = OFFlickrAPIRequest(APIContext: self.flickrContext)
            flickrRequest.delegate = self
            
            // add it to `requests` collection
            self.requests.addObject(flickrRequest)
            
            // create signal from the delegate method for the completion
            /* 
             // rac_signalForSelector:fromProtocol: method creates the successSignal,
             // and it also creates signals from delegate method invocations.
             // Each time the delegate method is invoked, a next event emits with a RACTuple
             // that contains the method arguments
             */
            let successSignal: RACSignal = self.rac_signalForSelector(#selector(OFFlickrAPIRequestDelegate.flickrAPIRequest(_:didCompleteWithResponse:)), fromProtocol: OFFlickrAPIRequestDelegate.self)
            
            // TODO: there might be concurrent requests
            
            // handle the response
            successSignal
                .map({ (tuple: AnyObject!) -> AnyObject! in
                    
                    // Extract the second argument - the NSDictionary response
                    if let validTuple = tuple as? RACTuple {
                        return validTuple.second
                    }
                    else {
                        Logger.logError().logMessage("\(self) \(#line) \(#function) » possible unsuccessful `RACTuple` downcast").logObject(tuple)
                        return (tuple as! RACTuple).second
                    }
                })
                // transform the results with passed `transform` closure
                .map(transform)
                .subscribeNext({ (x: AnyObject!) in
                    
                    // send the results to the subscribers
                    subscriber.sendNext(x)
                    subscriber.sendCompleted()
                })

            // make the request
            flickrRequest.callAPIMethodWithGET(method, arguments: arguments)
            
            // when we are done, remove the reference to this request
            return RACDisposable(block: { 
                [self.requests.removeObject(flickrRequest)]
            })
        }
        
        return signal
    }
    
    // MARK: - `FlickrSearchable` protocol
    
    func flickrSearchSignal(forSearchString searchString: String) -> RACSignal {
        let signal: RACSignal = self.signalFromAPIMethod("flickr.photos.search",
                                                         arguments: [
                                                            "text" : searchString,
                                                            "sort" : "interestingness-desc"
        ]) { (response) -> AnyObject in
            let results: FlickrSearchResults = FlickrSearchResults()
            
            // `searchString`
            results.searchString = searchString
            
            // `validResults`
            if let validResults = response.valueForKeyPath("photos.total") as? String {
                results.totalResults = Int64(validResults)
            }
            else {
                Logger.logError().logMessage("\(self) \(#line) \(#function) » `photos.total` can not be downcast:").logObject(response.valueForKeyPath("photos.total"))
            }
            
            // `validPhotosArray`
            if let validPhotosArray: [[NSObject : AnyObject]] = response.valueForKeyPath("photos.photo") as? [[NSObject : AnyObject]] {
                results.photosArray = validPhotosArray.map({ (jsonObject: [NSObject : AnyObject]) -> FlickrPhoto in
                    let photo: FlickrPhoto = FlickrPhoto()
                    
                    // `validTitle`
                    if let validTitle: String = jsonObject["title"] as? String {
                        photo.title = validTitle
                    }
                    else {
                        Logger.logError().logMessage("\(self) \(#line) \(#function) » `title` can not be downcast:").logObject(jsonObject["title"])
                    }
                    
                    // `validIdentifier`
                    if let validIdentifier: String = jsonObject["id"] as? String {
                        photo.identifier = validIdentifier
                    }
                    else {
                        Logger.logError().logMessage("\(self) \(#line) \(#function) » `id` can not be downcast:").logObject(jsonObject["id"])
                    }
                    
                    // `validUrl`
                    photo.url = self.flickrContext.photoSourceURLFromDictionary(jsonObject, size: OFFlickrSmallSize)
                    
                    return photo
                })
            }
            else {
                Logger.logError().logMessage("\(self) \(#line) \(#function) » `photos.photo` can not be downcast:").logObject(response.valueForKeyPath("photos.photo"))
            }
            
            return results
        }
        
        return signal
    }
}