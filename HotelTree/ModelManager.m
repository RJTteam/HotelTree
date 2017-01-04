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
        [self createUserDBIfNeeded];
        [self createHotelDBIfNeeded];
        [self createOrderDBIfNeeded];
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

//---DB creater start---
- (BOOL)createUserDBIfNeeded{
    NSString *userDBQuery = @"create table if not exists user(userId varchar(255)  primary key, password varchar(255) not null);";
    NSString *userInfoDBQuery = @"create table if not exists userInfo(userId varchar(255) primary key, userName varchar(255)  not null, firstName varchar(100) not null, lastName varchar(100) not null, email varchar(100), userAddress varchar(255), isManager varchar(10), foreign key(userId) references user(userId));";
    BOOL result = [[SQLiteManager shareInstance] executeQuery:userDBQuery];
    if(result){
        result = [[SQLiteManager shareInstance] executeQuery:userInfoDBQuery];
    }
    return result;
}

- (BOOL)createHotelDBIfNeeded{
    NSString *hotelDBQuery = @"create table if not exists hotel(hotelId varchar(255)  primary key, hotelName varchar(255) not null,hotelAdd varchar(255) not null,hotelLat varchar(255) not null,hotelLong varchar(255) not null,hotelRating varchar(20) not null,price varchar(255) not null,hotelThumb varchar(255) not null);";
    BOOL result = [[SQLiteManager shareInstance] executeQuery:hotelDBQuery];
    return result;
}

- (BOOL)createOrderDBIfNeeded{
    NSString *orderDBQuery = @"create table if not exists orders(orderId integer primary key autoincrement, checkInDate varchar(255) not null, checkOutDate varchar(255) not null, roomNumber varchar(10) not null, adultNumber varchar(255) not null, childrenNumber varchar(255) not null, orderStauts varchar(10) not null, userId varchar(255) not null, hotelId varchar(255) not null);";
    BOOL result = [[SQLiteManager shareInstance] executeQuery:orderDBQuery];
    return result;
    
}
//---DB creater end---


-(void)loginValidate:(NSDictionary *)loginDic completionHandler:(void (^)(NSDictionary *))completionBlock{
    
    [[WebService sharedInstance] returnUserLogin:loginDic completionHandler:^(NSDictionary *loginInfo, NSError *error, NSString *httpStatus) {
        
        if(error){
            NSLog(@"Error L%@",error.description);
            return;
        }
        if(!httpStatus){
            completionBlock(loginInfo);
        }
    }];
}


-(void)userRegisterToServer:(NSDictionary *)registerInfo completionHandler:(void (^)(NSString *))completionBlock{
    
    [[WebService sharedInstance] returnUserRegister:registerInfo completionHandler:^(NSString *registerInfo, NSError *error, NSString *httpStatus) {
        
        if(error){
            NSLog(@"Error L%@",error.description);
            return;
        }
         if(!httpStatus){
             completionBlock(registerInfo);
        }
    }];
    
}

//--- Web Service part start ---
-(void)booking:(NSDictionary*)dic completionHandler:(void (^)(NSString *))completionBlock{
    
    [[WebService sharedInstance] booking:dic completionHandler:^(NSString *BookingInfo, NSError *error, NSString *httpStatus) {

        if(error){
            NSLog(@"Error L%@",error.description);
            return;
        }
         if(!httpStatus){
             completionBlock(BookingInfo);
        }
    }];
}

-(void)confirm:(NSDictionary*)dic completionHandler:(void (^)(NSMutableArray *))completionBlock{
    
    [[WebService sharedInstance] confirm:dic completionHandler:^(NSMutableArray *confirmInfo, NSError *error, NSString *httpStatus) {
        if(error){
            NSLog(@"Error L%@",error.description);
            return;
        }
         if(!httpStatus){
                completionBlock(confirmInfo);
        }
        
    }];
}

-(void)manage:(NSDictionary*)dic completionHandler:(void (^)(NSString *))completionBlock{
    
    [[WebService sharedInstance] manage:dic completionHandler:^(NSString *manageInfo, NSError *error, NSString *httpStatus) {
        if(error){
            NSLog(@"Error L%@",error.description);
            return;
        }
         if(!httpStatus){
                completionBlock(manageInfo);
        }
    }];
}

-(void)resetPassword:(NSDictionary*)dic completionHandler:(void (^)(NSString *))completionBlock{
    
    [[WebService sharedInstance] resetPassword:dic completionHandler:^(NSString *resetInfo, NSError *error, NSString *httpStatus) {
       if(error){
            NSLog(@"Error L%@",error.description);
            return;
        }
         if(!httpStatus){
                completionBlock(resetInfo);
        }
        
    }];
}
-(void)history:(NSDictionary*)dic completionHandler:(void (^)(NSMutableArray *))completionBlock{
    
    [[WebService sharedInstance] history:dic completionHandler:^(NSMutableArray *historyInfo, NSError *error, NSString *httpStatus) {
        if(error){
            NSLog(@"Error L%@",error.description);
            return;
        }
         if(!httpStatus){
                completionBlock(historyInfo);
        }
        
    }];
}
//--- Web Service part start ---

- (void)createUser:(NSString *)userId password: (NSString *) password userName :(NSString*)userName firstName : (NSString *)firstName lastName: (NSString *)lastName email : (NSString *) email userAddress: (NSString *)userAddress isManager:(NSString*)isManager{
    
    NSString *userQuery = [NSString stringWithFormat:@"insert into user values('%@','%@');", userId, password];
    BOOL result = [[SQLiteManager shareInstance] executeQuery:userQuery];
    if(result){
        
        NSString *userInfoQuery = [NSString stringWithFormat:@"insert into userInfo values('%@', '%@','%@','%@','%@', '%@', '%@');", userId, userName, firstName, lastName, email, userAddress, isManager];
        [[SQLiteManager shareInstance] executeQuery:userInfoQuery];
        
        NSLog(@"Insert Finish");
    }
    
}



-(BOOL)createHotel:(NSString *)hotelId hotelName:(NSString *)hotelName hotelLatitude:(NSString *)hotelLatitude hotelLongitude:(NSString *)hotelLongitude hotelAddress:(NSString *)hotelAddress hotelRating:(NSString *)hotelRating hotelPrice:(NSString *)hotelPrice hotelThumb:(NSString *)hotelThumb hotelAvailableDate:(NSArray *)hotelAvailableDate{
    
    ImageStoreManager *imageStoreManager = [[ImageStoreManager alloc]init];
    //imageStoreManager.delegate = self;
    
    NSString *filePath = [imageStoreManager imageStore:hotelThumb hotelId:hotelId];
    
    NSString *hotelQuery = [NSString stringWithFormat:@"insert into hotel values('%@','%@','%@','%@','%@','%@','%@','%@');", hotelId, hotelName,hotelAddress,hotelLatitude,hotelLongitude,hotelRating,hotelPrice,filePath];
    
    //!!!hotelAvailableDate should returned by WebService!!!
    
    BOOL result = [[SQLiteManager shareInstance] executeQuery:hotelQuery];
    
    return result;
}

-(BOOL)createHotelByHotel:(Hotel *)hotel{
    
    ImageStoreManager *imageStoreManager = [[ImageStoreManager alloc]init];
    //imageStoreManager.delegate = self;
    
    NSString *filePath = [imageStoreManager imageStore:hotel.hotelThumb hotelId:hotel.hotelId];
    
    //NSLog(@"%@",self.filePath);
    
    NSString *hotelQuery = [NSString stringWithFormat:@"insert into hotel values('%@','%@','%@','%@','%@','%@','%@','%@');", hotel.hotelId, hotel.hotelName,hotel.hotelAddress,hotel.hotelLatitude,hotel.hotelLongitude,hotel.hotelRating,hotel.price,filePath];
    
    //!!!hotelAvailableDate should returned by WebService!!!
    
    BOOL result = [[SQLiteManager shareInstance] executeQuery:hotelQuery];
    
    return result;
}

-(void)hotelSearchFromWebService:(NSDictionary *)dic completionHandler:(void (^)(NSArray *))completionBlock{

    [[WebService sharedInstance] returnHotelSearch:dic completionHandler:^(NSArray *array, NSError *error, NSString *httpStatus) {
        if(error){
            NSLog(@"Error L%@",error.description);
            return;
        }
         if(!httpStatus){
                for(Hotel *hotel in array){
                    [self createHotelByHotel:hotel];
                }
                completionBlock(array);
        }
    }];
}


-(BOOL)createOrder:(NSDate *)checkInDate checkOutDate:(NSDate *)checkOutDate roomNumber:(NSString *)roomNumber adultNumber:(NSString *)adultNumber childrenNumber:(NSString *)childrenNumber orderStauts:(NSString *)orderStauts userId:(NSString *)userId hotelId:(NSString *)hotelId{
    
    NSString *orderQuery = [NSString stringWithFormat:@"insert into orders values(NULL,'%@','%@','%@','%@','%@','%@','%@','%@');", checkInDate,checkOutDate,roomNumber,adultNumber,childrenNumber,orderStauts,userId,hotelId];
    
    BOOL result = [[SQLiteManager shareInstance] executeQuery:orderQuery];
    
    return result;
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

-(NSArray*)getAllHotel{
    NSMutableArray *allHotel = [[NSMutableArray alloc]init];
    NSString *fetchQuery = [NSString stringWithFormat:@"select * from hotel;"];
    NSArray *array = [[SQLiteManager shareInstance] executeQueryWithStatement:fetchQuery];
    
    for(NSDictionary *dic in array){
        Hotel *hotel = [[Hotel alloc] initWithDictionary:dic];
        [allHotel addObject:hotel];
    }
    return allHotel;
}

-(BOOL)clearHotelDB{
    NSString *removeQuery = [NSString stringWithFormat:@"delete * from hotel;"];
    BOOL result = [[SQLiteManager shareInstance] executeQuery:removeQuery];
    return result;
}

-(BOOL)clearUserDB{
    NSString *removeQuery = [NSString stringWithFormat:@"delete * from user;"];
    BOOL result = [[SQLiteManager shareInstance] executeQuery:removeQuery];
    return result;
}

-(BOOL)clearOrderDB{
    NSString *removeQuery = [NSString stringWithFormat:@"delete * from orders;"];
    BOOL result = [[SQLiteManager shareInstance] executeQuery:removeQuery];
    return result;
}

-(NSArray*)getAllOrderByUserId:(NSString *)userId{
    NSMutableArray *allOrder = [[NSMutableArray alloc]init];
    NSString *fetchQuery = [NSString stringWithFormat:@"select * from orders where userId = '%@';",userId];
    NSArray *array = [[SQLiteManager shareInstance] executeQueryWithStatement:fetchQuery];
    
    for(NSDictionary *dic in array){
        Order *order = [[Order alloc] initWithDictionary:dic];
        [allOrder addObject:order];
    }
    return allOrder;
}

-(BOOL)removeOrderByOrderId:(NSString*)orderId{
    NSString *removeQuery = [NSString stringWithFormat:@"delete from orders where orderId='%@';", orderId];
    BOOL result = [[SQLiteManager shareInstance] executeQuery:removeQuery];
    return result;
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
