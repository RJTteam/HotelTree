//
//  ForgotPwdVC.m
//  OnlineShoppingApp
//
//  Created by Yazhong Luo on 12/22/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import "ForgotPwdVC.h"
#import "FlatUIKit.h"
#import "ResetViewController.h"

@interface ForgotPwdVC ()
@property (weak, nonatomic) IBOutlet FUIButton *submitID;
@property (weak, nonatomic) IBOutlet FUIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UITextField *userIDField;

@end

@implementation ForgotPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUIButton:self.submitID WithColorHex:@"4D68A2" Font:[UIFont systemFontOfSize:15]];
    [self setUIButton:self.cancelBtn WithColorHex:@"4D68A2" Font:[UIFont systemFontOfSize:15]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUIButton:(FUIButton *)btn WithColorHex:(NSString*)hexColor Font:(UIFont*)font{
    btn.buttonColor = [UIColor colorFromHexCode:hexColor];
    btn.shadowColor = [UIColor colorFromHexCode:@"4D68A2"];
    btn.shadowHeight = 3.0f;
    btn.cornerRadius = 4.0f;
    btn.titleLabel.font = font;
    [btn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"toReset"]) {
        ResetViewController *desitViewControl = segue.destinationViewController;
        desitViewControl.userId = self.userIDField.text;
    }

}


@end
