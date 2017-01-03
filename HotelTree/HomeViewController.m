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
#import "WebService.h"
#import "UIImageView+GIF.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,SearchMenuToSearchDelegate,QuantitySetDelegate, UITextFieldDelegate, PMCalendarControllerDelegate>
@property (strong,nonatomic) NSMutableArray *homeArray;

@property (weak, nonatomic) IBOutlet UILabel *checkInDisplayLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkOutDisplayLabel;
@property (weak, nonatomic) IBOutlet UITextField *searchContentTextField;

@property (weak, nonatomic) IBOutlet UILabel *roomQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *adultQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *childrenQuatityLabel;


@property (weak, nonatomic) IBOutlet UIButton *checkDateButton;

@property (nonatomic)CLLocationCoordinate2D location;
@property (strong, nonatomic)PMCalendarController *inCalender;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inCalender= [[PMCalendarController alloc] initWithSize:CGSizeMake(300, 170)];
    self.inCalender.delegate = self;
    [self.inCalender setAllowedPeriod:[PMPeriod periodWithStartDate:[NSDate date] endDate:[[NSDate date] dateByAddingMonths:12]]];
    self.inCalender.showOnlyCurrentMonth = NO;
//get order History
    
    NSDictionary *idDic = @{
        @"mobile":@"1"
    };
    WebService *webService = [WebService sharedInstance];
    self.homeArray = [webService history:idDic];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([self.searchContentTextField isFirstResponder]){
        [self.searchContentTextField resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        cell.checkinLable.text = obj.checkInDate;
        cell.checkoutLable.text = obj.checkOutDate;
        
        ImageStoreManager *imageGetter = [[ImageStoreManager alloc]init];
        cell.hotelImage.image = [UIImage imageWithContentsOfFile:[imageGetter getImageStoreFilePathByHotelId:obj.hotelId]];
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"searchToListSegue"]){
        //TODO perform search using ModelManager;
        ModelManager *modelManager = [ModelManager sharedInstance];
        NSDictionary* dic = @{
                              @"hotelLat":[NSString stringWithFormat:@"%f", self.location.latitude],
                              @"hotelLong":[NSString stringWithFormat:@"%f", self.location.longitude],
                              @"checkIn": self.checkInDisplayLabel.text,
                              @"checkOut": self.checkOutDisplayLabel.text,
                              @"room": self.roomQuantityLabel.text,
                              @"adult": self.adultQuantityLabel.text,
                              @"child" : self.childrenQuatityLabel.text
                              };
        
        [modelManager hotelSearchFromWebService:dic];
        NSMutableArray *hotelsArray = [[modelManager getAllHotel] mutableCopy];
        [hotelsArray addObject:dic];
        ListViewController *vc = segue.destinationViewController;
        vc.hotelsRawInfo = [NSMutableArray arrayWithArray:hotelsArray];
    }else if ([segue.identifier isEqualToString:@"toSearchMenuSegue"]){
        UserSearchResultViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }else if ([segue.identifier isEqualToString:@"toRequirementSetSegue"]){
        RequirementViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}


@end
