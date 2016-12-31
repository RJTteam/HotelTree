//
//  userManager.h
//  SQLITE3
//
//  Created by Shuai Wang on 12/20/16.
//  Copyright © 2016 Pranav Prakash. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

@interface UserManager : NSObject

+(instancetype)sharedInstance;
- (BOOL)createDBIfNeeded;
- (void)createUser:(NSString *)username password: (NSString *) password firstName : (NSString *)firstname lastName: (NSString *)lastname age : (int) age isMale: (BOOL)isMale;
- (NSArray*)getAllUser;
- (BOOL)updateUser: (User *)user;
-(void)closeDB;
- (BOOL)removeUser: (int)userID atIndex: (NSInteger)index;

@end
