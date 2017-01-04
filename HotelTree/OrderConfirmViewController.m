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

@interface OrderConfirmViewController ()
@property (strong, nonatomic) IBOutlet UILabel *hotelName;
@property (strong, nonatomic) IBOutlet UILabel *hotelAddress;
@property (strong, nonatomic) IBOutlet UILabel *hotelRating;
@property (strong, nonatomic) IBOutlet UIImageView *hotelImage;
@property (strong, nonatomic) IBOutlet UILabel *checkInDate;
@property (strong, nonatomic) IBOutlet UILabel *checkOutDate;
@property (strong, nonatomic) IBOutlet UILabel *hotelPrice;
@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet FUIButton *procceedBtn;
@property (weak, nonatomic) IBOutlet UIImageView *rateImage;

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
    
    self.checkInDate.text = self.bookingInfo[@"checkIn"];
    self.checkOutDate.text = self.bookingInfo[@"checkOut"];
    self.hotelPrice.text = self.hotel.price;
    
    
    ModelManager *userManager = [[ModelManager alloc]init];
    NSArray*user = [userManager getAllUser];
    self.userinfo = [user objectAtIndex:0];
    
    self.firstNameTextField.text = self.userinfo.firstName;
    self.lastNameTextField.text = self.userinfo.lastName;
    self.emailTextField.text = self.userinfo.email;
    self.phoneTextField.text = self.userinfo.userId;
    
    [self setUIButton:self.procceedBtn WithColorHex:@"04ACFF" Font:[UIFont boldFlatFontOfSize:20]];
}

-(NSString*)NSDateToNSString:(NSDate*)date{
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
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
    
    
    ModelManager *proceedOrder = [[ModelManager alloc]init];
    BOOL isCreateOrder = [proceedOrder createOrder:self.bookingInfo[@"checkIn"] checkOutDate:self.bookingInfo[@"checkOut"] roomNumber:self.bookingInfo[@"room"] adultNumber:self.bookingInfo[@"adult"] childrenNumber:self.bookingInfo[@"child"] orderStauts:@"1" userId:self.userinfo.userId hotelId:self.hotel.hotelId];
    NSLog(@"new order %@",isCreateOrder? @"yes":@"no");

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
