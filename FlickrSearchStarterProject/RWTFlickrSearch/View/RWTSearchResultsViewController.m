//
//  Created by Colin Eberhardt on 23/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTFlickrSearch-Swift.h"
#import "CETableViewBindingHelper.h"
#import "RWTSearchResultsTableViewCell.h"

@interface RWTSearchResultsViewController ()

// `viewModel`
@property (nonnull, nonatomic, strong) SearchResultsViewModel* viewModel;

// `bindingHelper`
@property (nonnull, nonatomic, strong) CETableViewBindingHelper* bindingHelper;

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

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self bindViewModel];
}

#pragma mark - Binding

- (void)bindViewModel
{
    self.title = self.viewModel.title;
    
    UINib* nib = [UINib nibWithNibName:NSStringFromClass([RWTSearchResultsTableViewCell class]) bundle:nil];
    self.bindingHelper = [CETableViewBindingHelper bindingHelperForTableView:self.searchResultsTable
                                                            sourceSignal:RACObserve(self.viewModel, searchResultsArray)
                                                        selectionCommand:nil
                                                            templateCell:nib];
}


@end
