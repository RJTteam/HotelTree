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


//loginValidate start
-(NSDictionary *)loginValidate:(NSDictionary *)loginDic;    //call web service to get the login information
-(NSString *)userRegisterToServer:(NSDictionary *)registerInfo;  //send user register info to server, please use this method with createUser which insert user information to local sql DB
//loginValidate end

//--- UserManager start ---
- (void)createUser:(NSString *)userId password: (NSString *) password userName :(NSString*)userName firstName : (NSString *)firstName lastName: (NSString *)lastName email : (NSString *) email userAddress: (NSString *)userAddress isManager:(NSString*)isManager;
- (NSArray*)getAllUser;
- (BOOL)updateUser: (User *)user;
- (BOOL)removeUser: (NSString*)userID;
//--- UserManager end ---


//--- hotelManager start ---
- (BOOL)createHotel:(NSString *)hotelId hotelName: (NSString *) hotelName hotelLatitude :(NSString*)hotelLatitude hotelLongitude : (NSString *)hotelLongitude hotelAddress: (NSString *)hotelAddress hotelRating : (NSString *) hotelRating hotelPrice: (NSString *)hotelPrice hotelThumb: (NSString *)hotelThumb hotelAvailableDate: (NSArray *)hotelAvailableDate;
-(BOOL)createHotelByHotel:(Hotel *)hotel;
- (NSArray*)getAllHotel;
-(NSArray*)hotelSearchFromWebService:(NSDictionary*)dic;
-(BOOL)clearHotelDB;
//--- hotelManager end ---


//--- orderManager start ---
-(BOOL)createOrder:(NSDate *)checkInDate checkOutDate:(NSDate *)checkOutDate roomNumber:(NSString *)roomNumber adultNumber:(NSString *)adultNumber childrenNumber:(NSString *)childrenNumber orderStauts:(NSString *)orderStauts userId:(NSString *)userId hotelId:(NSString *)hotelId;

- (NSArray*)getAllOrderByUserId:(NSString*)userId;
-(BOOL)removeOrderByOrderId:(NSString*)orderId;
//--- orderManager end ---

@end
