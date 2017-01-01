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
        _hotelAddress = dic[@"hotelAddress"];
        _hotelLatitude = dic[@"hotelLatitude"];
        _hotelLongitude = dic[@"hotelLongitude"];
        _hotelRating = dic[@"hotelRating"];
        _hotelPrice = dic[@"hotelPrice"];
        _hotelThumb = dic[@"hotelThumb"];
        //_hotelAvailableDate = dic[@"hotelAvailableDate"];
        
    }
    return self;
}

@end
