//
//  Hotel.h
//  HotelTree
//
//  Created by Shuai Wang on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hotel : NSObject

@property(strong,nonatomic) NSString * hotelId;
@property(strong,nonatomic) NSString * hotelName;
@property(strong,nonatomic) NSString * hotelAddress;
@property(strong,nonatomic) NSString * hotelLatitude;  //hotelLat
@property(strong,nonatomic) NSString * hotelLongitude;   //hotelLong
@property(strong,nonatomic) NSString * hotelRating;
@property(strong,nonatomic) NSString * hotelPrice;
@property(strong,nonatomic) NSString * hotelThumb;
@property(strong,nonatomic) NSArray<NSDate *> * hotelAvailableDate; //Server not support, always nil

- (instancetype)initWithDictionary: (NSDictionary *)dic;
@end
