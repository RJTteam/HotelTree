//
//  ImageStoreManager.m
//  HotelTree
//
//  Created by Shuai Wang on 12/30/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "ImageStoreManager.h"

@implementation ImageStoreManager

//Get the Path of Hotel Images Gallery Directory
-(NSString*)getImageStoreDirectoryPath{
   return [NSHomeDirectory() stringByAppendingString:@"/Cache/Images/HotelGallery/"];
}

//Get the File Path of A Hotel Images and format it with allowed Characters
    //1.By fileName
-(NSString*)getImageStoreFilePathByFileName:(NSString*)fileName{
   return [[[self getImageStoreDirectoryPath] stringByAppendingString:fileName] stringByAddingPercentEncodingWithAllowedCharacters:(NSCharacterSet.URLQueryAllowedCharacterSet)];
}

    //2.By HotelId (Recommand)
-(NSString*)getImageStoreFilePathByHotelId:(NSNumber*)hotelId{
    return [[[self getImageStoreDirectoryPath] stringByAppendingString:[NSString stringWithFormat:@"%@",hotelId]] stringByAddingPercentEncodingWithAllowedCharacters:(NSCharacterSet.URLQueryAllowedCharacterSet)];
}

//Image File Naming Rules after download By HotelId
    //1.origin
-(NSString*)setImageName:(NSNumber*)hotelId{
    return [NSString stringWithFormat:@"%@.png",hotelId];
}
    //2.with Time Stamp for Image Gallery
-(NSString*)setImageNameWithTime:(NSNumber*)hotelId{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HHmmss"];
    return [NSString stringWithFormat:@"%@-%@.png",hotelId,[dateFormatter stringFromDate:[NSDate date]]];
}






@end
