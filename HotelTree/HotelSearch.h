//
//  HotelSearch.h
//  WebPart
//
//  Created by Yangbin on 12/30/16.
//  Copyright © 2016 com.rjtcompuquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelSearch : NSObject

@property(nonatomic,strong) NSString* hotelId;
@property(nonatomic,strong) NSString* hotelName;
@property(nonatomic,strong) NSString* hotelAddress;
@property(nonatomic,strong) NSString* hotelLatitude;
@property(nonatomic,strong) NSString* hotelLongitude;
@property(nonatomic,strong) NSString* hotelRating;
@property(nonatomic,strong) NSString* hotelPrice;
@property(nonatomic,strong) NSString* hotelImages;
@property(nonatomic,strong) NSString* hotelHotelAvailableRoom;


@end

//"return array
//[{
//hotelId,
//hotelName,
//hotelAddress,
//hotelLatitude,
//hotelLongitude,
//hotelRating,
//hotelPrice,
//hotelImages( hotel Images Array ),
//hotelAvailableRoom
//}]"
