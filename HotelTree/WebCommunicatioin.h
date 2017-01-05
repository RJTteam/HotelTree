//
//  WebCommunicatioin.h
//  HotelTree
//
//  Created by Yangbin on 12/31/16.
//  Copyright © 2016 com.rjtcompuquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebCommunicatioin <NSObject>

-(NSString*)baseURL;

-(void)webServiceCall:(NSString*) methodName with:(NSDictionary*) parameter withHandler:(void (^)(NSData* data, NSError* error,NSString* httpStatus ))returnData;

@end
