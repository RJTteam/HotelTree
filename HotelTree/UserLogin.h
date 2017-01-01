//
//  UserLogin.h
//  HotelTree
//
//  Created by Yangbin on 12/31/16.
//  Copyright © 2016 com.rjtcompuquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLogin : NSObject

@property (nonatomic,strong) NSString* userName;
@property (nonatomic,strong) NSString* userEmail;

@end

//"{Error:{description:some error info}}
//{Success:{userName:Lucas,userEmail:sfsf@sds.com}}"
