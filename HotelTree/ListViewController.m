//
//  ListViewController.m
//  HotelTree
//
//  Created by Lucas Luo on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import "ListViewController.h"
#import "ListTableCell.h"
#import "ModelManager.h"
#import "Order.h"
#import "SortManager.h"
#import "ImageStoreManager.h"
#import "DetailViewController.h"


@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSArray* hotelsArray;
@property(strong, nonatomic)NSDictionary *location;

@property (weak, nonatomic) IBOutlet UITableView *listTable;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.hotelsRawInfo != nil){
        self.location = [NSDictionary dictionaryWithDictionary:(NSDictionary *)[self.hotelsRawInfo lastObject]];
        [self.hotelsRawInfo removeLastObject];
        self.hotelsArray = [NSArray arrayWithArray:self.hotelsRawInfo];
    }
//    NSLog(@"%@",self.hotelsArray);
    
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
    
//    NSLog(@"%@",self.hotelsArray);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hotelsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Hotel *obj = [self.hotelsArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = obj.hotelName;
    cell.rateLabel.text = obj.hotelRating;
    cell.addressLabel.text = obj.hotelAdd;
    cell.priceLabel.text = obj.price;
    
    cell.hotelImage.image = [UIImage imageWithContentsOfFile:[[[ImageStoreManager alloc]init] getImageStoreFilePathByHotelId:obj.hotelId]];
    
    return cell;
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"toHotelDetail"]) {
         if ([sender isKindOfClass:[UITableViewCell class]]) {
             NSIndexPath *indexPath = [self.listTable indexPathForSelectedRow];
             DetailViewController *desitViewControl = segue.destinationViewController;             
             desitViewControl.aHotel = [self.hotelsArray objectAtIndex:indexPath.row];
         }
         
     }

 }


@end
