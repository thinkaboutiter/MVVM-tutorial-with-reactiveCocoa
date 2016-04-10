//
//  ViewModelServices.swift
//  RWTFlickrSearch
//
//  Created by Boyan Yankov on W13 03/04/2016 Sun.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import Foundation
import SimpleLogger

class ViewModelServices: NSObject, ViewModelServicable {
    
    // MARK: - Properties
    
    private lazy var searchService: FlickrSearcher = {
        let lazy_searchService = FlickrSearcher()
        return lazy_searchService
    }()
    
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initialize
    
    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    // MARK: - Life cycle
    
    deinit {
        Logger.logInfo().logMessage("\(self) \(#line) \(#function) » `\(String(ViewModelServices.self))` Deinitialized")
    }
    
    // MARK: - `ViewModelServicable` protocol
    
    /** Creates an instance of `FlickrSearchable`, the **Model** layer service for searching *Flickr*, 
        and provides it to the **ViewModel** upon request.
     */
    func getFlickrSearchService() -> FlickrSearchable {
        return self.searchService
    }
    
    /***/
    func pushViewModel(viewModel: AnyObject) {
        let viewController: UIViewController
        
        // check passed `viewModel` object
        if let validViewModel: SearchResultsViewModel = viewModel as? SearchResultsViewModel {
            viewController = RWTSearchResultsViewController(viewModel: validViewModel)
        }
        else {
            Logger.logError().logMessage("\(self) \(#line) \(#function) » trying to push unknown `ViewModel` object")
            return
        }
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}