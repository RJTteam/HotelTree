//
//  WebServiceProvider.m
//  HotelTree
//
//  Created by Yangbin on 12/31/16.
//  Copyright © 2016 com.rjtcompuquest. All rights reserved.
//

#import "WebServiceProvider.h"

@implementation WebServiceProvider

- (NSString *) baseURL
{
    return @"http://rjtmobile.com/ansari/ohr/ohrapp/";
}

-(NSData*)webServiceCall:(NSString*) methodName with:(NSDictionary*) parameter
{
    NSMutableString* urlString = [ NSMutableString stringWithString: [ self baseURL ] ];
    [ urlString appendString: methodName ];
    [ urlString appendString: @"?&" ];
    for( NSString* key in parameter )
    {
        [ urlString appendFormat: @"%@=%@&", key, [ parameter objectForKey: key ] ];
    }
    NSString* urlStr = [ urlString substringToIndex: urlString.length - 1 ];
    NSString* urlStr1 = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    //NSLog(@"%@",urlStr);
    
    //http://rjtmobile.com/ansari/ohr/ohrapp/ohr_login.php?&mobile=123456789&password=789456
    //NSLog(@"feedback from server %@",data);
    
    return [ NSData dataWithContentsOfURL: [ NSURL URLWithString: urlStr1 ] ];
}

@end
