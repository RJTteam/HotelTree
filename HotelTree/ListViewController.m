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

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *listView;
@property (weak, nonatomic) IBOutlet FUIButton *sortBtn;
@property (weak, nonatomic) IBOutlet FUIButton *filterBtn;
@property (weak, nonatomic) IBOutlet FUIButton *mapBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
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
    cell.addressLabel.text = obj.hotelAddress;
    cell.priceLabel.text = obj.price;
    
    cell.hotelImage.image = [UIImage imageWithContentsOfFile:[[[ImageStoreManager alloc]init] getImageStoreFilePathByHotelId:obj.hotelId]];
    
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
         
     }

 }
@end
