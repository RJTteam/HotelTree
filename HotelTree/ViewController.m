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
    WebService* service = [WebService sharedInstance];
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
//    NSArray* arr = [service returnHotelSearch:dic];
//    for(HotelSearch * h in arr){
//        NSLog(@"%@",h.hotelImages);
//    }
    
    
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
    NSDictionary* dic = @{
                          @"hotel_id":@"408",
                          @"mobile":@"5555454",
                          @"hotel_name":@"Park Hyatt",
                          @"checkIn":@"2016-12-17 00:00:00",
                          @"checkOut":@"2016-12-19 00:00:00",
                          @"room":@"3",
                          @"adult":@"4",
                          @"child":@"2",
                          @"booked":@"0"
                          };
    NSLog(@"%@",[service manage:dic]);
    
}

//http://rjtmobile.com/ansari/ohr/ohrapp/booking_confirmation.php?&id=412&mobile=4564654

//http://rjtmobile.com/ansari/ohr/ohrapp/ohr_reset_pass.php?&mobile=55565454&password=7011&newpassword=7012

//http://rjtmobile.com/ansari/ohr/ohrapp/ohr_login.php?&mobile=123456789&password=789456


//http://rjtmobile.com/ansari/ohr/ohrapp/manage_booking.php?&hotel_id=408&hotel_name=Park Hyatt&checkIn=2016-12-17 00:00:00&checkOut=2016-12-19 00:00:00&room=3&adult=4&child=2&booked=0&mobile=5555454


//http://rjtmobile.com/ansari/ohr/ohrapp/booked_hotel.php?&id=412&checkIn=2016-12-17 00:00:00&checkOut=2016-12-19 00:00:00&room=2&adult=2&child=0&booked=1

//http://rjtmobile.com/ansari/ohr/ohrapp/search_hotel.php?&hotelLat=28.6049&hotelLong=77.2235

//http://rjtmobile.com/ansari/ohr/ohrapp/ohr_reg.php?&name=aamir&email=aa@gmail.com&mobile=55565454&password=7011&userAdd=Delhi

//rheuhtuer


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
