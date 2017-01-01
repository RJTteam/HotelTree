//
//  BookingConfirm.h
//  HotelTree
//
//  Created by Yangbin on 12/31/16.
//  Copyright © 2016 com.rjtcompuquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookingConfirm : NSObject

@property (nonatomic,strong) NSString* checkIn;
@property (nonatomic,strong) NSString* checkOut;
@property (nonatomic,strong) NSString* numOfRooms;
@property (nonatomic,strong) NSString* numOfAdults;
@property (nonatomic,strong) NSString* numOfChildren;
@property (nonatomic,strong) NSString* hotelName;
@property (nonatomic,strong) NSString* hotelLat;
@property (nonatomic,strong) NSString* hotelLong;
@property (nonatomic,strong) NSString* hotelRating;
@property (nonatomic,strong) NSString* hotelAddress;
@property (nonatomic,strong) NSString* hotelId;
@property (nonatomic,strong) NSString* orderId;

@end


//{
//    "hotelName": "The Guesthouse Hotel C",
//    "hotelAdd": "Chicago",
//    "hotelLat": "41.9708",
//    "hotelLong": "87.6680",
//    "hotelRating": "5",
//    "checkIn": "2016-12-07 00:00:00",
//    "checkOut": "2016-12-29 00:00:00"
//}
