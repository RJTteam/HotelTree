//
//  WebService.h
//  HotelTree
//
//  Created by Yangbin on 12/31/16.
//  Copyright © 2016 com.rjtcompuquest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebCommunicatioin.h"
#import "WebServiceProvider.h"
#import "Order.h"
#import "User.h"
#import "Hotel.h"

@interface WebService : NSObject

@property ( nonatomic, retain ) id < WebCommunicatioin > provider;
@property ( nonatomic,strong ) NSData* output;


+(instancetype)sharedInstance;
-(void)returenUserLogin:(NSDictionary*)dic completionHandler:(void(^)(NSDictionary* loginInfo, NSError* error,NSString* httpStatus))completionBlock;
//-(NSString*)
-(void)returnUserRegister:(NSDictionary*)dic completionHandler:(void(^)(NSString* registerInfo, NSError* error,NSString* httpStatus))completionBlock;;
//-(NSMutableArray*)
-(void)returnHotelSearch:(NSDictionary*)dic completionHandler:(void(^)(NSArray* array, NSError* error,NSString* httpStatus))completionBlock;;
//-(NSString*)
-(void)booking:(NSDictionary*)dic completionHandler:(void(^)(NSString* BookingInfo, NSError* error,NSString* httpStatus))completionBlock;;
//-(NSMutableArray*)
-(void)confirm:(NSDictionary*)dic completionHandler:(void(^)(NSMutableArray* confirmInfo, NSError* error,NSString* httpStatus))completionBlock;;
//-(NSString*)
-(void)manage:(NSDictionary*)dic completionHandler:(void(^)(NSString* manageInfo, NSError* error,NSString* httpStatus))completionBlock;;
//-(NSString*)
-(void)resetPassword:(NSDictionary*)dic completionHandler:(void(^)(NSString* resetInfo, NSError* error,NSString* httpStatus))completionBlock;;
//-(NSMutableArray*)
-(void)history:(NSDictionary*)str completionHandler:(void(^)(NSMutableArray* historyInfo, NSError* error,NSString* httpStatus))completionBlock;;

@end
