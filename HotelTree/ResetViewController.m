//
//  ResetViewController.m
//  OnlineShoppingApp
//
//  Created by Yazhong Luo on 12/20/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import "ResetViewController.h"
#import "FlatUIKit.h"
#import <TWMessageBarManager/TWMessageBarManager.h>
@import UITextField_Shake;

@interface ResetViewController ()
@property (weak, nonatomic) IBOutlet FUIButton *submitButton;
@property (weak, nonatomic) IBOutlet FUIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UITextField *oldPwdField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmField;

@end

@implementation ResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUIButton:self.submitButton WithColorHex:@"4D68A2" Font:[UIFont systemFontOfSize:15]];
    [self setUIButton:self.cancelBtn WithColorHex:@"4D68A2" Font:[UIFont systemFontOfSize:15]];
    [TWMessageBarManager sharedInstance];
}



- (IBAction)resetPwdSubmit:(id)sender {

    
    if (self.passwordField.text != self.confirmField.text) {
        [self.passwordField shake];
        [self.confirmField shake];
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"PassWord mismatch!"
                                                       description:@""
                                                              type:TWMessageBarMessageTypeInfo];
    }
    else{
//    NSString *resetUser = [[WebServiceManager sharedInstance] resetPwdWithID:self.userId OldPassword:self.oldPwdField.text AndNewPwd:self.passwordField.text];
//    [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Account Updated!"
//                                                   description:resetUser
//                                                          type:TWMessageBarMessageTypeSuccess];
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
