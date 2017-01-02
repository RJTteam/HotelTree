//
//  SortManager.m
//  HotelTree
//
//  Created by Shuai Wang on 1/1/17.
//  Copyright © 2017 RJT. All rights reserved.
//

#import "SortManager.h"

@implementation SortManager

-(NSArray *)sortHotelByName:(NSArray *)hotels{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"hotelName" ascending:YES];
    NSArray *result = [hotels sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    return result;
}

-(NSArray *)sortHotelByRating:(NSArray *)hotels{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"hotelRating" ascending:YES];
    NSArray *result = [hotels sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    return result;
}

-(NSArray *)sortHotelByPrice:(NSArray *)hotels{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"hotelPrice" ascending:YES];
    NSArray *result = [hotels sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    return result;
}


//please copy the follow method to target view controller for Button click stratge
/*
 - (IBAction)sortButtonClicked:(UIButton *)sender {
 SortManager *sort = [[SortManager alloc]init];
 
 if(sender.tag==0){
 self.hotelsArray = [sort sortHotelByRating:self.hotelsArray];//send current hotels list to this method;
 sender.tag++; //make Button tag = 1 --> sort by rating;
 [sender setTitle:@"Sort:Rating" forState:UIControlStateNormal];
 }else if(sender.tag==1){
 self.hotelsArray = [sort sortHotelByPrice:self.hotelsArray];//send current hotels list to this method;
 sender.tag++; //make Button tag = 2 --> sort by price;
 [sender setTitle:@"Sort:Price" forState:UIControlStateNormal];
 }else if(sender.tag==2){
 self.hotelsArray = [sort sortHotelByRating:self.hotelsArray];//send current hotels list to this method;
 sender.tag=0; //make Button tag = 0 --> back to default sort, by name;
 [sender setTitle:@"Sort:Name" forState:UIControlStateNormal];
 }
 
 NSLog(@"%@",self.hotelsArray);
 
 
 }
 */


@end
