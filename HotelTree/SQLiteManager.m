//
//  SQLiteManager.m
//  SQLiteDemo
//
//  Created by Xinyuan Wang on 12/22/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "SQLiteManager.h"
#import <sqlite3.h>

@interface SQLiteManager()

@property (nonatomic)sqlite3 *database;

@end
@implementation SQLiteManager

+ (instancetype)shareInstance{
    static SQLiteManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SQLiteManager alloc] init];
        [ instance openDatabase ];
    });
    return instance;
}

-(void)openDatabase{
    NSString *docFile = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *dbPath = [docFile stringByAppendingPathComponent:@"sqlite3.db"];
    // Do any additional setup after loading the view, typically from a nib.
    if(![[NSFileManager defaultManager] fileExistsAtPath:dbPath]){
        [[NSFileManager defaultManager] createFileAtPath:dbPath contents:nil attributes:nil];
    }
    sqlite3_open([dbPath UTF8String], &_database);
    
    NSLog(@"%@",dbPath);
}

-(void)closeDatabase{
    sqlite3_close(self.database);
}


- (BOOL)executeQuery: (NSString *)query{
    NSString *beginTransaction = @"begin transaction;";
    NSString *commitTrasaction = @"commit transaction";
    NSString *rollbackTransaction = @"rollback transaction;";
    char *err = NULL;
    sqlite3_exec(self.database, [beginTransaction UTF8String], NULL, NULL, NULL);
    sqlite3_exec(self.database, [query UTF8String], NULL, NULL, &err);
    if(err != NULL){
        NSLog(@"%s", err);
        sqlite3_exec(self.database, [rollbackTransaction UTF8String], NULL, NULL, NULL);
        return NO;
    }
    sqlite3_exec(self.database, [commitTrasaction UTF8String], NULL, NULL, NULL);
    return YES;
}

- (int)sqlType: (char *)name{
    NSString *type_name = [[NSString stringWithFormat:@"%s", name] lowercaseString];
    if([type_name containsString:@"int"]){
        return 0;
    }
    if([type_name containsString:@"char"] || [type_name containsString:@"text"] || [type_name containsString:@"clob"]){
        return 2;
    }
    if([type_name containsString:@"double"] || [type_name containsString:@"real"] || [type_name containsString:@"float"]){
        return 1;
    }
    if([type_name containsString:@"blob"]){
        return 3;
    }
    if([type_name containsString:@"decimal"] || [type_name containsString:@"numeric"]){
        return 4;
    }
    if([type_name containsString:@"date"]){
        return 5;
    }
    return -1;
}

- (NSArray *)executeQueryWithStatement: (NSString *)query{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    sqlite3_stmt *stmt = NULL;
    sqlite3_prepare_v2(self.database, [query UTF8String], (int)[query length], &stmt, NULL);
    while(sqlite3_step(stmt) == SQLITE_ROW){
        int coloumn_count = sqlite3_column_count(stmt);
        NSMutableDictionary *dic =[NSMutableDictionary dictionary];
        for(int i = 0; i < coloumn_count; i++){
            char *column_name = (char *)sqlite3_column_name(stmt, i);
            char *column_type = (char *)sqlite3_column_decltype(stmt, i);
            NSString *col_name = [NSString stringWithUTF8String:column_name];
            int type = [self sqlType:column_type];
            switch (type) {
                case 0:{
                    NSNumber *number = [NSNumber numberWithInt:sqlite3_column_int(stmt, i)];
                    [dic setObject:number forKey:col_name];
                }
                    break;
                case 1:{
                    NSNumber *number = [NSNumber numberWithDouble:sqlite3_column_double(stmt, i)];
                    [dic setObject:number forKey:col_name];
                }
                    break;
                case 2:{
                    NSString *str = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, i)];
                    [dic setObject:str forKey:col_name];
                }
                    break;
                case 3:{
                    NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, i) length:sqlite3_column_bytes(stmt, i)];
                    [dic setObject:data forKey:col_name];
                    }
                    break;
                case 4:{
                    //cast to string first, then force change to double
                    NSNumber *number = [NSNumber numberWithDouble:sqlite3_column_double(stmt, i)];
                    [dic setObject:number forKey:col_name];
                }
                    break;
                case 5:{
                    NSString *str = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, i)];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                    formatter.timeZone = [NSTimeZone localTimeZone];
                    NSDate *date = [formatter dateFromString:str];
                    [dic setObject:date forKey:col_name];
                }
                    break;
                default:
                    @throw [NSError errorWithDomain:@"Unkown SQL type" code:-1 userInfo:nil];
                    break;
            }
        }
        [resultArray addObject:dic];
    }
    return resultArray;
}

//
- (int)lastInsertID{
    return (int)sqlite3_last_insert_rowid(self.database);
}

@end
