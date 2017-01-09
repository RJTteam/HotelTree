//
//  Hotel.m
//  HotelTree
//
//  Created by Yangbin on 1/1/17.
//  Copyright © 2017 com.rjtcompuquest. All rights reserved.
//

#import "Hotel.h"

@implementation Hotel

- (instancetype)initWithDictionary: (NSDictionary *)dic{
    if(self = [super init]){
        _hotelId = dic[@"hotelId"];
        _hotelName = dic[@"hotelName"];
        _hotelAddress = dic[@"hotelAdd"];
        _hotelLatitude = dic[@"hotelLat"];
        _hotelLongitude = dic[@"hotelLong"];
        _hotelRating = dic[@"hotelRating"];
        _price = dic[@"price"];
        _hotelThumb = dic[@"hotelThumb"];
        //_hotelAvailableDate = dic[@"hotelAvailableDate"];
        
    }
    return self;
}

@end
