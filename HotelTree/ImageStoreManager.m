//
//  ImageStoreManager.m
//  HotelTree
//
//  Created by Shuai Wang on 12/30/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "ImageStoreManager.h"

@implementation ImageStoreManager

-(instancetype)init{
    self=[super init];
    return self;
}

//Get the Path of Hotel Images Gallery Directory
-(NSString*)getImageStoreDirectoryPath{
   return [NSHomeDirectory() stringByAppendingString:@"/tmp/"];
}

//Get the File Path of A Hotel Images and format it with allowed Characters
//By HotelId
-(NSString*)getImageStoreFilePathByHotelId:(NSString*)hotelId{
    return [[[self getImageStoreDirectoryPath] stringByAppendingString:[NSString stringWithFormat:@"%@.png",hotelId]] stringByAddingPercentEncodingWithAllowedCharacters:(NSCharacterSet.URLQueryAllowedCharacterSet)];
}

////Image File Naming Rules after download By HotelId
//-(NSString*)setImageNameWithTime:(NSNumber*)hotelId{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd-HHmmss"];
//    return [NSString stringWithFormat:@"%@-%@.png",hotelId,[dateFormatter stringFromDate:[NSDate date]]];
//}


-(void)storeImageToFile:(NSData*)imageData hotelId:(NSString*)hotelId{
    NSString *imageFilePath = [self getImageStoreFilePathByHotelId:hotelId];
    [imageData writeToFile:imageFilePath atomically:YES];
    //return imageFilePath;
}

-(NSString *)imageStore:(NSString*)imageUrl hotelId:(NSString*)hotelId{
    NSURL *url = [NSURL URLWithString:imageUrl];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error){
            NSLog(@"Error %@",error.description);
            return;
        }
        
        //After request call success we get here but may be web-server return some error
        if([response isKindOfClass:[NSHTTPURLResponse class]]){
            NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
            //if success then we will get 200
            if( statusCode !=200){
                //Error in HTTP request
                NSLog(@"Error in HTTP Request:%ld",(long)statusCode);
                return;
            }
            else{
                //[self.delegate sendFilePath:[self storeImageToFile:data hotelId:hotelId]];
                [self storeImageToFile:data hotelId:hotelId];
            }
        }
    }]resume];
    return [self getImageStoreFilePathByHotelId:hotelId];
}



@end
