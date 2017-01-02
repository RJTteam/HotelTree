//
//  Hotel.h
//  HotelTree
//
//  Created by Yangbin on 1/1/17.
//  Copyright © 2017 com.rjtcompuquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hotel : NSObject

@property(strong,nonatomic) NSString * hotelId;
@property(strong,nonatomic) NSString * hotelName;
@property(strong,nonatomic) NSString * hotelAdd;
@property(strong,nonatomic) NSString * hotelLat;  //hotelLat
@property(strong,nonatomic) NSString * hotelLong;   //hotelLong
@property(strong,nonatomic) NSString * hotelRating;
@property(strong,nonatomic) NSString * price;
@property(strong,nonatomic) NSString * hotelThumb;
//@property(strong,nonatomic) NSArray<NSDate *> * hotelAvailableDate; //Server not support, always nil

- (instancetype)initWithDictionary: (NSDictionary *)dic;

@end

//"BookigId":"1170","hotelId":"413","hotelName":"Park\u00a0Hyatt","checkIn":"2016-12-17 00:00:00","checkOut":"2016-12-19 00:00:00","room":"0","adult":"50","child":"2"}

//{
//    "hotelName": "The Guesthouse Hotel C",
//    "hotelAdd": "Chicago",
//    "hotelLat": "41.9708",
//    "hotelLong": "87.6680",
//    "hotelRating": "5",
//    "checkIn": "2016-12-07 00:00:00",
//    "checkOut": "2016-12-29 00:00:00"
//}
