//
//  ImageStoreManager.h
//  HotelTree
//
//  Created by Shuai Wang on 12/30/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol imageStoreManagerDelegate <NSObject>

-(void)sendFilePath:(NSString *)filePath;

@end

@interface ImageStoreManager : NSObject
-(void)imageStore:(NSString*)imageUrl hotelId:(NSString*)hotelId;
@property (weak ,nonatomic) id<imageStoreManagerDelegate> delegate;
@end
