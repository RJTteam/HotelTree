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
        _hotelPrice = dic[@"Price"];
        _hotelThumb = dic[@"hotelThumb"];
        //_hotelAvailableDate = dic[@"hotelAvailableDate"];
        
    }
    return self;
}

//"hotelId":"408","hotelName":"Park Hyatt ","hotelAdd":"Chicago","hotelLat":"41.8970","hotelLong":"87.6251","hotelRating":"5","price":"5000","hotelThumb":"http:\/\/rjtmobile.com\/ansari\/ohr\/admin\/uploads\/hotel_image\/perth_hayat.jpg"
@end
