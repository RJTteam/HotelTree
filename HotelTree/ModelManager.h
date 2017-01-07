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


//--- loginValidate and Register start ---
-(void)loginValidate:(NSDictionary *)loginDic completionHandler:(void(^)(NSDictionary *))completionBlock;//call web service to get the login information
-(void)userRegisterToServer:(NSDictionary *)registerInfo  completionHandler:(void(^)(NSString *))completionBlock;  //send user register info to server, please use this method with createUser which insert user information to local sql DB
//--- loginValidate and Register end ---

//--- Web Service part start ---
-(void)booking:(NSDictionary*)dic completionHandler:(void(^)(NSString *))completionBlock;
-(void)confirm:(NSDictionary*)dic completionHandler:(void(^)(NSMutableArray *))completionBlock;
-(void)manage:(NSDictionary*)dic completionHandler:(void(^)(NSString *))completionBlock;
-(void)resetPassword:(NSDictionary*)dic completionHandler:(void(^)(NSString *))completionBlock;
-(void)history:(NSDictionary*)dic completionHandler:(void(^)(NSMutableArray *))completionBlock;
//--- Web Service part start ---

//--- UserManager start ---
- (void)createUser:(NSString *)userId password: (NSString *) password userName :(NSString*)userName firstName : (NSString *)firstName lastName: (NSString *)lastName email : (NSString *) email userAddress: (NSString *)userAddress isManager:(NSString*)isManager;
- (NSArray*)getAllUser;
- (BOOL)updateUser: (User *)user;
- (BOOL)removeUser: (NSString*)userID;
-(BOOL)clearUserDB;
//--- UserManager end ---


//--- hotelManager start ---
- (BOOL)createHotel:(NSString *)hotelId hotelName: (NSString *) hotelName hotelLatitude :(NSString*)hotelLatitude hotelLongitude : (NSString *)hotelLongitude hotelAddress: (NSString *)hotelAddress hotelRating : (NSString *) hotelRating hotelPrice: (NSString *)hotelPrice hotelThumb: (NSString *)hotelThumb hotelAvailableDate: (NSArray *)hotelAvailableDate;
-(BOOL)createHotelByHotel:(Hotel *)hotel;
- (NSArray*)getAllHotel;
-(void)hotelSearchFromWebService:(NSDictionary*)dic completionHandler:(void(^)(NSArray *))completionBlock;
-(BOOL)clearHotelDB;
//--- hotelManager end ---


//--- orderManager start ---
-(BOOL)createOrder:(NSDate *)checkInDate checkOutDate:(NSDate *)checkOutDate roomNumber:(NSString *)roomNumber adultNumber:(NSString *)adultNumber childrenNumber:(NSString *)childrenNumber orderStauts:(NSString *)orderStauts userId:(NSString *)userId hotelId:(NSString *)hotelId;

- (NSArray*)getAllOrderByUserId:(NSString*)userId;
-(BOOL)removeOrderByOrderId:(NSString*)orderId;
-(BOOL)clearOrderDB;
//--- orderManager end ---

@end
