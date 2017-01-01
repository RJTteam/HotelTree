//
//  SQLiteManager.h
//  SQLiteDemo
//
//  Created by Xinyuan Wang on 12/22/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLiteManager : NSObject

+ (instancetype)shareInstance;
- (BOOL)executeQuery: (NSString *)query;
- (NSArray *)executeQueryWithStatement: (NSString *)query;
- (int)lastInsertID;
-(void)closeDatabase;
@end
