//
//  ListViewController.h
//  HotelTree
//
//  Created by Lucas Luo on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *SortButton;
@property (strong, nonatomic)NSMutableArray *hotelsRawInfo;
@end
