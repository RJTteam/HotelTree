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
    self.checkOutDate.text = [self NSDateToNSString:self.order.checkOutDate];
    
    self.hotelPrice.text = self.hotel.hotelPrice;
    
    self.firstNameTextField.text = self.user.firstName;
    self.lastNameTextField.text = self.user.lastName;
    self.emailTextField.text = self.user.email;
    self.phoneTextField.text = self.user.userId;
}

-(NSString*)NSDateToNSString:(NSDate*)date{
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

- (IBAction)proceedButtonClicked:(UIBarButtonItem *)sender {
    PaymentConfirmViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PaymentConfirmViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
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
