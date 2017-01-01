//
//  DetailTableCell.m
//  HotelTree
//
//  Created by Lucas Luo on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "DetailTableCell.h"

@implementation DetailTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)openMapClicked:(id)sender {
    NSLog(@"map called");
}

- (IBAction)openCalendarClicked:(id)sender {
    NSLog(@"calendar called");

}

@end
