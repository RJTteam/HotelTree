//
//  History.h
//  HotelTree
//
//  Created by Yangbin on 1/2/17.
//  Copyright © 2017 RJT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface History : NSObject

@property(strong,nonatomic) NSString * orderId; //BookingId
@property(strong,nonatomic) NSDate * checkInDate; //Check In
@property(strong,nonatomic) NSDate * checkOutDate; //Check Out
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

//"BookigId":"1173","hotelId":"411","hotelName":"ParkHyatt","checkIn":"2016-12-17 00:00:00","checkOut":"2016-12-19 00:00:00","room":"0","adult":"4","child":"2"}
