//
//  History.m
//  HotelTree
//
//  Created by Yangbin on 1/2/17.
//  Copyright © 2017 RJT. All rights reserved.
//

#import "History.h"

@implementation History

- (instancetype)initWithDictionary: (NSDictionary *)dic{
    if(self = [super init]){
        _orderId = dic[@"BookigId"];
        _checkInDate = [self NSStringToNSDate:dic[@"checkIn"]];
        _checkOutDate = [self NSStringToNSDate:dic[@"checkOut"]];;
        _roomNumber = dic[@"room"];
        _adultNumber = dic[@"adult"];
        _childrenNumber = dic[@"child"];
        _orderStauts = dic[@"orderStauts"];
        _userId = dic[@"userId"];
        _hotelId = dic[@"hotelId"];
        _hotelName = dic[@"hotelName"];
    }
    return self;
}

-(NSDate*)NSStringToNSDate:(NSString*)stringDate{
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter dateFromString:stringDate];
}

//"BookigId":"1173","hotelId":"411","hotelName":"ParkHyatt","checkIn":"2016-12-17 00:00:00","checkOut":"2016-12-19 00:00:00","room":"0","adult":"4","child":"2"}

@end
