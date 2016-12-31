//
//  User.h
//  SQLITE3
//
//  Created by Shuai Wang on 12/20/16.
//  Copyright © 2016 Pranav Prakash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(strong,nonatomic) NSString * userId;
@property(strong,nonatomic) NSString * userName;
@property(strong,nonatomic) NSString * password;
@property(strong,nonatomic) NSString * firstName;
@property(strong,nonatomic) NSString * lastName;
@property(strong,nonatomic) NSString * gender;
@property(nonatomic) int age;
@property(nonatomic) int elementId;

- (instancetype)initWithDictionary: (NSDictionary *)dic;
@end
