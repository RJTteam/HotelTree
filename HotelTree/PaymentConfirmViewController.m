//
//  PaymentConfirmViewController.m
//  HotelTree
//
//  Created by Shuai Wang on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "PaymentConfirmViewController.h"
#import "ModelManager.h"

@interface PaymentConfirmViewController ()
@property (strong, nonatomic) IBOutlet UITextField *creditCardType;
@property (strong, nonatomic) IBOutlet UITextField *cardNumber;
@property (strong, nonatomic) IBOutlet UITextField *expirationDate;
@property (strong, nonatomic) IBOutlet UILabel *hotelName;
@property (strong, nonatomic) IBOutlet UILabel *CheckInDate;
@property (strong, nonatomic) IBOutlet UILabel *CheckOutDate;
@property (strong, nonatomic) IBOutlet UILabel *firstName;
@property (strong, nonatomic) IBOutlet UILabel *lastName;
@property (strong, nonatomic) IBOutlet UILabel *mobile;
@property (strong, nonatomic) IBOutlet UILabel *price;

@end

@implementation PaymentConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hotelName.text = self.hotel.hotelName;
    self.CheckInDate.text = [self NSDateToNSString:self.order.checkInDate];
    self.CheckOutDate.text = [self NSDateToNSString:self.order.checkOutDate];
    self.firstName.text = self.user.firstName;
    self.lastName.text = self.user.lastName;
    self.mobile.text = self.user.userId;
    self.price.text = self.hotel.hotelPrice;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)NSDateToNSString:(NSDate*)date{
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

- (IBAction)bookNowButtonClicked:(UIBarButtonItem *)sender {
    [[ModelManager sharedInstance] createOrder:self.order.checkInDate checkOutDate:self.order.checkOutDate roomNumber:self.order.roomNumber adultNumber:self.order.adultNumber childrenNumber:self.order.childrenNumber orderStauts:@"1" userId:self.order.userId hotelId:self.order.hotelId];
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
