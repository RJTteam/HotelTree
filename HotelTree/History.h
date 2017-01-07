//
//  History.h
//  HotelTree
//
//  Created by Lucas Luo on 1/2/17.
//  Copyright © 2017 RJT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface History : NSObject

@property(strong,nonatomic) NSString * orderId; //BookingId
@property(strong,nonatomic) NSString * checkInDate; //Check In
@property(strong,nonatomic) NSString * checkOutDate; //Check Out
@property(strong,nonatomic) NSString * roomNumber;
@property(strong,nonatomic) NSString * adultNumber;
@property(strong,nonatomic) NSString * childrenNumber;
@property(strong,nonatomic) NSString * orderStauts; //booked ->  show order status, 0 is unbooked, 1 is booked.
@property(strong,nonatomic) NSString * userId; //mobile ->use this for identify user
@property(strong,nonatomic) NSString * hotelId;
@property(strong,nonatomic) NSString * hotelName;

- (instancetype)initWithDictionary: (NSDictionary *)dic;
-(NSDate*)NSStringToNSDate:(NSString*)stringDate;

@end
