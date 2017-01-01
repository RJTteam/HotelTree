//
//  userManager.h
//  SQLITE3
//
//  Created by Shuai Wang on 12/20/16.
//  Copyright © 2016 Pranav Prakash. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"
#import "Hotel.h"
#import "Order.h"
#import "ImageStoreManager.h"
#import "WebService.h"

@interface ModelManager : NSObject

//--- init start ---
+(instancetype)sharedInstance;
- (BOOL)createUserDBIfNeeded;
- (BOOL)createHotelDBIfNeeded;
- (BOOL)createOrderDBIfNeeded;
-(void)closeDB;
//--- init end ---


//--- UserManager start ---
- (void)createUser:(NSString *)userId password: (NSString *) password userName :(NSString*)userName firstName : (NSString *)firstName lastName: (NSString *)lastName email : (NSString *) email userAddress: (NSString *)userAddress;
- (NSArray*)getAllUser;
- (BOOL)updateUser: (User *)user;
- (BOOL)removeUser: (NSString*)userID;
//--- UserManager end ---


//--- hotelManager start ---
- (BOOL)createHotel:(NSString *)hotelId hotelName: (NSString *) hotelName hotelLatitude :(NSString*)hotelLatitude hotelLongitude : (NSString *)hotelLongitude hotelAddress: (NSString *)hotelAddress hotelRating : (NSString *) hotelRating hotelPrice: (NSString *)hotelPrice hotelThumb: (NSString *)hotelThumb hotelAvailableDate: (NSArray *)hotelAvailableDate;
-(BOOL)createHotelByHotel:(Hotel *)hotel;
- (NSArray*)getAllHotel;
-(NSArray*)hotelSearchFromWebService:(NSDictionary*)dic;
//--- hotelManager end ---


//--- orderManager start ---
-(BOOL)createOrder:(NSDate *)checkInDate checkOutDate:(NSDate *)checkOutDate roomNumber:(NSString *)roomNumber adultNumber:(NSString *)adultNumber childrenNumber:(NSString *)childrenNumber orderStauts:(NSString *)orderStauts userId:(NSString *)userId hotelId:(NSString *)hotelId;

- (NSArray*)getAllOrderByUserId:(NSString*)userId;
//--- orderManager end ---

@end
