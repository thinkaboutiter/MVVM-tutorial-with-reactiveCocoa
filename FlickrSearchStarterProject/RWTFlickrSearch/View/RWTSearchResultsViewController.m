//
//  Created by Colin Eberhardt on 23/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTFlickrSearch-Swift.h"

@interface RWTSearchResultsViewController () <UITableViewDataSource>

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

#pragma mark - Life cycle

static NSString* const CellIdentifier = @"cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.searchResultsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    self.searchResultsTable.dataSource = self;
    
    [self bindViewModel];
}

#pragma mark - Binding

- (void)bindViewModel
{
    self.title = self.viewModel.title;
}

#pragma mark - UITableViewDataSource protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ([self.viewModel.searchResults[indexPath.row] title]) {
        cell.textLabel.text = [self.viewModel.searchResults[indexPath.row] title];
    }
    
    return cell;
}


@end
