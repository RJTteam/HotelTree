//
//  User.m
//  HotelTree
//
//  Created by Yangbin on 1/1/17.
//  Copyright © 2017 com.rjtcompuquest. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary: (NSDictionary *)dic{
    if(self = [super init]){
        _userId = dic[@"userId"];
        _password = dic[@"password"];
        _userName = dic[@"userName"];
        _firstName = dic[@"firstName"];
        _lastName = dic[@"lastName"];
        _email = dic[@"email"];
        _userAddress = dic[@"userAddress"];
        
    }
    return self;
}

@end
