//
//  UserSearchResultViewController.h
//  SQLiteDemo
//
//  Created by Xinyuan Wang on 12/30/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchMenuToSearchDelegate <NSObject>

- (void)updateSearchContent:(NSDictionary *)content withText:(NSString *)text;

@end

@interface UserSearchResultViewController : UITableViewController

@property(weak, nonatomic)id <SearchMenuToSearchDelegate>delegate;

@end
