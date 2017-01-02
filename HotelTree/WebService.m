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
    });
    return mfs_Instance;
}

-(NSString*)returenUserLogin:(NSDictionary*)dic{
    //    UserLogin* user = [[UserLogin alloc]init];
    
    NSData* output = [self.provider webServiceCall:@"ohr_login.php" with:dic];
    id jsonOutput = [NSJSONSerialization JSONObjectWithData:output options:NSJSONReadingAllowFragments error:nil];
    
    NSLog(@"%@",jsonOutput);
    
    NSDictionary* outDic = jsonOutput;
    //    if([outDic objectForKey:@"Error"]){
    //        user.userName = nil;
    //        user.userEmail = nil;
    //    }else{
    //        [outDic objectForKey:@"Success"];
    //        user.userName = [[outDic objectForKey:@"Success"] objectForKey:@"userName"];
    //        user.userEmail = [[outDic objectForKey:@"Success"]  objectForKey:@"userEmail"];
    //    }
    
    NSArray* arr = [outDic objectForKey:@"msg"];
    return [arr objectAtIndex:0];
}

-(NSString*)returnUserRegister:(NSDictionary*)dic{
    //    UserRegister* user = [[UserRegister alloc]init];
    
    NSData* output = [self.provider webServiceCall:@"ohr_reg.php" with:dic];
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
    NSString* str = [[NSString alloc]initWithData:output encoding:NSUTF8StringEncoding];
    return str;
}

-(NSMutableArray*)returnHotelSearch:(NSDictionary*)dic{
    NSMutableArray* arr = [[NSMutableArray alloc]init];;
    
    NSData* output = [self.provider webServiceCall:@"search_hotel.php" with:dic];
    
    id jsonOutput = [NSJSONSerialization JSONObjectWithData:output options:NSJSONReadingAllowFragments error:nil];
    NSDictionary* outDic = jsonOutput;
    NSArray* array = [outDic objectForKey:@"Hotels"];
    for(NSDictionary* d in array){
        Hotel* hotel = [[Hotel alloc]initWithDictionary:d];
        
        //        hotel.hotelId = [d objectForKey:@"hotelId"];
        //        hotel.hotelName = [d objectForKey:@"hotelName"];
        //        hotel.hotelPrice = [d objectForKey:@"price"];
        //        hotel.hotelAddress = [d objectForKey:@"hotelAdd"];
        //        hotel.hotelRating = [d objectForKey:@"hotelRating"];
        //        hotel.hotelLatitude = [d objectForKey:@"hotelLat"];
        //        hotel.hotelLongitude = [d objectForKey:@"hotelLong"];
        //        hotel.hotelImages = [d objectForKey:@"hotelThumb"];
        
        [arr addObject:hotel];
    }
    //NSLog(@"from service %@",arr);
    return arr;
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

-(NSString*)booking:(NSDictionary*)dic{
    NSString* result;
    NSData* output = [self.provider webServiceCall:@"booked_hotel.php" with:dic];
    
    id jsonOutput = [NSJSONSerialization JSONObjectWithData:output options:NSJSONReadingAllowFragments error:nil];
    NSDictionary* outDic = jsonOutput;
    //    if([outDic objectForKey:@"Error"]){
    //        result = @"Error";
    //    }
    //    if ([outDic objectForKey:@"Success"]) {
    //        //result = [[outDic objectForKey:@"Success"]objectForKey:@"orderID"];
    //    }
    result = [[outDic objectForKey:@"msg"]objectAtIndex:0];
    return result;
}

-(NSMutableArray*)confirm:(NSDictionary*)dic{
    //BookingConfirm* result = [[BookingConfirm alloc]init];
    Hotel* hotel = [[Hotel alloc]init];
    Order* order = [[Order alloc]init];
    
    NSData* output = [self.provider webServiceCall:@"booking_confirmation.php" with:dic];
    
    id jsonOutput = [NSJSONSerialization JSONObjectWithData:output options:NSJSONReadingAllowFragments error:nil];
    NSDictionary* outDic = jsonOutput;
    NSArray* arr = [outDic objectForKey:@"Room Details"];
    order.checkInDate = [order NSStringToNSDate:[[arr objectAtIndex:0]objectForKey:@"checkIn"]]; //[[arr objectAtIndex:0]objectForKey:@"checkIn"];
    order.checkOutDate = [order NSStringToNSDate:[[arr objectAtIndex:0]objectForKey:@"checkOut"]];
    hotel.hotelName = [[arr objectAtIndex:0]objectForKey:@"hotelName"];
    hotel.hotelRating = [[arr objectAtIndex:0]objectForKey:@"hotelRating"];
    hotel.hotelLat = [[arr objectAtIndex:0]objectForKey:@"hotelLat"];
    hotel.hotelLong = [[arr objectAtIndex:0]objectForKey:@"hotelLong"];
    hotel.hotelAdd = [[arr objectAtIndex:0]objectForKey:@"hotelAdd"];
    
    //    result.numOfRooms = [[arr objectAtIndex:0]objectForKey:@"room"];
    //    result.numOfAdults = [[arr objectAtIndex:0]objectForKey:@"adult"];
    //    result.numOfChildren = [[arr objectAtIndex:0]objectForKey:@"child"];
    //    result.hotelId = [[arr objectAtIndex:0]objectForKey:@"hotelID"];
    //    result.orderId = [[arr objectAtIndex:0]objectForKey:@"orderID"];
    
    NSMutableArray* array = [[NSMutableArray alloc]init];
    [array addObject:hotel];
    [array addObject:order];
    return array;
}

-(NSString*)manage:(NSDictionary*)dic{
    NSString* result;
    
    NSData* output = [self.provider webServiceCall:@"manage_booking.php" with:dic];
    
    id jsonOutput = [NSJSONSerialization JSONObjectWithData:output options:NSJSONReadingAllowFragments error:nil];
    NSDictionary* outDic = jsonOutput;
    result = [[outDic objectForKey:@"msg"]objectAtIndex:0];
    
    return result;
}

-(NSString*)resetPassword:(NSDictionary*)dic{
    NSString* result;
    
    NSData* output = [self.provider webServiceCall:@"ohr_reset_pass.php" with:dic];
    
    id jsonOutput = [NSJSONSerialization JSONObjectWithData:output options:NSJSONReadingAllowFragments error:nil];
    NSDictionary* outDic = jsonOutput;
    result = [[outDic objectForKey:@"msg"]objectAtIndex:0];
    
    return result;
    
}

-(NSMutableArray*)history:(NSDictionary*)dic{
    NSMutableArray* arr = [[NSMutableArray alloc]init];
    NSData* output = [self.provider webServiceCall:@"booking_history.php" with:dic];
    
    id jsonOutput = [NSJSONSerialization JSONObjectWithData:output options:NSJSONReadingAllowFragments error:nil];
    NSDictionary* outDic = jsonOutput;
    NSArray* result = [outDic objectForKey:@"Booking History"];
    
    for(NSDictionary* d in result){
        Hotel* hotel = [[Hotel alloc]initWithDictionary:d];
        [arr addObject:hotel];
    }
    return arr;
}
//"BookigId":"1170","hotelId":"413","hotelName":"Park\u00a0Hyatt","checkIn":"2016-12-17 00:00:00","checkOut":"2016-12-19 00:00:00","room":"0","adult":"50","child":"2"}

@end
