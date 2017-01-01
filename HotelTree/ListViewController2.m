//
//  ListViewController.m
//  HotelTree
//
//  Created by Lucas Luo on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "ListViewController2.h"
#import "ListTableCell.h"
#import "ModelManager.h"
#import "Order.h"

@interface ListViewController2 ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSArray* hotelsArray;
@end

@implementation ListViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ModelManager *modelManager = [ModelManager sharedInstance];
    NSDictionary* dic = @{
                          @"hotelLat":@"28.6049",
                          @"hotelLong":@"77.2235"
                          };
    
    [modelManager hotelSearchFromWebService:dic];
    
    self.hotelsArray = [modelManager getAllHotel];
    NSLog(@"%@",self.hotelsArray);
//    SortManager *sort = [[SortManager alloc]init];
//    
//    NSArray *arrayByPrice =[sort sortHotelByPrice:array];
//    for(Hotel *hotel in arrayByPrice){
//        NSLog(@"%@,%@",hotel.hotelId,hotel.hotelPrice);
//    }
//    
//    NSArray *arrayByRating = [sort sortHotelByRating:array];
//    for(Hotel *hotel in arrayByRating){
//        NSLog(@"%@,%@",hotel.hotelId,hotel.hotelRating);
//    }
//    
//    NSArray *arrayByName = [sort sortHotelByName:array];
//    for(Hotel *hotel in arrayByName){
//        NSLog(@"%@,%@",hotel.hotelId,hotel.hotelName);
//    }
    
    
}
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
