//
//  ListTableCell.h
//  HotelTree
//
//  Created by Lucas Luo on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *hotelImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
