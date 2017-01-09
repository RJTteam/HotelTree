//
//  DetailViewController.m
//  HotelTree
//
//  Created by Lucas Luo on 1/2/17.
//  Copyright © 2017 RJT. All rights reserved.
//

#import "DetailViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import "PMCalendar.h"
#import "OrderConfirmViewController.h"
#import "ImageStoreManager.h"
#import "FlatUIKit.h"
#import "SWRevealViewController.h"
#import "MapViewController.h"

#define METERS_PRE_MILE 1609.34

@interface DetailViewController ()<PMCalendarControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet FUIButton *orderBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkInDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkOutDateLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;

@property (weak, nonatomic) IBOutlet MKMapView *aHotelMap;
@property (weak, nonatomic) IBOutlet UIImageView *aHotelImage;
@property (strong, nonatomic)PMCalendarController *calendar;
@property (weak, nonatomic) IBOutlet UIImageView *rateImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UIView *detailView;

@end

@implementation DetailViewController{
    CLLocationCoordinate2D _coordinate;//instance Value
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Set home backgound image
    self.detailView.layer.contents = (__bridge id)[UIImage imageNamed:@"homeBackground"].CGImage;
    self.detailView.layer.contentsGravity = kCAGravityResizeAspectFill;
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.detailView.bounds;
    //    [self.upperSideBackView addSubview:blurEffectView];
    [self.detailView insertSubview:blurEffectView atIndex:0];
    
    self.nameLabel.text = self.aHotel.hotelName;
    self.priceLabel.text = [NSString stringWithFormat:@"$%@ per night",self.aHotel.price];
    self.checkInDateLabel.text = self.bookingInfo[@"checkIn"];
    self.checkOutDateLabel.text = self.bookingInfo[@"checkOut"];
    [self setUIButton:self.orderBtn WithColorHex:@"04ACFF" Font:[UIFont boldFlatFontOfSize:20]];
    
    self.backScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.backScrollView.frame.size.height);
    
    _coordinate.longitude = [[NSString stringWithFormat:@"-%@",self.aHotel.hotelLongitude] doubleValue];
    
    _coordinate.latitude = [self.aHotel.hotelLatitude doubleValue];
    
    float ASPECTRATIONOFMAPKIT = self.aHotelMap.frame.size.width/self.aHotelMap.frame.size.height;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(_coordinate, 0.05*METERS_PRE_MILE, 0.05*METERS_PRE_MILE*ASPECTRATIONOFMAPKIT);
    [self.aHotelMap setRegion:region];
    self.aHotelMap.mapType = MKMapTypeStandard;
    self.aHotelMap.zoomEnabled = NO;
    self.aHotelMap.scrollEnabled = NO;
    //    self.aHotelMap.delegate = self;
    [self.aHotelMap addAnnotation:[Annotation annotationWithLatitude:[self.aHotel.hotelLatitude doubleValue] longitude:[[NSString stringWithFormat:@"-%@",self.aHotel.hotelLongitude] doubleValue] title:@"" subtitle:@""]];

    ImageStoreManager *imageStoreManager = [[ImageStoreManager alloc]init];

    self.aHotelImage.image = [UIImage imageWithContentsOfFile:[imageStoreManager getImageStoreFilePathByHotelId:self.aHotel.hotelId]];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.aHotel.hotelRating.intValue >= 0 && self.aHotel.hotelRating.intValue < 1){
        self.rateImage.image = [UIImage imageNamed:@"Group0"];
    }else if(self.aHotel.hotelRating.intValue >= 1 && self.aHotel.hotelRating.intValue < 2){
        self.rateImage.image = [UIImage imageNamed:@"Group3"];
    }else if(self.aHotel.hotelRating.intValue >= 2 && self.aHotel.hotelRating.intValue < 3){
        self.rateImage.image = [UIImage imageNamed:@"Group3"];
    }else if(self.aHotel.hotelRating.intValue >= 3 && self.aHotel.hotelRating.intValue < 4){
        self.rateImage.image = [UIImage imageNamed:@"Group4"];
    }else if(self.aHotel.hotelRating.intValue >= 4 && self.aHotel.hotelRating.intValue < 5){
        self.rateImage.image = [UIImage imageNamed:@"Group5"];
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

- (IBAction)openCalendarButtonClicked:(UIButton *)sender {
    if(self.calendar != nil && self.calendar.isCalendarVisible){
        [self.calendar dismissCalendarAnimated:YES];
    }else{
        self.calendar = [[PMCalendarController alloc] initWithSize:CGSizeMake(300, 170)];
        self.calendar.delegate = self;
        [self.calendar setShowOnlyCurrentMonth:YES];
        [self.calendar presentCalendarFromView:sender permittedArrowDirections:PMCalendarArrowDirectionDown animated:YES];
    }
}

- (IBAction)bookButtonClicked:(UIButton *)sender {
    [self performSegueWithIdentifier:@"toOrderConfirmationSegue" sender:sender];
}

#pragma mark - PMCalendarControllerDelegate

- (BOOL)calendarControllerShouldDismissCalendar:(PMCalendarController *)calendarController{
    PMPeriod *period = calendarController.period;
    NSDate *start = period.startDate;
    NSDate *end = period.endDate;
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.timeZone = [NSTimeZone localTimeZone];
    formater.dateStyle = NSDateFormatterMediumStyle;
    formater.timeStyle = NSDateFormatterNoStyle;
    self.checkInDateLabel.text = [formater stringFromDate:start];
    self.checkOutDateLabel.text = [formater stringFromDate:end];
    NSMutableDictionary *dict = [self.bookingInfo mutableCopy];
    self.bookingInfo = nil;
    [dict setValue:self.checkInDateLabel.text forKey:@"checkIn"];
    [dict setValue:self.checkOutDateLabel.text forKey:@"checkOut"];
    self.bookingInfo = [NSDictionary dictionaryWithDictionary:dict];
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toOrderConfirmationSegue"]){
        OrderConfirmViewController *vc = segue.destinationViewController;
        vc.hotel = self.aHotel;
        NSDictionary *dict = @{@"roomNumber": self.bookingInfo[@"room"],
                               @"adultNumber": self.bookingInfo[@"adult"],
                               @"childrenNumber": self.bookingInfo[@"child"],
                               @"hotelId": self.aHotel.hotelId};
        Order *currentOrder = [[Order alloc] initWithDictionary:dict];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        formater.timeZone = [NSTimeZone localTimeZone];
        formater.dateFormat = @"EEE MMM, yyyy";
        NSDate *checkInDate = [formater dateFromString:self.bookingInfo[@"checkIn"]];
        NSDate *checkOutDate = [formater dateFromString:self.bookingInfo[@"checkOut"]];
        [currentOrder setCheckInDate:checkInDate];
        [currentOrder setCheckOutDate:checkOutDate];
        vc.order = currentOrder;
    }else if([segue.identifier isEqualToString:@"toMapSegue"]){
        MapViewController *vc = segue.destinationViewController;
        vc.bookingInfo = self.bookingInfo;
    }
}


@end
