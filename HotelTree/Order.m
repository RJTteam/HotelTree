//
//  Order.m
//  HotelTree
//
//  Created by Shuai Wang on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
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
