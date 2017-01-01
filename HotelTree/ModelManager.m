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


- (BOOL)createUserDBIfNeeded{
    NSString *userDBQuery = @"create table if not exists user(userId varchar(255)  primary key, password varchar(255) not null);";
    NSString *userInfoDBQuery = @"create table if not exists userInfo(userId varchar(255) primary key, userName varchar(255)  not null, firstName varchar(100) not null, lastName varchar(100) not null, email varchar(100), userAddress varchar(255), foreign key(userId) references user(userId));";
    BOOL result = [[SQLiteManager shareInstance] executeQuery:userDBQuery];
    if(result){
        result = [[SQLiteManager shareInstance] executeQuery:userInfoDBQuery];
    }
    return result;
}

- (BOOL)createHotelDBIfNeeded{
    NSString *hotelDBQuery = @"create table if not exists hotel(hotelId varchar(255)  primary key, hotelName varchar(255) not null,hotelAddress varchar(255) not null,hotelLatitude varchar(255) not null,hotelLongitude varchar(255) not null,hotelRating varchar(20) not null,hotelPrice varchar(255) not null,hotelThumb varchar(255) not null,hotelAvailableDate text not null);";
    BOOL result = [[SQLiteManager shareInstance] executeQuery:hotelDBQuery];
    return result;
}

- (BOOL)createOrderDBIfNeeded{
    NSString *orderDBQuery = @"create table if not exists orders(orderId integer primary key autoincrement, checkInDate varchar(255) not null, checkOutDate varchar(255) not null, roomNumber varchar(10) not null, adultNumber varchar(255) not null, childrenNumber varchar(255) not null, orderStauts varchar(10) not null, userId varchar(255) not null, hotelId varchar(255) not null);";
    BOOL result = [[SQLiteManager shareInstance] executeQuery:orderDBQuery];
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

-(BOOL)createHotel:(NSString *)hotelId hotelName:(NSString *)hotelName hotelLatitude:(NSString *)hotelLatitude hotelLongitude:(NSString *)hotelLongitude hotelAddress:(NSString *)hotelAddress hotelRating:(NSString *)hotelRating hotelPrice:(NSString *)hotelPrice hotelThumb:(NSString *)hotelThumb hotelAvailableDate:(NSArray *)hotelAvailableDate{
    
    ImageStoreManager *imageStoreManager = [[ImageStoreManager alloc]init];
    //imageStoreManager.delegate = self;
    
    NSString *filePath = [imageStoreManager imageStore:hotelThumb hotelId:hotelId];
    
    NSString *hotelQuery = [NSString stringWithFormat:@"insert into hotel values('%@','%@','%@','%@','%@','%@','%@','%@','%@');", hotelId, hotelName,hotelLatitude,hotelLongitude,hotelAddress,hotelRating,hotelPrice,filePath,hotelAvailableDate];
    
    //!!!hotelAvailableDate should returned by WebService!!!
    
    BOOL result = [[SQLiteManager shareInstance] executeQuery:hotelQuery];
    
    return result;
}

-(BOOL)createHotelByHotel:(Hotel *)hotel{
    
    ImageStoreManager *imageStoreManager = [[ImageStoreManager alloc]init];
    //imageStoreManager.delegate = self;
    
    NSString *filePath = [imageStoreManager imageStore:hotel.hotelThumb hotelId:hotel.hotelId];
    
    //NSLog(@"%@",self.filePath);
    
    NSString *hotelQuery = [NSString stringWithFormat:@"insert into hotel values('%@','%@','%@','%@','%@','%@','%@','%@','%@');", hotel.hotelId, hotel.hotelName,hotel.hotelLatitude,hotel.hotelLongitude,hotel.hotelAddress,hotel.hotelRating,hotel.hotelPrice,filePath,hotel.hotelAvailableDate];
    
    //!!!hotelAvailableDate should returned by WebService!!!
    
    BOOL result = [[SQLiteManager shareInstance] executeQuery:hotelQuery];
    
    return result;
}

-(NSArray *)hotelSearchFromWebService:(NSDictionary *)dic{
    WebService *service = [WebService sharedInstance];
    NSArray* searchHotelResult = [service returnHotelSearch:dic];
    for(Hotel *hotel in searchHotelResult){
        [self createHotelByHotel:hotel];
    }
    return searchHotelResult;
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
