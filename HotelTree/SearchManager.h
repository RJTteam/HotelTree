//
//  SearchManager.h
//  HotelTree
//
//  Created by Xinyuan Wang on 12/30/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchManager : NSObject

+ (NSArray *)searchArrayUsingPredicate:(NSArray *)array withKeys:(NSArray *)keys andKeyword:(NSString *)keyword;

+ (NSArray *)searchUsingQueryWithKeys:(NSArray *)keys andKeyword:(NSString *)keyword;
@end
