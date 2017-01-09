//
//  HomeTableCell.m
//  HotelTree
//
//  Created by Lucas Luo on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "HomeTableCell.h"

@implementation HomeTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.contentView.bounds.size.height - 1.0f, self.contentView.bounds.size.width, 1.0f)];
        lineView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        lineView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:lineView];
    }
    
    return self;
}

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
