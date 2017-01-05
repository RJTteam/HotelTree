//
//  HomeViewController.m
//  HotelTree
//
//  Created by Lucas Luo on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "HomeViewController.h"
#import "HomeTableCell.h"
#import "RequirementViewController.h"
#import "UserSearchResultViewController.h"
#import "PMCalendar.h"
#import "ModelManager.h"
#import "ListViewController.h"
#import "UIImageView+GIF.h"
#import "FlatUIKit.h"
#import "SWRevealViewController.h"
#import "SidebarTableViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,SearchMenuToSearchDelegate,QuantitySetDelegate, UITextFieldDelegate, PMCalendarControllerDelegate>
@property (strong,nonatomic) NSMutableArray *homeArray;
@property (weak, nonatomic) IBOutlet UIView *homeBackView;
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@property (weak, nonatomic) IBOutlet UILabel *checkInDisplayLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkOutDisplayLabel;
@property (weak, nonatomic) IBOutlet UITextField *searchContentTextField;

@property (weak, nonatomic) IBOutlet UILabel *roomQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *adultQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *childrenQuatityLabel;


@property (weak, nonatomic) IBOutlet UIButton *checkDateButton;
@property (weak, nonatomic) IBOutlet FUIButton *searchBtn;

@property (nonatomic)CLLocationCoordinate2D location;
@property (strong, nonatomic)PMCalendarController *inCalender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarBtn;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Set home backgound image
    self.homeBackView.layer.contents = (__bridge id)[UIImage imageNamed:@"homeBackground"].CGImage;
    self.homeBackView.layer.contentsGravity = kCAGravityResizeAspectFill;
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.homeBackView.bounds;
//    [self.upperSideBackView addSubview:blurEffectView];
    [self.homeBackView insertSubview:blurEffectView atIndex:0];
    
    self.inCalender= [[PMCalendarController alloc] initWithSize:CGSizeMake(300, 170)];
    self.inCalender.delegate = self;
    [self.inCalender setAllowedPeriod:[PMPeriod periodWithStartDate:[NSDate date] endDate:[[NSDate date] dateByAddingMonths:12]]];
    self.inCalender.showOnlyCurrentMonth = NO;
//get order History
    [self setUIButton:self.searchBtn WithColorHex:@"04ACFF" Font:[UIFont boldFlatFontOfSize:20]];

    
    NSDictionary *idDic = @{
        @"mobile":@"5555454"
    };
    [[ModelManager sharedInstance] history:idDic completionHandler:^(NSMutableArray *array) {
        self.homeArray = [array copy];
    }];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarBtn setTarget: self.revealViewController];
        [self.sideBarBtn setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([self.searchContentTextField isFirstResponder]){
        [self.searchContentTextField resignFirstResponder];
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


#pragma mark - Event Methods
- (IBAction)checkDateButtonClicked:(UIButton *)sender {
    if(self.inCalender.isCalendarVisible){
        [self.inCalender dismissCalendarAnimated:YES];
    }else{
        self.inCalender= [[PMCalendarController alloc] initWithSize:CGSizeMake(300, 170)];
        self.inCalender.delegate = self;
        [self.inCalender setAllowedPeriod:[PMPeriod periodWithStartDate:[NSDate date] endDate:[[NSDate date] dateByAddingMonths:12]]];
        self.inCalender.showOnlyCurrentMonth = NO;
        [self.inCalender presentCalendarFromView:sender permittedArrowDirections:PMCalendarArrowDirectionUp animated:YES];
    }
}

- (IBAction)searchButtonClicked {
    BOOL searchResultEmpty = self.searchContentTextField.text.length == 0;
    BOOL checkInDateEmpty = self.checkInDisplayLabel.text.length == 0;
    BOOL checkOutDateEmpty = self.checkOutDisplayLabel.text.length == 0;
    BOOL requirementsEmpty = self.roomQuantityLabel.text.length == 0 && self.adultQuantityLabel.text.length == 0 && self.childrenQuatityLabel.text.length == 0;
    if(!searchResultEmpty && !checkInDateEmpty && !checkOutDateEmpty && !requirementsEmpty){
        //TODO send search information to prepare segue
        [self performSegueWithIdentifier:@"searchToListSegue" sender:nil];
    }
}

#pragma mark - SearchMenuToSearchDelegate

- (void)updateSearchContent:(NSDictionary *)content withText:(NSString *)text{
    [self.searchContentTextField setText:text];
    double selectedLatitude = [content[@"hotelLat"] doubleValue];
    double selectedLongitude = [content[@"hotelLong"] doubleValue];
    self.location = CLLocationCoordinate2DMake(selectedLatitude, selectedLongitude);
}

#pragma mark - QuantitySetDelegate

- (void)sendDataBack:(NSInteger)rooms adults: (NSInteger)adults children:(NSInteger)children{
    self.roomQuantityLabel.text = [NSString stringWithFormat:@"%lu", rooms];
    self.adultQuantityLabel.text = [NSString stringWithFormat:@"%lu", adults];
    self.childrenQuatityLabel.text = [NSString stringWithFormat:@"%lu",children];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self performSegueWithIdentifier:@"toSearchMenuSegue" sender:nil];
    return NO;
}
#pragma mark - PMCalendarControllerDelegate

- (BOOL)calendarControllerShouldDismissCalendar:(PMCalendarController *)calendarController{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.timeZone = [NSTimeZone localTimeZone];
    formater.dateStyle = NSDateFormatterMediumStyle;
    formater.timeStyle = NSDateFormatterNoStyle;
    NSString *checkin = [formater stringFromDate:calendarController.period.startDate];
    NSString *checkout = [formater stringFromDate:calendarController.period.endDate];
    self.checkInDisplayLabel.text = checkin;
    self.checkOutDisplayLabel.text = checkout;
    return YES;
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.homeArray.count != 0){
        return 1;
    }
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *sectionName;
    switch (section) {
        case 0:
            sectionName = @"Place you stay";
            break;
       case 1:
            sectionName = @"Advertisement";
            break;
    }
    return sectionName;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.homeArray.count;
    }
    else{
        return 3;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        History *obj = [self.homeArray objectAtIndex:indexPath.row];
        cell.nameLabel.text = obj.hotelName;
//        cell.nameLabel.textColor = [UIColor whiteColor];
        cell.nameLabel.backgroundColor = [UIColor whiteColor];
        cell.nameLabel.alpha = 0.5f;
        cell.checkinLable.text = obj.checkInDate;
//        cell.checkinLable.textColor = [UIColor whiteColor];
        cell.checkinLable.backgroundColor = [UIColor whiteColor];
        cell.checkinLable.alpha = 0.5f;
        cell.checkoutLable.text = obj.checkOutDate;
//        cell.checkoutLable.textColor = [UIColor whiteColor];
        cell.checkoutLable.backgroundColor = [UIColor whiteColor];
        cell.checkoutLable.alpha = 0.5f;
        
        cell.cellView.layer.shadowOpacity = 0.5f;
        cell.cellView.layer.shadowRadius = 3;
        cell.cellView.layer.shadowOffset = CGSizeMake(2.0f, 4.0f);
        cell.cellView.layer.shadowColor = [[UIColor blackColor] CGColor];
        cell.cellView.layer.masksToBounds = NO;
        cell.cellView.layer.backgroundColor = [UIColor clearColor].CGColor;

        ImageStoreManager *imageGetter = [[ImageStoreManager alloc]init];
        UIImage *cellBackImage = [UIImage imageWithContentsOfFile:[imageGetter getImageStoreFilePathByHotelId:obj.hotelId]];
        CALayer *imageLayer = [CALayer layer];
        imageLayer.frame = cell.cellView.layer.bounds;
        imageLayer.contents = (__bridge id)cellBackImage.CGImage;
        imageLayer.contentsGravity = kCAGravityResizeAspectFill;
        imageLayer.masksToBounds = YES;
        imageLayer.cornerRadius = 3.0f;
        [cell.cellView.layer insertSublayer:imageLayer atIndex:0];
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        [cell.cellView insertSubview:blurEffectView atIndex:0];
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"advCell"forIndexPath:indexPath];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"adv%ld",indexPath.row] ofType:@"gif"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 0, 398, 183)];
        [imageView showGifImageWithData:[NSData dataWithContentsOfFile:path]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:imageView];
        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 68;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 19, 406, 44)];
        headerLabel.text = @"Order History";
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.alpha = 0.64;
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.shadowColor = [UIColor lightGrayColor];
        headerLabel.shadowOffset = CGSizeMake(-2, -1);
        headerLabel.backgroundColor = [self.homeTableView backgroundColor];
        headerLabel.font = [UIFont boldSystemFontOfSize:15];
        return headerLabel;
    }
    else{
        UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 19, 406, 44)];
        headerLabel.text = @"Place you should stay";
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.alpha = 0.64;
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.shadowColor = [UIColor lightGrayColor];
        headerLabel.shadowOffset = CGSizeMake(-2, -1);
        headerLabel.backgroundColor = [self.homeTableView backgroundColor];
        headerLabel.font = [UIFont boldSystemFontOfSize:20];
        return headerLabel;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"searchToListSegue"]){
        //TODO perform search using ModelManager;
        ListViewController *vc = segue.destinationViewController;
        ModelManager *modelManager = [ModelManager sharedInstance];
        NSDictionary* dict = @{
                              @"hotelLat":[NSString stringWithFormat:@"%f", self.location.latitude],
                              @"hotelLong":[NSString stringWithFormat:@"%f", self.location.longitude],
                              @"checkIn": self.checkInDisplayLabel.text,
                              @"checkOut": self.checkOutDisplayLabel.text,
                              @"room": self.roomQuantityLabel.text,
                              @"adult": self.adultQuantityLabel.text,
                              @"child" : self.childrenQuatityLabel.text
                              };
        
        [modelManager hotelSearchFromWebService:dict completionHandler:^(NSArray *array) {
            
            vc.hotelsArray = [array copy];
            vc.bookingInfo = dict;
            [vc.listTable reloadData];
        }];
    }else if ([segue.identifier isEqualToString:@"toSearchMenuSegue"]){
        UserSearchResultViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }else if ([segue.identifier isEqualToString:@"toRequirementSetSegue"]){
        RequirementViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}


@end
