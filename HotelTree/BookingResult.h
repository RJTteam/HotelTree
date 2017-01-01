//
//  BookingResult.h
//  HotelTree
//
//  Created by Yangbin on 12/30/16.
//  Copyright © 2016 com.rjtcompuquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookingResult : NSObject

@property(nonatomic,strong) NSString* orderId;

@end

//"1.Error with detail
//2.successful With orderID
//format:
//{Error:{description:some error info}}
//{Success:{orderID:123456}}"
