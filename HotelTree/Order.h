//
//  Order.h
//  HotelTree
//
//  Created by Shuai Wang on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject

@property(strong,nonatomic) NSString * orderId;
@property(strong,nonatomic) NSDate * checkInDate;
@property(strong,nonatomic) NSDate * checkOutDate;
@property(strong,nonatomic) NSString * roomNumber;
@property(strong,nonatomic) NSString * adultNumber;
@property(strong,nonatomic) NSString * childrenNumber;
@property(strong,nonatomic) NSString * orderStauts;
@property(strong,nonatomic) NSString * userId;
@property(strong,nonatomic) NSString * hotelId;

- (instancetype)initWithDictionary: (NSDictionary *)dic;


@end
