//
//  SearchManager.m
//  HotelTree
//
//  Created by Xinyuan Wang on 12/30/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "SearchManager.h"
#import "SQLiteManager.h"

static NSString *tablename = @"hotel";


@implementation SearchManager
+ (NSArray *)searchArrayUsingPredicate:(NSArray *)array withKeys:(NSArray *)keys andKeyword:(NSString *)keyword{
    if(!keyword){
        return @[];
    }
    NSArray *result = nil;
    for(NSString *key in keys){
        if(!result){
            NSString *format = [NSString stringWithFormat:@"%@ LIKE[c] '*%@*'",key, keyword];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:format];
            result = [array filteredArrayUsingPredicate:predicate];
            result = result.count == 0 ? nil : result;
        }
    }
    return (result != nil) ? result : @[];
}

+ (NSArray *)searchUsingQueryWithKeys:(NSArray *)keys andKeyword:(NSString *)keyword{
    NSArray *result = nil;
    if(!keyword){
        return @[];
    }
    for(NSString *key in keys){
        if(!result){
            NSString *query = [NSString stringWithFormat:@"select * from %@ where %@ like '%%%@%%';",tablename, key,keyword];
            result = [[SQLiteManager shareInstance] executeQueryWithStatement:query];
            result = result.count == 0 ? nil : result;
        }
    }
    return (result != nil) ? result : @[];
}
@end
