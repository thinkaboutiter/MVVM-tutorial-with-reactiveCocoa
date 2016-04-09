//
//  Created by Colin Eberhardt on 23/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTFlickrSearch-Swift.h"

@interface RWTSearchResultsViewController ()

// `viewModel`
@property(nonnull, nonatomic, strong) SearchResultsViewModel* viewModel;

// outlets
@property (weak, nonatomic) IBOutlet UITableView* searchResultsTable;

@end

@implementation RWTSearchResultsViewController

#pragma mark - Initialization

- (nonnull instancetype)initWithViewModel:(nonnull SearchResultsViewModel*)viewModel
{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

@end
