//
//  MainViewController.m
//  ArrayDataSourceExample
//
//  Created by Angel on 4/9/14.
//  Copyright (c) 2014 Angel Casado. All rights reserved.
//

#import "MainViewController.h"
#import "NumbersArrayDataSource.h"
#import "Number.h"
#import "NumberCell.h"

@interface MainViewController () <ArrayDataSourcePaginationDelegate>

@property (nonatomic, strong) NumbersArrayDataSource *numbersDataSource;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    TableViewCellConfigureBlock configureCell = ^(NumberCell *cell, Number *number) {
        cell.numberLabel.text = [NSString stringWithFormat:@"Number: %ld", number.title];
    };
    self.numbersDataSource = [[NumbersArrayDataSource alloc] initWithURL:nil cellIdentifier:@"NumberCell" configureCellBlock:configureCell];
    self.numbersDataSource.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self.numbersDataSource;
    [self.tableView registerNib:[NumberCell nib] forCellReuseIdentifier:@"NumberCell"];
    [self setupTableViewFooter];
    [self.numbersDataSource loadNextPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableViewFooter
{
    UIView *loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60.0f)];
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    CGFloat XCenter = (CGRectGetWidth(loadingView.frame) / 2) - (CGRectGetWidth(activityIndicatorView.frame) / 2);
    CGFloat YCenter = (CGRectGetHeight(loadingView.frame) / 2) - (CGRectGetHeight(activityIndicatorView.frame) / 2);
    
    activityIndicatorView.center = CGPointMake(XCenter, YCenter);
    activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicator = activityIndicatorView;
    [loadingView addSubview:activityIndicatorView];
    
    self.tableView.tableFooterView = loadingView;
}

- (void)paginatorWillLoadResults
{
    NSLog(@"Start the loading spinner");
    [self.activityIndicator startAnimating];
    self.tableView.tableFooterView.hidden = NO;
    [self.tableView reloadData];
}

- (void)paginatorDidLoadResults
{
    NSLog(@"Hide the spinner");
    [self.activityIndicator stopAnimating];
    self.tableView.hidden = NO;
    self.tableView.tableFooterView.hidden = YES;
    [self.tableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height)) {
        NSLog(@"Reaching near the bottom; load the next page.");
        [self.numbersDataSource loadNextPage];
    }
}

@end
