//
//  Order.m
//  HotelTree
//
//  Created by Yangbin on 1/1/17.
//  Copyright © 2017 com.rjtcompuquest. All rights reserved.
//

#import "Order.h"

@implementation Order

- (instancetype)initWithDictionary: (NSDictionary *)dic{
    if(self = [super init]){
        _orderId = dic[@"orderId"];
        _checkInDate = [self NSStringToNSDate:dic[@"checkInDate"]];
        _checkOutDate = [self NSStringToNSDate:dic[@"checkOutDate"]];;
        _roomNumber = dic[@"roomNumber"];
        _adultNumber = dic[@"adultNumber"];
        _childrenNumber = dic[@"childrenNumber"];
        _orderStauts = dic[@"orderStauts"];
        _userId = dic[@"userId"];
        _hotelId = dic[@"hotelId"];
    }
    return self;
}

-(NSDate*)NSStringToNSDate:(NSString*)stringDate{
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter dateFromString:stringDate];
}

@end
