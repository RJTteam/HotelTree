//
//  WebService.m
//  HotelTree
//
//  Created by Yangbin on 12/31/16.
//  Copyright © 2016 com.rjtcompuquest. All rights reserved.
//

#import "WebService.h"

@implementation WebService

+(instancetype)sharedInstance{
    static WebService* mfs_Instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mfs_Instance = [ [ WebService alloc ] init ];
        mfs_Instance.provider = [ [ WebServiceProvider alloc ] init ];
//        WebServiceProvider* wp = [ [ WebServiceProvider alloc ] init ];
//        wp.delegate = mfs_Instance;
    });
    return mfs_Instance;
}

//-(NSData*)passData:(NSData *)theData{
//    return theData;
//}


- (void) returnUserLogin:(NSDictionary*)dic completionHandler:(void(^)(NSDictionary* loginInfo, NSError* error,NSString* httpStatus))completionBlock{
    
    [self.provider webServiceCall:@"hms/hmsapp/hms_login.php" with:dic withHandler:^(NSData* data,NSError* error,NSString* httpStatus){
        //NSLog(@"data : %@",data);
        self.output = data;
        id jsonOutput = [NSJSONSerialization JSONObjectWithData:self.output options:NSJSONReadingAllowFragments error:nil];
        NSArray* arr = jsonOutput;
        
        NSDictionary* dic = [arr objectAtIndex:0];
        if(completionBlock) {
            completionBlock(dic,error,httpStatus);
        }
        
        
    }];
    //NSLog(@"from wevservice data : %@",self.output);
    
}

-(void)returnUserRegister:(NSDictionary*)dic completionHandler:(void(^)(NSString* registerInfo,NSError* error,NSString* httpStatus))completionBlock{
//    UserRegister* user = [[UserRegister alloc]init];
    
    [self.provider webServiceCall:@"hms/hmsapp/hms_reg.php" with:dic withHandler:^(NSData* data, NSError* error,NSString* httpStatus){
//        if( error != nil )
//        {
//            completionBlock( nil, error );
//            return;
//        }
        NSString* str;
        self.output = data;
        id jsonOutput = [NSJSONSerialization JSONObjectWithData:self.output options:NSJSONReadingAllowFragments error:nil];
        if([jsonOutput isKindOfClass:[NSString class]]){
            str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        }
        if([jsonOutput isKindOfClass:[NSDictionary class]]){
            NSDictionary* dic = jsonOutput;
            str = [[dic objectForKey:@"msg"]objectAtIndex:0];
        }else{
            str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
        if(completionBlock){
            completionBlock(str,error,httpStatus);
        }
    }];
    //id jsonOutput = [NSJSONSerialization JSONObjectWithData:output options:NSJSONReadingMutableLeaves error:nil];
    
//    NSDictionary* outDic = jsonOutput;
//    if([outDic objectForKey:@"Error"]){
//        user.userId = nil;
//        user.userEmail = nil;
//    }else{
//        user.userId = [[outDic objectForKey:@"Success"] objectForKey:@"userID"];
//        user.userEmail = [[outDic objectForKey:@"Success"] objectForKey:@"userEmail"];
//    }
//    
//    return user;
    
}

-(void)returnHotelSearch:(NSDictionary*)dic completionHandler:(void(^)(NSArray* array, NSError* error,NSString* httpStatus))completionBlock{
    
    [self.provider webServiceCall:@"ohr/ohrapp/search_hotel.php" with:dic withHandler:^(NSData* data,NSError* error,NSString* httpStatus){
        NSMutableArray* arr = [[NSMutableArray alloc]init];
        self.output = data;
        id jsonOutput = [NSJSONSerialization JSONObjectWithData:self.output options:NSJSONReadingAllowFragments error:nil];
        NSDictionary* outDic = jsonOutput;
        NSArray* array = [outDic objectForKey:@"Hotels"];
        for(NSDictionary* d in array){
            Hotel* hotel = [[Hotel alloc]initWithDictionary:d];
            [arr addObject:hotel];
        }
        if(completionBlock){
            completionBlock(arr,error,httpStatus);
        }
    }];
//    id jsonOutput = [NSJSONSerialization JSONObjectWithData:self.output options:NSJSONReadingAllowFragments error:nil];
//    NSDictionary* outDic = jsonOutput;
//    NSArray* array = [outDic objectForKey:@"Hotels"];
//    for(NSDictionary* d in array){
//        Hotel* hotel = [[Hotel alloc]initWithDictionary:d];
//        
////        hotel.hotelId = [d objectForKey:@"hotelId"];
////        hotel.hotelName = [d objectForKey:@"hotelName"];
////        hotel.hotelPrice = [d objectForKey:@"price"];
////        hotel.hotelAddress = [d objectForKey:@"hotelAdd"];
////        hotel.hotelRating = [d objectForKey:@"hotelRating"];
////        hotel.hotelLatitude = [d objectForKey:@"hotelLat"];
////        hotel.hotelLongitude = [d objectForKey:@"hotelLong"];
////        hotel.hotelImages = [d objectForKey:@"hotelThumb"];
//        
//        [arr addObject:hotel];
//    }
    //NSLog(@"from service %@",arr);
    //return arr;
}

//{
//    "hotelId": "408",
//    "hotelName": "Park Hyatt ",
//    "hotelAdd": "Chicago",
//    "hotelLat": "41.8970",
//    "hotelLong": "87.6251",
//    "hotelRating": "5",
//    "price": "5000",
//    "hotelThumb": "http:\/\/rjtmobile.com\/ansari\/ohr\/admin\/uploads\/hotel_image\/perth_hayat.jpg"
//}

-(void)booking:(NSDictionary*)dic completionHandler:(void(^)(NSString* bookingInfo, NSError* error,NSString* httpStatus))completionBlock{
    
    [self.provider webServiceCall:@"ohr/ohrapp/booked_hotel.php" with:dic withHandler:^(NSData* data,NSError* error,NSString* httpStatus){
        NSString* result;
        self.output = data;
        id jsonOutput = [NSJSONSerialization JSONObjectWithData:self.output options:NSJSONReadingAllowFragments error:nil];
        NSDictionary* outDic = jsonOutput;
        result = [[outDic objectForKey:@"msg"]objectAtIndex:0];
        if(completionBlock){
            completionBlock(result,error,httpStatus);
        }
    }];
    
    
//    if([outDic objectForKey:@"Error"]){
//        result = @"Error";
//    }
//    if ([outDic objectForKey:@"Success"]) {
//        //result = [[outDic objectForKey:@"Success"]objectForKey:@"orderID"];
//    }
    //return result;
}

-(void)confirm:(NSDictionary*)dic completionHandler:(void(^)(NSMutableArray* confirmInfo, NSError* error,NSString* httpStatus))completionBlock{
    //BookingConfirm* result = [[BookingConfirm alloc]init];
    
    //[self.provider webServiceCall:@"booking_confirmation.php" with:dic];
    [self.provider webServiceCall:@"ohr/ohrapp/booking_confirmation.php" with:dic withHandler:^(NSData* data,NSError* error,NSString* httpStatus){
        Hotel* hotel = [[Hotel alloc]init];
        Order* order = [[Order alloc]init];
        self.output = data;
        id jsonOutput = [NSJSONSerialization JSONObjectWithData:self.output options:NSJSONReadingAllowFragments error:nil];
        NSDictionary* outDic = jsonOutput;
        NSArray* arr = [outDic objectForKey:@"Room Details"];
        order.checkInDate = [order NSStringToNSDate:[[arr objectAtIndex:0]objectForKey:@"checkIn"]]; //[[arr objectAtIndex:0]objectForKey:@"checkIn"];
        order.checkOutDate = [order NSStringToNSDate:[[arr objectAtIndex:0]objectForKey:@"checkOut"]];
        hotel.hotelName = [[arr objectAtIndex:0]objectForKey:@"hotelName"];
        hotel.hotelRating = [[arr objectAtIndex:0]objectForKey:@"hotelRating"];
        hotel.hotelLatitude = [[arr objectAtIndex:0]objectForKey:@"hotelLat"];
        hotel.hotelLongitude = [[arr objectAtIndex:0]objectForKey:@"hotelLong"];
        hotel.hotelAddress = [[arr objectAtIndex:0]objectForKey:@"hotelAdd"];
        NSMutableArray* array = [[NSMutableArray alloc]init];
        [array addObject:hotel];
        [array addObject:order];
        if(completionBlock){
            completionBlock(array,error,httpStatus);
        }
    }];
    
    
//    result.numOfRooms = [[arr objectAtIndex:0]objectForKey:@"room"];
//    result.numOfAdults = [[arr objectAtIndex:0]objectForKey:@"adult"];
//    result.numOfChildren = [[arr objectAtIndex:0]objectForKey:@"child"];
//    result.hotelId = [[arr objectAtIndex:0]objectForKey:@"hotelID"];
//    result.orderId = [[arr objectAtIndex:0]objectForKey:@"orderID"];
    //return array;
}

-(void)manage:(NSDictionary*)dic completionHandler:(void(^)(NSString* manageInfo, NSError* error,NSString* httpStatus))completionBlock{
    //[self.provider webServiceCall:@"manage_booking.php" with:dic];
    [self.provider webServiceCall:@"ohr/ohrapp/manage_booking.php" with:dic withHandler:^(NSData* data,NSError* error,NSString* httpStatus){
         NSString* result;
        self.output = data;
        id jsonOutput = [NSJSONSerialization JSONObjectWithData:self.output options:NSJSONReadingAllowFragments error:nil];
        NSDictionary* outDic = jsonOutput;
        result = [[outDic objectForKey:@"msg"]objectAtIndex:0];
        if(completionBlock){
            completionBlock(result,error,httpStatus);
        }
    }];
    //return result;
}

-(void)resetPassword:(NSDictionary*)dic completionHandler:(void(^)(NSString* resetInfo, NSError* error,NSString* httpStatus))completionBlock{
    
    
    //[self.provider webServiceCall:@"ohr_reset_pass.php" with:dic];
    [self.provider webServiceCall:@"ohr/ohrapp/ohr_reset_pass.php" with:dic withHandler:^(NSData* data,NSError* error,NSString* httpStatus){
        NSString* result;
        self.output = data;
        id jsonOutput = [NSJSONSerialization JSONObjectWithData:self.output options:NSJSONReadingAllowFragments error:nil];
        NSDictionary* outDic = jsonOutput;
        result = [[outDic objectForKey:@"msg"]objectAtIndex:0];
        if(completionBlock){
            completionBlock(result,error,httpStatus);
        }
    }];
}

-(void)history:(NSDictionary*)dic completionHandler:(void(^)(NSMutableArray* historyInfo, NSError* error,NSString* httpStatus))completionBlock{
    
    //[self.provider webServiceCall:@"booking_history.php" with:dic];
    
    [self.provider webServiceCall:@"ohr/ohrapp/booking_history.php" with:dic withHandler:^(NSData* data,NSError* error,NSString* httpStatus){
        NSMutableArray* arr = [[NSMutableArray alloc]init];
        self.output = data;
        id jsonOutput = [NSJSONSerialization JSONObjectWithData:self.output options:NSJSONReadingAllowFragments error:nil];
        NSDictionary* outDic = jsonOutput;
        NSArray* result = [outDic objectForKey:@"Booking History"];
        
        for(NSDictionary* d in result){
            Hotel* hotel = [[Hotel alloc]initWithDictionary:d];
            [arr addObject:hotel];
        }
        if(completionBlock){
            completionBlock(arr,error,httpStatus);
        }
    }];
    

    //return arr;
}
//"BookigId":"1170","hotelId":"413","hotelName":"Park\u00a0Hyatt","checkIn":"2016-12-17 00:00:00","checkOut":"2016-12-19 00:00:00","room":"0","adult":"50","child":"2"}

@end
