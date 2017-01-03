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

//http://rjtmobile.com/ansari/hms/hmsapp/hms_login.php?mobile=55555555&password=7011&IsManager=1
//http://rjtmobile.com/ansari/hms/hmsapp/hms_reg.php?name=aamir&email=aa@gmail.com&mobile=55555555&password=7011&IsManage=0

-(void)webServiceCall:(NSString*) methodName with:(NSDictionary*) parameter withHandler:(void (^)(NSData* data, NSError* error,NSString* httpStatus ))returnData
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
                                                     returnData(data,error,status);
                                            }];
    
    [dataTask resume];
    
//    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlStr1] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        if (returnData) {
//            returnData(data);
//        }
//        
//    }] resume];
    
//    NSData *result =[ NSData dataWithContentsOfURL: [ NSURL URLWithString: urlStr1 ] ];
//    
//    return result;
    
}

//- (void)retrieveData:(void (^)(NSDictionary * dictionary))completionHandler
//{
//    NSURLSession * session = [NSURLSession sharedSession];
//    NSURL * url = [NSURL URLWithString: self.getURL];
//    dataList =[[NSDictionary alloc] init];
//    
//    NSURLSessionDataTask * dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        
//        if (completionHandler) {
//            completionHandler(dictionary);
//        }
//        
//    }];
//    [dataTask resume];
//}


@end
