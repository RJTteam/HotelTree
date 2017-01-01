//
//  UserSearchResultViewController.m
//  SQLiteDemo
//
//  Created by Xinyuan Wang on 12/30/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "UserSearchResultViewController.h"
#import "SQLiteManager.h"

static NSString *tablename = @"tbl_hotel";

@interface UserSearchResultViewController ()<UISearchResultsUpdating, UISearchControllerDelegate>

@property(strong, nonatomic)NSArray *searchResultsArray;
@property(strong, nonatomic)UISearchController *searchControl;
@property(strong, nonatomic)NSArray *searchDomains;

@end

@implementation UserSearchResultViewController
//static NSString *createQuery = @"create table if not exists tbl_hotel(id integer primary key autoincrement, name varchar[100], address varchar[254], latitude double, longitude double);";
//static NSString *insertTemplate = @"insert into tbl_hotel values(NULL, '%@', '%@', %f, %f);";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchControl = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchControl.dimsBackgroundDuringPresentation = NO;
    self.searchControl.searchResultsUpdater = self;
    self.definesPresentationContext = YES;
    self.tableView.tableHeaderView = self.searchControl.searchBar;
    //define search domains
    self.searchDomains = @[@"name",@"address"];
    //query for test purpose, delete after finishing
    //[[SQLiteManager shareInstance] executeQuery:createQuery];
//    [self createQueryForTest];
}
//query for test purpose, delete after finishing
//- (void)createQueryForTest{
//    
//    NSString *hotel01 = [NSString stringWithFormat:insertTemplate, @"hotel01", @"211 main street, Boston, MA, 02148", 42.394, -71.483];
//    NSString *hotel02 = [NSString stringWithFormat:insertTemplate, @"hotel02", @"211 main street, Chicago, IL, 01232", 32.394, -55.483];
//    NSString *hotel03 = [NSString stringWithFormat:insertTemplate, @"hotel03", @"211 main street, San Francisco, CA, 03123", 42.394, -44.483];
//    NSString *hotel04 = [NSString stringWithFormat:insertTemplate, @"hotel04", @"211 main street, St Charles, IL, 04323", 42.394, -33.483];
//    NSString *hotel05 = [NSString stringWithFormat:insertTemplate, @"hotel05", @"211 main street, Orlando, FL, 02356", 42.394, -22.483];
//    
//    [[SQLiteManager shareInstance] executeQuery:hotel01];
//    [[SQLiteManager shareInstance] executeQuery:hotel02];
//    [[SQLiteManager shareInstance] executeQuery:hotel03];
//    [[SQLiteManager shareInstance] executeQuery:hotel04];
//    [[SQLiteManager shareInstance] executeQuery:hotel05];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSScanner *scanner = [[NSScanner alloc] initWithString:searchController.searchBar.text];
    
    NSString *searchKey = nil;
    NSCharacterSet *stopSet = [NSCharacterSet characterSetWithCharactersInString:@", .:;"];
    [scanner scanUpToCharactersFromSet: stopSet intoString:&searchKey];
    //NSArray *result = [self searchUsingQueryWithKeys:searchDomains andKeyword: searchKey];
    while(!scanner.isAtEnd){
        [scanner scanUpToCharactersFromSet:stopSet intoString:&searchKey];
    //    result = [self searchArrayUsingPredicate:result withKeys:searchDomains andKeyword:searchKey];
    }
   // self.searchResultsArray = result;
    [self.tableView reloadData];
}

- (NSArray *)searchArrayUsingPredicate:(NSArray *)array withKeys:(NSArray *)keys andKeyword:(NSString *)keyword{
    if(!keyword){
        return @[];
    }
    NSArray *result = nil;
    for(NSString *key in keys){
        if(!result){
            NSString *format = [NSString stringWithFormat:@"%@ LIKE[c] '*%@*'",key, keyword];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:format];
            result = [array filteredArrayUsingPredicate:predicate];
            result = result.count == 0 ? nil : result;
        }
    }
    return (result != nil) ? result : @[];
}

- (NSArray *)searchUsingQueryWithKeys:(NSArray *)keys andKeyword:(NSString *)keyword{
    NSArray *result = nil;
    if(!keyword){
        return @[];
    }
    for(NSString *key in keys){
        if(!result){
            NSString *query = [NSString stringWithFormat:@"select * from %@ where %@ like '%%%@%%';",tablename, key,keyword];
            result = [[SQLiteManager shareInstance] executeQueryWithStatement:query];
            result = result.count == 0 ? nil : result;
        }
    }
    return (result != nil) ? result : @[];
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
    cell.textLabel.text = dict[@"name"];
    cell.detailTextLabel.text = dict[@"address"];
    return cell;
}


@end
