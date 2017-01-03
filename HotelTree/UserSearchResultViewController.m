//
//  UserSearchResultViewController.m
//  SQLiteDemo
//
//  Created by Xinyuan Wang on 12/30/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <AddressBookUI/AddressBookUI.h>
#import "UserSearchResultViewController.h"
#import "SQLiteManager.h"
#import "SearchManager.h"


//create table if not exists hotel(hotelId varchar(255)  primary key, hotelName varchar(255) not null,hotelAddress varchar(255) not null,hotelLat varchar(255) not null,hotelLong varchar(255) not null,hotelRating varchar(20) not null,hotelPrice varchar(255) not null,hotelThumb varchar(255) not null,hotelAvailableDate text not null);


@interface UserSearchResultViewController ()<UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate>

@property(strong, nonatomic)NSArray *searchResultsArray;
@property(strong, nonatomic)UISearchController *searchControl;
@property(strong, nonatomic)NSArray *searchDomains;

@property(strong, nonatomic)NSDictionary *locationDict;

@property(strong, nonatomic)CLGeocoder *coder;


@end

@implementation UserSearchResultViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    //disable editing for table view
    self.tableView.editing = NO;
    //add searchController
    self.searchControl = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchControl.dimsBackgroundDuringPresentation = NO;
    self.searchControl.searchResultsUpdater = self;
    self.definesPresentationContext = YES;
    self.searchControl.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchControl.searchBar;
    //define search domains
    self.searchDomains = @[@"hotelName",@"hotelAddress"];
    //set up navigation items
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(applyButtonClicked)];
    self.searchControl.hidesNavigationBarDuringPresentation = NO;
    
    //initialize a geocoder
    self.coder = [[CLGeocoder alloc] init];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.searchControl setActive:YES];
    [self.searchControl.searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods


- (void) applyButtonClicked{
    if([self.delegate respondsToSelector:@selector(updateSearchContent: withText:)]){
        [self.delegate updateSearchContent:self.locationDict withText:self.searchControl.searchBar.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSScanner *scanner = [[NSScanner alloc] initWithString:searchController.searchBar.text];
    
    NSString *searchKey = nil;
    NSCharacterSet *stopSet = [NSCharacterSet characterSetWithCharactersInString:@", .:;"];
    [scanner scanUpToCharactersFromSet: stopSet intoString:&searchKey];
    NSArray *result = [SearchManager searchUsingQueryWithKeys:self.searchDomains andKeyword: searchKey];
    while(!scanner.isAtEnd){
        [scanner scanUpToCharactersFromSet:stopSet intoString:&searchKey];
        result = [SearchManager searchArrayUsingPredicate:result withKeys:self.searchDomains andKeyword:searchKey];
    }
    if(result.count == 0 && searchController.searchBar.text.length >= 5){
        [self.coder geocodeAddressString:searchController.searchBar.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            if(placemarks){
                for(CLPlacemark *plcmark in placemarks){
                    NSString *address = [NSString stringWithFormat:@"%@", ABCreateStringWithAddressDictionary(plcmark.addressDictionary, YES)];
                    NSDictionary *dict = @{@"hotelName":plcmark.name,
                                           @"hotelAddress":address,
                                           @"hotelLat":[NSNumber numberWithDouble:plcmark.location.coordinate.latitude],
                                           @"hotelLong":[NSNumber numberWithDouble:plcmark.location.coordinate.longitude]};
                    if(dict.count){
                        [array addObject:dict];
                    }
                }
            }
            self.searchResultsArray = [array copy];
            [self.tableView reloadData];
        }];
    }else{
        self.searchResultsArray = result;
        [self.tableView reloadData];
    }
}

#pragma mark - UISearchControllerDelegate


#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    if([self.delegate respondsToSelector:@selector(updateSearchContent:withText:)]){
        [self.delegate updateSearchContent:@{} withText:@""];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResultsArray ? self.searchResultsArray.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dict = self.searchResultsArray[indexPath.row];
    
    cell.textLabel.text = dict[@"hotelName"];
    cell.detailTextLabel.text = dict[@"hotelAddress"];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.searchResultsArray[indexPath.row];
    self.locationDict = @{@"hotelLat":dict[@"hotelLat"],
                          @"hotelLong":dict[@"hotelLong"]};
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.searchControl.searchBar.text = [cell.textLabel.text copy];
}


@end
