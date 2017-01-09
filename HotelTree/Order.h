//
//  Order.h
//  HotelTree
//
//  Created by Yangbin on 1/1/17.
//  Copyright © 2017 com.rjtcompuquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject

@property(strong,nonatomic) NSString * orderId; //BookingId
@property(strong,nonatomic) NSDate * checkInDate; //Check In
@property(strong,nonatomic) NSDate * checkOutDate; //Check Out
@property(strong,nonatomic) NSString * roomNumber;
@property(strong,nonatomic) NSString * adultNumber;
@property(strong,nonatomic) NSString * childrenNumber;
@property(strong,nonatomic) NSString * orderStauts; //booked ->  show order status, 0 is unbooked, 1 is booked.
@property(strong,nonatomic) NSString * userId; //mobile ->use this for identify user
@property(strong,nonatomic) NSString * hotelId;

- (instancetype)initWithDictionary: (NSDictionary *)dic;
-(NSDate*)NSStringToNSDate:(NSString*)stringDate;
@end

//{
//    "hotelName": "The Guesthouse Hotel C",
//    "hotelAdd": "Chicago",
//    "hotelLat": "41.9708",
//    "hotelLong": "87.6680",
//    "hotelRating": "5",
//    "checkIn": "2016-12-07 00:00:00",
//    "checkOut": "2016-12-29 00:00:00"
//}
