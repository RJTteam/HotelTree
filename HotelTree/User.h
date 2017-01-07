//
//  User.h
//  HotelTree
//
//  Created by Yangbin on 1/1/17.
//  Copyright © 2017 com.rjtcompuquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

//stored in User DB, for login
@property(strong,nonatomic) NSString * userId;  //mobile, use this for login
@property(strong,nonatomic) NSString * password;


//stored in UserInfo DB, for user information details
@property(strong,nonatomic) NSString * userName;  //just a nickname , stored at userInfo DB, not for login
@property(strong,nonatomic) NSString * firstName;
@property(strong,nonatomic) NSString * lastName;
@property(strong,nonatomic) NSString * email;
@property(strong,nonatomic) NSString * userAddress;


- (instancetype)initWithDictionary: (NSDictionary *)dic;

@end
