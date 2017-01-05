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
@property (strong, nonatomic) IBOutlet UITableView *sideBarBackView;

@end

@implementation SidebarTableViewController{
    NSArray *menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Set home backgound image
    self.sideBarBackView.layer.contents = (__bridge id)[UIImage imageNamed:@"homeBackground"].CGImage;
    self.sideBarBackView.layer.contentsGravity = kCAGravityResizeAspectFill;
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.sideBarBackView.bounds;
    //    [self.upperSideBackView addSubview:blurEffectView];
    [self.sideBarBackView insertSubview:blurEffectView atIndex:0];

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
