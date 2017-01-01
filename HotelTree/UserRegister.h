//
//  UserRegister.h
//  HotelTree
//
//  Created by Yangbin on 12/31/16.
//  Copyright © 2016 com.rjtcompuquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserRegister : NSObject

@property (nonatomic,strong) NSString* userId;
@property (nonatomic,strong) NSString* userEmail;

@end

//"{Error:{description:some error info}}
//{Success:{userID:123456, userEmail:sfsf@sds.com}}"
