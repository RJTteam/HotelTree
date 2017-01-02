//
//  SortManager.h
//  HotelTree
//
//  Created by Shuai Wang on 1/1/17.
//  Copyright © 2017 RJT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortManager : NSObject


-(NSArray*)sortHotelByName:(NSArray*)hotels;
-(NSArray*)sortHotelByPrice:(NSArray*)hotels;
-(NSArray*)sortHotelByRating:(NSArray*)hotels;

//-(id)SortButtonClicked:(id)sender;  //for view controller
@end
