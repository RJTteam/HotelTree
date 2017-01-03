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

#define METERS_PRE_MILE 1609.34

@interface DetailViewController ()<PMCalendarControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *toMapBtn;
@property (weak, nonatomic) IBOutlet FUIButton *orderBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rantingLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkInDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkOutDateLabel;

@property (weak, nonatomic) IBOutlet MKMapView *aHotelMap;
@property (weak, nonatomic) IBOutlet UIImageView *aHotelImage;
@property (strong, nonatomic)PMCalendarController *calendar;

@end

@implementation DetailViewController{
    CLLocationCoordinate2D _coordinate;//instance Value
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.aHotel.hotelName;
    self.priceLabel.text = self.aHotel.price;
    self.rantingLabel.text = self.aHotel.hotelRating;
    self.checkInDateLabel.text = self.bookingInfo[@"checkIn"];
    self.checkOutDateLabel.text = self.bookingInfo[@"checkOut"];
    [self setUIButton:self.orderBtn WithColorHex:@"04ACFF" Font:[UIFont boldFlatFontOfSize:20]];

    
    _coordinate.longitude = [[NSString stringWithFormat:@"-%@",self.aHotel.hotelLong] doubleValue];
    
    _coordinate.latitude = [self.aHotel.hotelLat doubleValue];
    
    float ASPECTRATIONOFMAPKIT = self.aHotelMap.frame.size.width/self.aHotelMap.frame.size.height;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(_coordinate, 0.05*METERS_PRE_MILE, 0.05*METERS_PRE_MILE*ASPECTRATIONOFMAPKIT);
    [self.aHotelMap setRegion:region];
    self.aHotelMap.mapType = MKMapTypeStandard;
    self.aHotelMap.zoomEnabled = NO;
    self.aHotelMap.scrollEnabled = NO;
    //    self.aHotelMap.delegate = self;
    [self.aHotelMap addAnnotation:[Annotation annotationWithLatitude:[self.aHotel.hotelLat doubleValue] longitude:[[NSString stringWithFormat:@"-%@",self.aHotel.hotelLong] doubleValue] title:@"" subtitle:@""]];

    ImageStoreManager *imageStoreManager = [[ImageStoreManager alloc]init];

    self.aHotelImage.image = [UIImage imageWithContentsOfFile:[imageStoreManager getImageStoreFilePathByHotelId:self.aHotel.hotelId]];
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
        formater.dateStyle = NSDateFormatterMediumStyle;
        formater.timeStyle = NSDateFormatterNoStyle;
        NSDate *checkInDate = [formater dateFromString:self.bookingInfo[@"checkIn"]];
        NSDate *checkOutDate = [formater dateFromString:self.bookingInfo[@"checkOut"]];
        [currentOrder setCheckInDate:checkInDate];
        [currentOrder setCheckOutDate:checkOutDate];
        vc.order = currentOrder;
    }
}


@end
