//
//  OrderConfirmViewController.h
//  HotelTree
//
//  Created by Shuai Wang on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "User.h"
#import "Hotel.h"

@interface OrderConfirmViewController : UIViewController
@property(strong,nonatomic)Order *order;
@property(strong,nonatomic)Hotel *hotel;
@end
