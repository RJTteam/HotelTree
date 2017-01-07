//
//  PaymentViewController.m
//
//  Created by Alex MacCaw on 2/14/13.
//  Copyright (c) 2013 Stripe. All rights reserved.
//

#import <Stripe/Stripe.h>
#import "StripePaymentViewController.h"
#import <FlatUIKit/FlatUIKit.h>

@interface StripePaymentViewController () <STPPaymentCardTextFieldDelegate>
@property (weak, nonatomic) STPPaymentCardTextField *paymentTextField;
@property (weak, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong , nonatomic)FUIButton *saveButton;
@end

@implementation StripePaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Pay by Credit";
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // Setup save button
    NSString *title = [NSString stringWithFormat:@"Pay $%@", self.amount];
    [self setUIButton:self.saveButton WithColorHex:@"E04934" Font:[UIFont boldFlatFontOfSize:20]];
    self.saveButton = [FUIButton buttonWithType:UIButtonTypeCustom];
    [self.saveButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    self.saveButton.enabled = NO;
    [self.saveButton setTitle:title forState:UIControlStateNormal];
    
//    self.saveButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.saveButton.layer.borderWidth = 1.0f;
//    [self.saveButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
//    [self.saveButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//    self.saveButton.layer.shadowOffset = CGSizeMake(0.1, 0.7);
//    self.saveButton.layer.cornerRadius = 5.0;
    [self.view addSubview:self.saveButton];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    // Setup payment view
    STPPaymentCardTextField *paymentTextField = [[STPPaymentCardTextField alloc] init];
    paymentTextField.delegate = self;
    self.paymentTextField = paymentTextField;
    [self.view addSubview:paymentTextField];
    
    // Setup Activity Indicator
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator = activityIndicator;
    [self.view addSubview:activityIndicator];
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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat padding = 15;
    CGFloat width = CGRectGetWidth(self.view.frame) - (padding * 2);
    self.paymentTextField.frame = CGRectMake(padding, padding, width, 44);
    CGSize buttonSize = CGSizeMake(120, 44);
    CGFloat buttonX = CGRectGetMaxX(self.view.frame) - padding - buttonSize.width;
    CGFloat buttonY = 2 * padding + 44;
    self.saveButton.frame = CGRectMake(buttonX, buttonY, buttonSize.width, buttonSize.height);
    self.activityIndicator.center = self.view.center;
}

- (void)paymentCardTextFieldDidChange:(nonnull STPPaymentCardTextField *)textField {
    if (textField.isValid){
        self.saveButton.enabled = textField.isValid;
    }
}

- (void)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)save:(id)sender {
    if (![self.paymentTextField isValid]) {
        return;
    }
    if (![Stripe defaultPublishableKey]) {
        NSError *error = [NSError errorWithDomain:StripeDomain
                                             code:STPInvalidRequestError
                                         userInfo:@{
                                                    NSLocalizedDescriptionKey: @"pk_test_hmDF7oxPo26peQ0IfJA30NoD"
                                                    }];
        [self.delegate paymentViewController:self didFinish:error];
        return;
    }
    [self.activityIndicator startAnimating];
    [[STPAPIClient sharedClient] createTokenWithCard:self.paymentTextField.cardParams
                                          completion:^(STPToken *token, NSError *error) {
                                              [self.activityIndicator stopAnimating];
                                              if (error == nil) {
                                                  [self.delegate paymentViewController:self didFinish:error];
                                              }
                                          }];
}

@end
