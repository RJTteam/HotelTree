//
//  RequirementViewController.h
//  HotelTree
//
//  Created by Xinyuan Wang on 1/1/17.
//  Copyright © 2017 RJT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuantitySetDelegate <NSObject>

- (void)sendDataBack:(NSInteger)rooms adults: (NSInteger)adults children:(NSInteger)children;

@end
@interface RequirementViewController : UIViewController

@property(weak, nonatomic)id<QuantitySetDelegate>delegate;

@end
