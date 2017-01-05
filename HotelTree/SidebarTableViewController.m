//
//  SidebarTableViewController.m
//  OnlineShoppingApp
//
//  Created by Lucas Luo on 12/27/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import "SidebarTableViewController.h"
#import "SWRevealViewController.h"
#import "LoginViewController.h"
#import "ModelManager.h"

@interface SidebarTableViewController ()

@end

@implementation SidebarTableViewController{
    NSArray *menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];


    menuItems = @[@"title",@"menuHome",@"menuLogOut"];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    if ([CellIdentifier isEqualToString:@"menuLogOut"]) {
        UIStoryboard *myStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginVC = [myStoryBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [[ModelManager sharedInstance] clearUserDB];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    else;
}
@end
