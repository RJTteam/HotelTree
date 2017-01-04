//
//  RegisterViewController.m
//  OnlineShoppingApp
//
//  Created by Yazhong Luo on 12/20/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import "RegisterViewController.h"
#import "JVFloatLabeledTextField.h"
#import "FlatUIKit.h"
#import <TWMessageBarManager/TWMessageBarManager.h>
#import "ModelManager.h"

@import UITextField_Shake;

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *nameField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *phoneField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *passwordField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *emailField;

@property (weak, nonatomic) IBOutlet FUIButton *registerBtn;

@property (weak, nonatomic) IBOutlet FUIButton *backToSignin;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUIButton:self.registerBtn WithColorHex:@"FFFFFF" Font:[UIFont boldFlatFontOfSize:20]];
    [self.registerBtn setTitleColor:[UIColor colorFromHexCode:@"CC3333"] forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor colorFromHexCode:@"CC3333"] forState:UIControlStateHighlighted];
    [self setUIButton:self.backToSignin WithColorHex:@"CC3333" Font:[UIFont boldFlatFontOfSize:20]];
    
    [TWMessageBarManager sharedInstance];
}


- (IBAction)registerNewBtn:(id)sender {
    NSDictionary *registureInfo = @{
                                    @"name":self.nameField.text,
                                    @"email":self.emailField.text,
                                    @"mobile":self.phoneField.text,
                                    @"password":self.passwordField.text,
                                    @"IsManage":@"1"
                                    };
    [[ModelManager sharedInstance] userRegisterToServer:registureInfo completionHandler:^(NSString *status) {
        if(![status containsString:@"success"]){
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Account Info" description:status type:TWMessageBarMessageTypeError];
            [self.phoneField shake];
            return;
        }
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Account Info" description:status type:TWMessageBarMessageTypeSuccess];
        NSUserDefaults*userInfo = [NSUserDefaults standardUserDefaults];
        [userInfo setObject:registureInfo[@"mobile"] forKey:@"userID"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)setUIButton:(FUIButton *)btn WithColorHex:(NSString*)hexColor Font:(UIFont*)font{
    btn.buttonColor = [UIColor colorFromHexCode:hexColor];
    btn.shadowColor = [UIColor colorFromHexCode:@"4D68A2"];
    btn.shadowHeight = 3.0f;
    btn.cornerRadius = 4.0f;
    btn.titleLabel.font = font;
    [btn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    //    return btn;
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
