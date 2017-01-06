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

@interface OrderConfirmViewController ()<PayPalPaymentDelegate,PaymentViewControllerDelegate>
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

@property (strong, nonatomic)PayPalConfiguration *paypalConfig;
@property (nonatomic)NSInteger numberOfDays;

@property(strong,nonatomic)User *userinfo;
@end

@implementation OrderConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ImageStoreManager *imageStoreManager = [[ImageStoreManager alloc]init];
    self.hotelName.text = self.hotel.hotelName;
    self.hotelAddress.text = self.hotel.hotelAddress;
    self.hotelRating.text = [NSString stringWithFormat:@"This property has an excellent location score of %@, based on 691 guest reviews.",self.hotel.hotelRating];
    
    self.hotelImage.image = [UIImage imageWithContentsOfFile:[imageStoreManager getImageStoreFilePathByHotelId:self.hotel.hotelId]];
    self.checkInDate.text = [self NSDateToNSString:self.order.checkInDate];
    self.checkOutDate.text = [self NSDateToNSString:self.order.checkOutDate ];
    NSTimeInterval timeinterval = [self.order.checkOutDate timeIntervalSinceDate:self.order.checkInDate];
    self.numberOfDays = timeinterval / (24 * 3600);
    self.hotelPrice.text = [NSString stringWithFormat:@"$ %.00f",[self.hotel.price doubleValue] * self.numberOfDays];
    
    ModelManager *userManager = [ModelManager sharedInstance];
    NSArray *users = [userManager getAllUser];
    if(users.count != 0){
        self.userinfo = users[0];
        self.emailTextField.text = self.userinfo.email;
        self.phoneTextField.text = self.userinfo.userId;
    }
    [self setUIButton:self.procceedBtn WithColorHex:@"04ACFF" Font:[UIFont boldFlatFontOfSize:20]];
    
    //Prepare for paypal payment
    self.paypalConfig = [[PayPalConfiguration alloc] init];
    self.paypalConfig.acceptCreditCards = YES;
    self.paypalConfig.merchantName = @"Hotel Tree";
    self.paypalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    self.paypalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
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

- (IBAction)proceedButtonClicked:(id)sender {
    
    

    if(self.userinfo){
        [self proceedWithActionSheet];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
