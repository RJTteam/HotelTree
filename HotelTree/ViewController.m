//
//  ViewController.m
//  HotelTree
//
//  Created by Yangbin on 12/30/16.
//  Copyright © 2016 com.rjtcompuquest. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    WebService* service = [WebService sharedInstance];
//
    
// --------- register
//    //hotelLat=28.6049&hotelLong=77.2235
//    NSDictionary* dic = @{
//                          @"name":@"aamir",
//                          @"email":@"aa@gmail.com",
//                          @"mobile":@"55565454",
//                          @"password":@"7011",
//                          @"userAdd":@"Delhi"
//                          };
//    
//    NSLog(@"%@",[service returnUserRegister:dic]);
    
    
//------------search
//    NSDictionary* dic = @{
//                          @"hotelLat":@"28.6049",
//                          @"hotelLong":@"77.2235"
//                          };
//    NSLog(@"%@",[service returnHotelSearch:dic]);
    
    
//-----------booking
//    NSDictionary* dic = @{
//                          @"id" : @"412",
//                          @"checkIn":@"2016-12-17 00:00:00",
//                          @"checkOut":@"2016-12-19 00:00:00",
//                          @"room":@"2",
//                          @"adult":@"2",
//                          @"child":@"1",
//                          @"booked":@"1"
//                          };
//    NSLog(@"%@",[service booking:dic]);
    
//----------- confirm
//    NSDictionary* dic =@{
//                         @"id":@"412",
//                         @"mobile":@"4564654"
//                         };
//    NSLog(@"%@",[service confirm:dic]);
    
//----------- login
//    NSDictionary* dic=@{
//                        @"mobile":@"123456789",
//                        @"password":@"789456"
//                       };
//    NSLog(@"%@",[service returenUserLogin:dic]);
    
//----------- reset password
//    NSDictionary* dic = @{
//                          @"mobile":@"55565454",
//                          @"password":@"7011",
//                          @"newpassword":@"7012"
//                          };
//    NSLog(@"%@",[service resetPassword:dic]);
    
//----------- manage booking
//    NSDictionary* dic = @{
//                          @"id":@"412",
//                          @"mobile":@"4565654"
//                          };
//    NSLog(@"%@",[service manage:dic]);
    
}

//http://rjtmobile.com/ansari/ohr/ohrapp/booking_confirmation.php?&id=412&mobile=4564654

//http://rjtmobile.com/ansari/ohr/ohrapp/ohr_reset_pass.php?&mobile=55565454&password=7011&newpassword=7012

//http://rjtmobile.com/ansari/ohr/ohrapp/ohr_login.php?&mobile=123456789&password=789456

//http://rjtmobile.com/ansari/ohr/ohrapp/booking_confirmation.php?&id=412&mobile=4564654

//http://rjtmobile.com/ansari/ohr/ohrapp/booked_hotel.php?&id=412&checkIn=2016-12-17 00:00:00&checkOut=2016-12-19 00:00:00&room=2&adult=2&child=0&booked=1

//http://rjtmobile.com/ansari/ohr/ohrapp/search_hotel.php?&hotelLat=28.6049&hotelLong=77.2235

//http://rjtmobile.com/ansari/ohr/ohrapp/ohr_reg.php?&name=aamir&email=aa@gmail.com&mobile=55565454&password=7011&userAdd=Delhi


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
