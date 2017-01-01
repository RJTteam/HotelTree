//
//  UserSearchResultViewController.m
//  SQLiteDemo
//
//  Created by Xinyuan Wang on 12/30/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "UserSearchResultViewController.h"
#import "SQLiteManager.h"
#import "SearchManager.h"


//create table if not exists hotel(hotelId varchar(255)  primary key, hotelName varchar(255) not null,hotelAddress varchar(255) not null,hotelLatitude varchar(255) not null,hotelLongitude varchar(255) not null,hotelRating varchar(20) not null,hotelPrice varchar(255) not null,hotelThumb varchar(255) not null,hotelAvailableDate text not null);


@interface UserSearchResultViewController ()<UISearchResultsUpdating, UISearchControllerDelegate>

@property(strong, nonatomic)NSArray *searchResultsArray;
@property(strong, nonatomic)UISearchController *searchControl;
@property(strong, nonatomic)NSArray *searchDomains;


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
    self.tableView.tableHeaderView = self.searchControl.searchBar;
    //define search domains
    self.searchDomains = @[@"hotelName",@"hotelAddress"];
    //set up navigation items
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonClicked)];
    self.searchControl.hidesNavigationBarDuringPresentation = NO;
  
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

- (void)cancelButtonClicked{
    if([self.delegate respondsToSelector:@selector(updateSearchContent:withText:)]){
        [self.delegate updateSearchContent:@{} withText:@""];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
    self.searchResultsArray = result;
    [self.tableView reloadData];
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
    if([self.delegate respondsToSelector:@selector(updateSearchContent: withText:)]){
        [self.delegate updateSearchContent:dict withText:self.searchControl.searchBar.text];
    }
}


@end
