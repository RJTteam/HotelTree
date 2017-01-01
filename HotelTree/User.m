//
//  User.m
//  SQLITE3
//
//  Created by Shuai Wang on 12/20/16.
//  Copyright © 2016 Pranav Prakash. All rights reserved.
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
