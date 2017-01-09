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

@interface RegisterViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *nameField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *phoneField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *passwordField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *emailField;

@property (weak, nonatomic) IBOutlet FUIButton *registerBtn;

@property (weak, nonatomic) IBOutlet FUIButton *backToSignin;

@property (nonatomic)BOOL keyboardIsShowing;
@property (nonatomic)CGFloat keyboardMovingOffset;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUIButton:self.registerBtn WithColorHex:@"009051" Font:[UIFont boldFlatFontOfSize:20]];
    [self.registerBtn setTitleColor:[UIColor colorFromHexCode:@"FFFFFF"] forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor colorFromHexCode:@"CC3333"] forState:UIControlStateHighlighted];
    [self setUIButton:self.backToSignin WithColorHex:@"CC3333" Font:[UIFont boldFlatFontOfSize:20]];
    
    [TWMessageBarManager sharedInstance];
    self.keyboardIsShowing = NO;
    self.keyboardMovingOffset = self.view.bounds.size.height - self.backToSignin.frame.origin.y - self.backToSignin.frame.size.height;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboradWillHide:) name:UIKeyboardWillHideNotification object:nil];
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

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    CGSize keyboardSize = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGFloat moveOffset = keyboardSize.height - self.keyboardMovingOffset;
    if(!self.keyboardIsShowing){
        self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height- moveOffset);
        self.keyboardIsShowing = YES;
    }
}

- (void)keyboradWillHide:(NSNotification *)notification{
    CGSize keyboardSize = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGFloat moveOffset = keyboardSize.height - self.keyboardMovingOffset;
    if(self.keyboardIsShowing){
        self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height + moveOffset);
        self.keyboardIsShowing = NO;
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
    //    return btn;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
