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
#import "UIImageView+GIF.h"
#import <TWMessageBarManager/TWMessageBarManager.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ModelManager.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *phoneField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *passwordField;

@property (weak, nonatomic) IBOutlet FUIButton *signinButton;
@property (weak, nonatomic) IBOutlet FUIButton *signinGoogle;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *signinFacebook;

@property (weak, nonatomic) IBOutlet UIButton *resetPWDButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UIImageView *loginGifbackView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUIButton:self.signinButton WithColorHex:@"0099FF" Font:[UIFont boldFlatFontOfSize:20]];
    [self setUIButton:self.signinGoogle WithColorHex:@"E04934" Font:[UIFont boldFlatFontOfSize:20]];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"loginBack" ofType:@"gif"];
    [self.loginGifbackView showGifImageWithData:[NSData dataWithContentsOfFile:path]];
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
            if(![status containsString:@"success"]){
                [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Incorrect userId or password" description:@"The phone number or password is not valid, please try again" type:TWMessageBarMessageTypeError duration:3.0];
                return;
            }
        }
        
        if([status isKindOfClass:[NSString class]]){
            if([status containsString:@"success"]){
                NSUserDefaults*userInfo = [NSUserDefaults standardUserDefaults];
                [userInfo setObject:loginInfo[@"UserMobile"] forKey:@"userID"];
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


-(IBAction)exitFromReset:(UIStoryboardSegue *)unwindsegue {
}

-(IBAction)exitFromSignOn:(UIStoryboardSegue *)unwindsegue {
    
}

-(IBAction)exitFromCancel:(UIStoryboardSegue *)unwindsegue {
    
}
@end
