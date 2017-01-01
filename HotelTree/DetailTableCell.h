//
//  DetailTableCell.h
//  HotelTree
//
//  Created by Lucas Luo on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *toMapBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *inDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *inMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *inWeekDayLabel;

@property (weak, nonatomic) IBOutlet UILabel *outDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *outMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *outWeekDayLabel;

@end
