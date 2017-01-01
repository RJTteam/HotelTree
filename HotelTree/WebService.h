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
#import "UserLogin.h"
#import "UserRegister.h"
#import "HotelSearch.h"
#import "BookingResult.h"
#import "BookingConfirm.h"
#import "Hotel.h"
@interface WebService : NSObject

@property ( nonatomic, retain ) id < WebCommunicatioin > provider;

+(instancetype)sharedInstance;
-(NSArray*)returenUserLogin:(NSDictionary*)dic;
-(NSString*)returnUserRegister:(NSDictionary*)dic;
-(NSMutableArray*)returnHotelSearch:(NSDictionary*)dic;
-(NSString*)booking:(NSDictionary*)dic;
-(BookingConfirm*)confirm:(NSDictionary*)dic;
-(NSString*)manage:(NSDictionary*)dic;
-(NSString*)resetPassword:(NSDictionary*)dic;

@end
