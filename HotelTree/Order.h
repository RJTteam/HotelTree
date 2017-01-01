//
//  Order.h
//  HotelTree
//
//  Created by Shuai Wang on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
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


@end
