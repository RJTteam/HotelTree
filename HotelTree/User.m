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
        _userName = dic[@"username"];
        _elementId = [dic[@"id"] intValue];
        _firstName = dic[@"first_name"];
        _lastName = dic[@"last_name"];
        _gender = dic[@"gender"];
        _age = [dic[@"age"] intValue];
        _password = dic[@"password"];
    }
    return self;
}

@end
