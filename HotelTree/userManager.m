//
//  userManager.m
//  SQLITE3
//
//  Created by Shuai Wang on 12/20/16.
//  Copyright © 2016 Pranav Prakash. All rights reserved.
//

#import "userManager.h"
#import "SQLiteManager.h"


@interface UserManager()

@end

@implementation UserManager


-(instancetype)init{
    if(self = [super init]){
        [self createDBIfNeeded];
    }
    return self;
}

+(instancetype)sharedInstance{
    static UserManager* userManager_Instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager_Instance = [[UserManager alloc]init];
    });
    return userManager_Instance;
}

-(void)closeDB{
    [[SQLiteManager shareInstance] closeDatabase];
}


- (BOOL)createDBIfNeeded{
    NSString *query = @"create table if not exists user(id integer primary key autoincrement, username varchar(255)  unique not null, password varchar(255) not null);";
    NSString *userInfoQuery = @"create table if not exists userInfo(id integer primary key, first_name varchar(100) not null, last_name varchar(100) not null, age int not null, gender varchar(10), foreign key(id) references user(id));";
    BOOL result = [[SQLiteManager shareInstance] executeQuery:query];
    if(result){
        result = [[SQLiteManager shareInstance] executeQuery:userInfoQuery];
    }
    return result;
}

- (void)createUser:(NSString *)username password: (NSString *) password firstName : (NSString *)firstname lastName: (NSString *)lastname age : (int) age isMale: (BOOL)isMale{
    
    NSString *userQuery = [NSString stringWithFormat:@"insert into user values(NULL, '%@','%@');", username, password];
    BOOL result = [[SQLiteManager shareInstance] executeQuery:userQuery];
    if(result){
    int lastID = [[SQLiteManager shareInstance] lastInsertID];
    NSString *userInfoQuery = [NSString stringWithFormat:@"insert into userInfo values(%d, '%@','%@',%d, '%@');", lastID, firstname, lastname, age, isMale ? @"male":@"female"];
    [[SQLiteManager shareInstance] executeQuery:userInfoQuery];
        
    NSLog(@"Insert Finish");
    }
    
}

- (NSArray*)getAllUser{
        NSMutableArray *allUsers = [[NSMutableArray alloc]init];
        NSString *fetchQuery = [NSString stringWithFormat:@"select * from user join userInfo on user.id = userInfo.id"];
        NSArray *array = [[SQLiteManager shareInstance] executeQueryWithStatement:fetchQuery];
    
        for(NSDictionary *dic in array){
            User *newUser = [[User alloc] initWithDictionary:dic];
            [allUsers addObject:newUser];
        }
    return allUsers;
}


- (BOOL)removeUser:(int)userID atIndex: (NSInteger)index{
    NSString *removeQuery = [NSString stringWithFormat:@"delete from user where id=%d", userID];
    NSString *removeInfoQuery = [NSString stringWithFormat:@"delete from userInfo where id=%d", userID];
    BOOL result = [[SQLiteManager shareInstance] executeQuery:removeQuery];
    if(result){
        result = [[SQLiteManager shareInstance] executeQuery:removeInfoQuery];
    }
    return result;
}


// user has been updated and we have to save it
- (BOOL)updateUser: (User *)user{
    NSString *updateUserQuery = [NSString stringWithFormat:@"update user set username='%@',password='%@' where id=%d;", user.userName, user.password,user.elementId];
    BOOL result = [[SQLiteManager shareInstance] executeQuery:updateUserQuery];
    if(result){
        NSString *updateUserInfoQuery = [NSString stringWithFormat:@"update userInfo set first_name='%@',last_name='%@',age=%d,gender='%@' where id=%d;",user.firstName, user.lastName, user.age, user.gender,user.elementId];
        result = [[SQLiteManager shareInstance] executeQuery:updateUserInfoQuery];
    }
    return result;
}

@end
