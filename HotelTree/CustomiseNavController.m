//
//  CustomiseNavController.m
//  HotelTree
//
//  Created by Lucas Luo on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "CustomiseNavController.h"
#import "UIColor+Hexadecimal.h"
#import "UINavigationBar+Addition.h"

@interface CustomiseNavController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation CustomiseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithHexString:@"13347B"]];
    [self.navBar setTranslucent:YES];
    [self.navBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navBar.backgroundColor = [UIColor clearColor];
    self.navBar.shadowImage = [UIImage new];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
