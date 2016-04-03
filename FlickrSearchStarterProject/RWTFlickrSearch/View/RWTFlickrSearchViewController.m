//
//  Created by Colin Eberhardt on 13/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RWTFlickrSearchViewController ()

@property(nullable, weak, nonatomic) FlickrSearchViewModel* viewModel;

@property (weak, nonatomic) IBOutlet UITextField* searchTextField;
@property (weak, nonatomic) IBOutlet UIButton* searchButton;
@property (weak, nonatomic) IBOutlet UITableView* searchHistoryTable;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView* loadingIndicator;

@end

@implementation RWTFlickrSearchViewController

#pragma mark - initializers

- (instancetype)initWithViewModel:(FlickrSearchViewModel *)viewModel
{
    if (self = [super init]) {
        _viewModel = viewModel;
    }
    return self;
}

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    [self configureUI];
    [self bindViewModel];
}

#pragma mark - Configure UI (private)

- (void)configureUI
{
    self.searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
}

#pragma mark - Binding

- (void)bindViewModel
{
    self.title = self.viewModel.title;

    // signal that emits a next event containing the current text each time the text field updates
    RAC(self.viewModel, searchText) = self.searchTextField.rac_textSignal;
}


@end
