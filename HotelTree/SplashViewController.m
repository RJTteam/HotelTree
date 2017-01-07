//
//  SplashViewController.m
//  HotelTree
//
//  Created by Lucas Luo on 12/30/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "SplashViewController.h"
#import "LoginViewController.h"
#import "SplashTitleAnimationView.h"
#import "UIImageView+GIF.h"

@interface SplashViewController ()
@property (weak, nonatomic) IBOutlet SplashTitleAnimationView *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *splashBackImage;

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.titleView addUntitledAnimation];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"splash" ofType:@"gif"];
    [self.splashBackImage showGifImageWithData:[NSData dataWithContentsOfFile:path]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIStoryboard *myStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginVC = [myStoryBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:loginVC animated:YES completion:nil];
    });
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
