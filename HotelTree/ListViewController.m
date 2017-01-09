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
#import "FlatUIKit.h"
#import "SWRevealViewController.h"
#import "MapViewController.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *listView;
@property (weak, nonatomic) IBOutlet FUIButton *sortBtn;
@property (weak, nonatomic) IBOutlet FUIButton *filterBtn;
@property (weak, nonatomic) IBOutlet FUIButton *mapBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (strong, nonatomic)NSArray *originalArray;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    NSLog(@"%@",self.hotelsArray);
    //Set home backgound image
    self.listView.layer.contents = (__bridge id)[UIImage imageNamed:@"homeBackground"].CGImage;
    self.listView.layer.contentsGravity = kCAGravityResizeAspectFill;
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.listView.bounds;
    //    [self.upperSideBackView addSubview:blurEffectView];
    [self.listView insertSubview:blurEffectView atIndex:0];
    
    [self setUIButton:self.sortBtn WithColorHex:@"04ACFF" Font:[UIFont boldFlatFontOfSize:20]];
    [self setUIButton:self.filterBtn WithColorHex:@"04ACFF" Font:[UIFont boldFlatFontOfSize:20]];
    [self setUIButton:self.mapBtn WithColorHex:@"04ACFF" Font:[UIFont boldFlatFontOfSize:20]];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)setUIButton:(FUIButton *)btn WithColorHex:(NSString*)hexColor Font:(UIFont*)font{
    btn.buttonColor = [UIColor colorFromHexCode:hexColor];
    btn.shadowColor = [UIColor colorFromHexCode:@"4D68A2"];
    btn.shadowHeight = 3.0f;
    btn.cornerRadius = 4.0f;
    btn.titleLabel.font = font;
    [btn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    //    return btn;
}

- (IBAction)sortButtonClicked:(UIButton *)sender {
    SortManager *sort = [[SortManager alloc]init];
    
    if(sender.tag==0){
        self.hotelsArray = [sort sortHotelByName:self.hotelsArray];//send current hotels list to this method;
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
    [self.listTable reloadData];
    //    NSLog(@"%@",self.hotelsArray);
}

- (IBAction)filter:(UIButton *)sender {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Filter" message:@"Input the range of price" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Max Price";
        textField.borderStyle = UITextBorderStyleLine;
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Min Price";
        textField.borderStyle = UITextBorderStyleLine;
    }];
    
    UIAlertAction* cancle = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction* set = [UIAlertAction actionWithTitle:@"Set" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *maxPrice = alert.textFields[0].text;
        NSString *minPrice = alert.textFields[1].text;
        if(minPrice.intValue > maxPrice.intValue){
            NSString *tmp = minPrice;
            minPrice = maxPrice;
            maxPrice = tmp;
            alert.textFields[0].text = maxPrice;
            alert.textFields[1].text = minPrice;
        }else{
            SortManager *sort = [[SortManager alloc]init];
            self.hotelsArray = [sort filterHotelByPrice:self.hotelsArray withMinPrice:alert.textFields[1].text andMaxPrice:alert.textFields[0].text];
            [self.listTable reloadData];
        }
    }];
    
    [alert addAction:set];
    [alert addAction:cancle];
    
    [self presentViewController:alert animated:YES completion:nil];
    
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
    cell.addressLabel.text = obj.hotelAddress;
    cell.priceLabel.text = obj.price;
    
    cell.hotelImage.image = [UIImage imageWithContentsOfFile:[[[ImageStoreManager alloc]init] getImageStoreFilePathByHotelId:obj.hotelId]];
    if(obj.hotelRating.intValue >= 0 && obj.hotelRating.intValue < 1){
        cell.rateImage.image = [UIImage imageNamed:@"Group0"];
    }else if(obj.hotelRating.intValue >= 1 && obj.hotelRating.intValue < 2){
        cell.rateImage.image = [UIImage imageNamed:@"Group3"];
    }else if(obj.hotelRating.intValue >= 2 && obj.hotelRating.intValue < 3){
        cell.rateImage.image = [UIImage imageNamed:@"Group3"];
    }else if(obj.hotelRating.intValue >= 3 && obj.hotelRating.intValue < 4){
        cell.rateImage.image = [UIImage imageNamed:@"Group4"];
    }else if(obj.hotelRating.intValue >= 4 && obj.hotelRating.intValue < 5){
        cell.rateImage.image = [UIImage imageNamed:@"Group5"];
        
    }
    cell.cellView.layer.shadowOpacity = 0.5f;
    cell.cellView.layer.shadowRadius = 3;
    cell.cellView.layer.shadowOffset = CGSizeMake(2.0f, 4.0f);
    cell.cellView.layer.shadowColor = [[UIColor blackColor] CGColor];
    cell.cellView.layer.masksToBounds = NO;
    cell.cellView.layer.cornerRadius = 3;

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
             desitViewControl.bookingInfo = self.bookingInfo;
         }
         
     }else if([segue.identifier isEqualToString:@"toMapSegue"]){
         MapViewController *destination = segue.destinationViewController;
         destination.bookingInfo = self.bookingInfo;
     }

 }
@end
