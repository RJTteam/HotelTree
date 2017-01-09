//
//  OrderConfirmViewController.m
//  HotelTree
//
//  Created by Shuai Wang on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "OrderConfirmViewController.h"
#import "PaymentConfirmViewController.h"
#import "ImageStoreManager.h"
#import "ModelManager.h"
#import "FlatUIKit.h"
#import "PayPalMobile.h"
#import "StripePaymentViewController.h"
#import "TWMessageBarManager.h"

@interface OrderConfirmViewController ()<PayPalPaymentDelegate,PaymentViewControllerDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *hotelName;
@property (strong, nonatomic) IBOutlet UILabel *hotelAddress;
@property (strong, nonatomic) IBOutlet UILabel *hotelRating;
@property (strong, nonatomic) IBOutlet UIImageView *hotelImage;
@property (strong, nonatomic) IBOutlet UILabel *checkInDate;
@property (strong, nonatomic) IBOutlet UILabel *checkOutDate;
@property (strong, nonatomic) IBOutlet UILabel *hotelPrice;

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet FUIButton *procceedBtn;
@property (weak, nonatomic) IBOutlet UIImageView *rateImage;
@property (strong, nonatomic) IBOutlet UIView *orderView;

@property (strong, nonatomic)PayPalConfiguration *paypalConfig;
@property (nonatomic)NSInteger numberOfDays;

@property (nonatomic)BOOL keyboardIsShowing;
@property (nonatomic)CGFloat keyboardMovingOffset;
@property(strong,nonatomic)User *userinfo;
@end

@implementation OrderConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Set home backgound image
    self.orderView.layer.contents = (__bridge id)[UIImage imageNamed:@"homeBackground"].CGImage;
    self.orderView.layer.contentsGravity = kCAGravityResizeAspectFill;
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.orderView.bounds;
    //    [self.upperSideBackView addSubview:blurEffectView];
    [self.orderView insertSubview:blurEffectView atIndex:0];
    
    ImageStoreManager *imageStoreManager = [[ImageStoreManager alloc]init];
    self.hotelName.text = self.hotel.hotelName;
    self.hotelAddress.text = self.hotel.hotelAddress;
    self.hotelRating.text = [NSString stringWithFormat:@"This property has an excellent location score of %@, based on 691 guest reviews.",self.hotel.hotelRating];
    
    self.hotelImage.image = [UIImage imageWithContentsOfFile:[imageStoreManager getImageStoreFilePathByHotelId:self.hotel.hotelId]];
    self.checkInDate.text = [self NSDateToNSString:self.order.checkInDate];
    self.checkOutDate.text = [self NSDateToNSString:self.order.checkOutDate ];
    NSTimeInterval timeinterval = [self.order.checkOutDate timeIntervalSinceDate:self.order.checkInDate];
    self.numberOfDays = timeinterval / (24 * 3600);
    self.numberOfDays = self.numberOfDays == 0 ? 1 : self.numberOfDays;
    self.hotelPrice.text = [NSString stringWithFormat:@"$ %.00f",[self.hotel.price doubleValue] * self.numberOfDays];
    
    ModelManager *userManager = [ModelManager sharedInstance];
    NSArray *users = [userManager getAllUser];
    if(users.count != 0){
        self.userinfo = users[0];
        self.emailTextField.text = self.userinfo.email;
        self.phoneTextField.text = self.userinfo.userId;
    }
    [self setUIButton:self.procceedBtn WithColorHex:@"04ACFF" Font:[UIFont boldFlatFontOfSize:20]];
    
    //add keyboard will show notification to the notification center
    self.keyboardIsShowing = NO;
    self.keyboardMovingOffset = (self.view.bounds.size.height - self.procceedBtn.frame.origin.y - self.procceedBtn.frame.size.height);
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboradWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //Prepare for paypal payment
    self.paypalConfig = [[PayPalConfiguration alloc] init];
    self.paypalConfig.acceptCreditCards = YES;
    self.paypalConfig.merchantName = @"Hotel Tree";
    self.paypalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    self.paypalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.hotel.hotelRating.intValue >= 0 && self.hotel.hotelRating.intValue < 1){
        self.rateImage.image = [UIImage imageNamed:@"Group0"];
    }else if(self.hotel.hotelRating.intValue >= 1 && self.hotel.hotelRating.intValue < 2){
        self.rateImage.image = [UIImage imageNamed:@"Group3"];
    }else if(self.hotel.hotelRating.intValue >= 2 && self.hotel.hotelRating.intValue < 3){
        self.rateImage.image = [UIImage imageNamed:@"Group3"];
    }else if(self.hotel.hotelRating.intValue >= 3 && self.hotel.hotelRating.intValue < 4){
        self.rateImage.image = [UIImage imageNamed:@"Group4"];
    }else if(self.hotel.hotelRating.intValue >= 4 && self.hotel.hotelRating.intValue < 5){
        self.rateImage.image = [UIImage imageNamed:@"Group5"];
    }
}

-(NSString*)NSDateToNSString:(NSDate*)date{
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc]init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    return [dateFormatter stringFromDate:date];
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

- (IBAction)proceedButtonClicked:(id)sender {
    if(self.emailTextField.text.length != 0 && self.phoneTextField.text.length != 0 && !self.userinfo){
        self.userinfo = [[User alloc] init];
        self.userinfo.email = self.emailTextField.text;
        self.userinfo.userId = self.phoneTextField.text;
    }
    if(self.userinfo){
        [self proceedWithActionSheet];
    }else{
         [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Invalid input" description:@"Please input the both email and mobile phone!" type:TWMessageBarMessageTypeError duration:3.0];
    }
    
}

- (void)proceedWithActionSheet{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Payment Methods" message:@"Please Choose your payment method" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *stripe = [UIAlertAction actionWithTitle:@"Credit card" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //to stripe payment page;
        StripePaymentViewController *payment = [[StripePaymentViewController alloc] initWithNibName:nil bundle:nil];
        double totalPrice = [self.hotel.price doubleValue] * self.numberOfDays;
        payment.amount = [[NSDecimalNumber alloc] initWithDouble: totalPrice];
        payment.delegate = self;
        [self.navigationController pushViewController:payment animated:YES];
        
        NSLog(@"pay with credit card");
    }];
    UIAlertAction *paypal = [UIAlertAction actionWithTitle:@"Paypal" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //to paypal payment
        NSString *description = [NSString stringWithFormat:@"Payment from %@ to %@ for %@", self.userinfo.userId, @"Hotel Tree", self.hotel.hotelName];
        double totalPrice = [self.hotel.price doubleValue] * self.numberOfDays;
        NSDecimalNumber *totalPriceNumber = [[NSDecimalNumber alloc] initWithDouble:totalPrice];
        PayPalPayment *payment = [PayPalPayment paymentWithAmount:totalPriceNumber currencyCode:@"USD" shortDescription:description intent:PayPalPaymentIntentSale];
        if(payment.processable){
            PayPalPaymentViewController *payVC = [[PayPalPaymentViewController alloc] initWithPayment:payment configuration:self.paypalConfig delegate:self];
            [self presentViewController:payVC animated:YES completion:nil];
        }
        NSLog(@"pay with Paypal account");
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:stripe];
    [alert addAction:paypal];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController
                 didCompletePayment:(PayPalPayment *)completedPayment {
    // Payment was processed successfully; send to server for verification and fulfillment.
    [self verifyCompletedPayment:completedPayment];
    
    // Dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)verifyCompletedPayment:(PayPalPayment *)completedPayment{
    double totalPrice = [self.hotel.price doubleValue] * self.numberOfDays;
    NSDecimalNumber *totalPriceNumber = [[NSDecimalNumber alloc] initWithDouble:totalPrice];
    if([completedPayment.amount isEqualToNumber:totalPriceNumber]){
        ModelManager *proceedOrder = [ModelManager sharedInstance];
        BOOL isCreateOrder = [proceedOrder createOrder:self.order.checkInDate checkOutDate:self.order.checkOutDate roomNumber:self.order.roomNumber adultNumber:self.order.adultNumber childrenNumber:self.order.childrenNumber orderStauts:@"1" userId:self.userinfo.userId hotelId:self.hotel.hotelId];
        if(isCreateOrder){
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Order processed" description:@"Order prcessed successfully! Enjoy your trip!" type:TWMessageBarMessageTypeSuccess duration:3.0f];
        }
    }
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    // The payment was canceled; dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PaymentViewControllerDelegate
- (void)paymentViewController:(StripePaymentViewController *)controller didFinish:(NSError *)error{
    if(error){
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Payment Error!" description:error.localizedDescription type:TWMessageBarMessageTypeError duration:4.0f];
    }else{
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Payment Success!" description:@"Your payment is accepted!"  type:TWMessageBarMessageTypeSuccess duration:4.0f];
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    }
}

@end
