//
//  LoginViewController.m
//  OnlineShoppingApp
//
//  Created by Yazhong Luo on 12/20/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import "LoginViewController.h"
#import "JVFloatLabeledTextField.h"
#import "FlatUIKit.h"
#import "HotelBack0View.h"
#import <TWMessageBarManager/TWMessageBarManager.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ModelManager.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *phoneField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *passwordField;

@property (weak, nonatomic) IBOutlet FUIButton *signinButton;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *signinFacebook;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;

@property (weak, nonatomic) IBOutlet UIButton *resetPWDButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;


@property (nonatomic)BOOL keyboardIsShowing;
@property (nonatomic)CGFloat keyboardMovingOffset;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HotelBack0View *backview = [[HotelBack0View alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [backview addHotelBackGroundAnimation];
    [self.view insertSubview:backview atIndex:0];
    self.keyboardIsShowing = NO;
    self.phoneField.delegate = self;
    self.passwordField.delegate = self;
    [self setUIButton:self.signinButton WithColorHex:@"0099FF" Font:[UIFont boldFlatFontOfSize:20]];
    [[self.skipButton layer] setBorderWidth:2.0f];
    [[self.skipButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[self.resetPWDButton layer] setBorderWidth:2.0f];
    [[self.resetPWDButton layer] setBorderColor:[UIColor colorFromHexCode:@"0066FF"].CGColor];
    [[self.registerButton layer] setBorderWidth:2.0f];
    [[self.registerButton layer] setBorderColor:[UIColor colorFromHexCode:@"0066FF"].CGColor];
    [TWMessageBarManager sharedInstance];
    NSUserDefaults *savedUserInfo = [NSUserDefaults standardUserDefaults];
    NSString *mobile = [savedUserInfo objectForKey:@"userID"];
    if(mobile){
        self.phoneField.text = mobile;
    }

    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    self.signinFacebook = loginButton;
    loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    
//     [GIDSignIn sharedInstance].uiDelegate = self;
    self.passwordField.secureTextEntry = YES;
    
    self.keyboardMovingOffset = (self.view.bounds.size.height - self.signinButton.frame.origin.y - self.signinButton.frame.size.height);
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboradWillHide:) name:UIKeyboardWillHideNotification object:nil];
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
        self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height - moveOffset);
        self.keyboardIsShowing = YES;
    }
}

- (void)keyboradWillHide:(NSNotification *)notification{
    if(self.keyboardIsShowing){
        CGSize keyboardSize = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        CGFloat moveOffset = keyboardSize.height - self.keyboardMovingOffset;
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

- (IBAction)signInClicked:(id)sender {
    NSDictionary *signInDic = @{
                                @"mobile":self.phoneField.text,
                                @"password":self.passwordField.text
                                };
    [[ModelManager sharedInstance] loginValidate:signInDic completionHandler:^(NSDictionary *loginInfo) {
        NSString *status = loginInfo[@"msg"];
        if(self.phoneField.text.length == 0 || self.passwordField.text.length == 0){
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"A Problem Occured!"
                                                                        description:@"Your id or password cannot be empty."
                                                                               type:TWMessageBarMessageTypeError duration:5.0];
            return;
        }
        if([status isKindOfClass:[NSArray class]]){
            if(![[(NSArray *)status objectAtIndex:0] containsString:@"success"]){
                [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Incorrect userId or password" description:@"The phone number or password is not valid, please try again" type:TWMessageBarMessageTypeError duration:3.0];
                return;
            }
        }
        
        if([status isKindOfClass:[NSString class]]){
            if([status containsString:@"success"]){
                NSUserDefaults*userInfo = [NSUserDefaults standardUserDefaults];
                [userInfo setObject:loginInfo[@"UserMobile"] forKey:@"userID"];
                [[ModelManager sharedInstance] createUser:loginInfo[@"UserMobile"] password:signInDic[@"password"] userName:loginInfo[@"UserName"] firstName:nil lastName:nil email:loginInfo[@"UserEmail"] userAddress:nil isManager:loginInfo[@"IsManager"]];
                [self performSegueWithIdentifier:@"loginToHome" sender:nil];
            }
        }
    }];
}

- (IBAction)facebookSignInBtn:(id)sender {
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
    }
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc]init];
    [loginManager logInWithReadPermissions:@[@"email"]fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        NSLog(@"result is %@",result);
        
    }];
}

- (IBAction)skipBtnClick:(id)sender {
    [self performSegueWithIdentifier:@"loginToHome" sender:nil];
    NSUserDefaults*userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo removeObjectForKey:@"userID"];
}

-(IBAction)exitFromReset:(UIStoryboardSegue *)unwindsegue {
}

-(IBAction)exitFromSignOn:(UIStoryboardSegue *)unwindsegue {
    
}

-(IBAction)exitFromCancel:(UIStoryboardSegue *)unwindsegue {
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
