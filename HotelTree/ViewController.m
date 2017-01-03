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
    //hotelLat=28.6049&hotelLong=77.2235
//    NSDictionary* dic = @{
//                          @"name":@"aamir",
//                          @"email":@"aa@gmail.com",
//                          @"mobile":@"55555555",
//                          @"password":@"7011",
//                          @"IsManager":@"0"
//                          };
//    
//    //NSLog(@"%@",[service returnUserRegister:dic]);
//    [service returnUserRegister:dic completionHandler:^(NSString* registerInfo, NSError* error,NSString* httpStatus){
//        if( error && httpStatus )
//        {
//            NSLog(@"web connection wrong");
//        }
//        NSLog(@"register : %@",registerInfo);
//    }];
    
////http://rjtmobile.com/ansari/hms/hmsapp/hms_reg.php?name=aamir&email=aa@gmail.com&mobile=55555555&password=7011&IsManage=0
    
    
//------------search
//    NSDictionary* dic = @{
//                          @"hotelLat":@"28.6049",
//                          @"hotelLong":@"77.2235"
//                          };
//    //NSArray* arr = [service returnHotelSearch:dic];
//    [service returnHotelSearch:dic completionHandler:^(NSArray* array,NSError* error,NSString* httpStatus){
//        if( error && httpStatus )
//        {
//            NSLog(@"web connection wrong");
//        }else{
//            for(Hotel * h in array){
//                NSLog(@"%@",h.hotelThumb);
//            }
//        }
//    }];
    
    
    
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
//    [service booking:dic completionHandler:^(NSString* bookingIfo,NSError* error,NSString* httpStatus){
//        if( error && httpStatus )
//        {
//            NSLog(@"web connection wrong");
//        }else{
//            NSLog(@"booking : %@",bookingIfo);
//        }
//    }];

    
//----------- confirm
//    NSDictionary* dic =@{
//                         @"id":@"412",
//                         @"mobile":@"4564654"
//                         };
//    [service confirm:dic completionHandler:^(NSMutableArray *confirmInfo,NSError* error,NSString* httpStatus) {
//        if( error && httpStatus )
//        {
//            NSLog(@"web connection wrong");
//        }else{
//            NSLog(@"confirm: %@",confirmInfo);
//        }
//    }];
    
//----------- login
//    NSDictionary* dic=@{
//                        @"mobile":@"55555555",
//                        @"password":@"7011",
//                        @"IsManager":@"1"
//                       };
//    [service returenUserLogin:dic completionHandler:^(NSDictionary* loginInfo,NSError* error,NSString* httpStatus) {
//        if( error && httpStatus )
//        {
//            NSLog(@"web connection wrong");
//        }else{
//            NSLog(@"%@",loginInfo);
//        }
//    }];
    
    //http://rjtmobile.com/ansari/hms/hmsapp/hms_login.php?mobile=55555555&password=7011&IsManager=1

//----------- reset password
    NSDictionary* dic = @{
                          @"mobile":@"55565454",
                          @"password":@"7011",
                          @"newpassword":@"7012"
                          };
    [service resetPassword:dic completionHandler:^(NSString *resetInfo,NSError* error,NSString* httpStatus) {
        if( error && httpStatus )
        {
            NSLog(@"web connection wrong");
        }else{
            NSLog(@"%@",resetInfo);
        }
    }];
    
//----------- manage booking
//    NSDictionary* dic = @{
//                          @"hotel_id":@"41134",
//                          @"mobile":@"5555454",
//                          @"hotel_name":@"ParkHyatt",
//                          @"checkIn":@"2016-12-17 00:00:00",
//                          @"checkOut":@"2016-12-19 00:00:00",
//                          @"room":@"3",
//                          @"adult":@"4",
//                          @"child":@"2",
//                          @"booked":@"0"
//                          };
//    [service manage:dic completionHandler:^(NSString *manageInfo,NSError* error,NSString* httpStatus) {
//        if( error && httpStatus )
//        {
//            NSLog(@"web connection wrong");
//        }else{
//            NSLog(@"%@",manageInfo);
//        }
//    }];
    
    //http://rjtmobile.com/ansari/ohr/ohrapp/manage_booking.php?&hotel_id=408&hotel_name=Park Hyatt&checkIn=2016-12-17 00:00:00&checkOut=2016-12-19 00:00:00&room=3&adult=4&child=2&booked=0&mobile=5555454
    
    
//------------ history
//    NSDictionary* dic = @{
//                          @"mobile":@"5555454"
//                          };
//    [service history:dic completionHandler:^(NSMutableArray *historyInfo,NSError* error,NSString* httpStatus) {
//        if( error && httpStatus )
//        {
//            NSLog(@"web connection wrong");
//        }else{
//            NSLog(@"%@",historyInfo) ;
//        }
//    }];

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
