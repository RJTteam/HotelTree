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
    return @"http://rjtmobile.com/ansari/";
}

-(void)webServiceCall:(NSString*) methodName with:(NSDictionary*) parameter withHandler:(void (^)(NSData* data, NSError* error,NSString* httpStatus ))returnData
{
    NSMutableString* urlString = [ NSMutableString stringWithString: [ self baseURL ] ];
    [ urlString appendString: methodName ];
    [ urlString appendString: @"?" ];
    for( NSString* key in parameter )
    {
        [ urlString appendFormat: @"%@=%@&", key, [ parameter objectForKey: key ] ];
    }
    NSString* urlStr = [ urlString substringToIndex: urlString.length - 1 ];
    NSString* urlStr1 = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSURLSession* session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlStr1]
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSString* status = nil;
                                                if (error) {
                                                    NSLog(@"dataTaskWithRequest error: %@", error);
                                                }
                                                if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                                    
                                                    NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                                                    
                                                    if (statusCode != 200) {
                                                        NSLog(@"dataTaskWithRequest HTTP status code: %ld", (long)statusCode);
                                                        status = @"http request goes wrong";
                                                    }
                                                }
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    returnData(data,error,status);
                                                });
                                            }];
    
    [dataTask resume];
}

@end
