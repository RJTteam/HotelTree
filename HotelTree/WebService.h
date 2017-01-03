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
#import "History.h"

@interface WebService : NSObject

@property ( nonatomic, retain ) id < WebCommunicatioin > provider;

+(instancetype)sharedInstance;
-(NSString*)returenUserLogin:(NSDictionary*)dic;
-(NSString*)returnUserRegister:(NSDictionary*)dic;
-(NSMutableArray*)returnHotelSearch:(NSDictionary*)dic;
-(NSString*)booking:(NSDictionary*)dic;
-(NSMutableArray*)confirm:(NSDictionary*)dic;
-(NSString*)manage:(NSDictionary*)dic;
-(NSString*)resetPassword:(NSDictionary*)dic;
-(NSMutableArray*)history:(NSDictionary*)dic;

@end
