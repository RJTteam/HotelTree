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

-(NSData*)webServiceCall:(NSString*) methodName with:(NSDictionary*) parameter;

@end
