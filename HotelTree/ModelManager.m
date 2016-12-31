//
//  modelManager.m
//  SQLITE3
//
//  Created by Shuai Wang on 12/20/16.
//  Copyright © 2016 Pranav Prakash. All rights reserved.
//

#import "ModelManager.h"
#import "SQLiteManager.h"


@interface ModelManager()

@end

@implementation ModelManager


-(instancetype)init{
    if(self = [super init]){
        [self createDBIfNeeded];
    }
    return self;
}

+(instancetype)sharedInstance{
    static ModelManager* modelManager_Instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        modelManager_Instance = [[ModelManager alloc]init];
    });
    return modelManager_Instance;
}

-(void)closeDB{
    [[SQLiteManager shareInstance] closeDatabase];
}


- (BOOL)createDBIfNeeded{
    NSString *query = @"create table if not exists user(userId varchar(255)  primary key, password varchar(255) not null);";
    NSString *userInfoQuery = @"create table if not exists userInfo(userId varchar(255) primary key, userName varchar(255)  not null, firstName varchar(100) not null, lastName varchar(100) not null, email varchar(100), userAddress varchar(255), foreign key(userId) references user(userId));";
    BOOL result = [[SQLiteManager shareInstance] executeQuery:query];
    if(result){
        result = [[SQLiteManager shareInstance] executeQuery:userInfoQuery];
    }
    return result;
}

- (void)createUser:(NSString *)userId password: (NSString *) password userName :(NSString*)userName firstName : (NSString *)firstName lastName: (NSString *)lastName email : (NSString *) email userAddress: (NSString *)userAddress{
    
    NSString *userQuery = [NSString stringWithFormat:@"insert into user values('%@','%@');", userId, password];
    BOOL result = [[SQLiteManager shareInstance] executeQuery:userQuery];
    if(result){
    
    NSString *userInfoQuery = [NSString stringWithFormat:@"insert into userInfo values('%@', '%@','%@','%@','%@', '%@');", userId, userName, firstName, lastName, email, userAddress];
    [[SQLiteManager shareInstance] executeQuery:userInfoQuery];
        
    NSLog(@"Insert Finish");
    }
    
}

- (NSArray*)getAllUser{
        NSMutableArray *allUsers = [[NSMutableArray alloc]init];
        NSString *fetchQuery = [NSString stringWithFormat:@"select * from user join userInfo on user.userId = userInfo.userId;"];
        NSArray *array = [[SQLiteManager shareInstance] executeQueryWithStatement:fetchQuery];
    
        for(NSDictionary *dic in array){
            User *newUser = [[User alloc] initWithDictionary:dic];
            [allUsers addObject:newUser];
        }
    return allUsers;
}


- (BOOL)removeUser:(NSString*)userID{
    NSString *removeQuery = [NSString stringWithFormat:@"delete from user where userId='%@';", userID];
    NSString *removeInfoQuery = [NSString stringWithFormat:@"delete from userInfo where id='%@';", userID];
    BOOL result = [[SQLiteManager shareInstance] executeQuery:removeQuery];
    if(result){
        result = [[SQLiteManager shareInstance] executeQuery:removeInfoQuery];
    }
    return result;
}


// user has been updated and we have to save it
- (BOOL)updateUser: (User *)user{
    NSString *updateUserQuery = [NSString stringWithFormat:@"update user set userId='%@',password='%@' where userId='%@';", user.userId, user.password,user.userId];
    BOOL result = [[SQLiteManager shareInstance] executeQuery:updateUserQuery];
    if(result){
        NSString *updateUserInfoQuery = [NSString stringWithFormat:@"update userInfo set userName = '%@', firstName='%@',lastName='%@',email='%@',userAddress='%@' where userId='%@';",user.userName, user.firstName, user.lastName, user.email, user.userAddress,user.userId];
        result = [[SQLiteManager shareInstance] executeQuery:updateUserInfoQuery];
    }
    return result;
}

@end
