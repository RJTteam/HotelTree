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

#define METERS_PRE_MILE 1609.34

@interface DetailViewController ()<PMCalendarControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *toMapBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rantingLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkInWeekdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkOutWeekdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkOutMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkInMonthLabel;

@property (weak, nonatomic) IBOutlet MKMapView *aHotelMap;

@property (strong, nonatomic)PMCalendarController *calendar;
@property (strong, nonatomic)NSDictionary *numberToStringDict;

@end

@implementation DetailViewController{
    CLLocationCoordinate2D _coordinate;//instance Value
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.aHotel.hotelName;
    self.priceLabel.text = self.aHotel.price;
    self.rantingLabel.text = self.aHotel.hotelRating;
    
    self.numberToStringDict = @{[NSNumber numberWithInteger:1]:@"Mon",
                                [NSNumber numberWithInteger:2]:@"Tue",
                                [NSNumber numberWithInteger:3]:@"Wed",
                                [NSNumber numberWithInteger:4]:@"Thu",
                                [NSNumber numberWithInteger:5]:@"Fri",
                                [NSNumber numberWithInteger:6]:@"Sat",
                                [NSNumber numberWithInteger:7]:@"Sun"};
    
    _coordinate.longitude = [[NSString stringWithFormat:@"-%@",self.aHotel.hotelLong] doubleValue];
    
    _coordinate.latitude = [self.aHotel.hotelLat doubleValue];
    
    float ASPECTRATIONOFMAPKIT = self.aHotelMap.frame.size.width/self.aHotelMap.frame.size.height;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(_coordinate, 0.05*METERS_PRE_MILE, 0.05*METERS_PRE_MILE*ASPECTRATIONOFMAPKIT);
    [self.aHotelMap setRegion:region];
    self.aHotelMap.mapType = MKMapTypeStandard;
    self.aHotelMap.zoomEnabled = NO;
    self.aHotelMap.scrollEnabled = NO;
    //    self.aHotelMap.delegate = self;
    [self.aHotelMap addAnnotation:[Annotation annotationWithLatitude:[self.aHotel.hotelLat doubleValue] longitude:[[NSString stringWithFormat:@"-%@",self.aHotel.hotelLong] doubleValue] title:@"" subtitle:@""]];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - PMCalendarControllerDelegate

- (BOOL)calendarControllerShouldDismissCalendar:(PMCalendarController *)calendarController{
    PMPeriod *period = calendarController.period;
    NSDate *start = period.startDate;
    NSDate *end = period.endDate;
    NSCalendar *cal = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    cal.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *startComponents = [cal components:NSCalendarUnitWeekday|NSCalendarUnitDay | NSCalendarUnitMonth fromDate:start];
    NSDateComponents *endComponents = [cal components:NSCalendarUnitWeekday|NSCalendarUnitDay | NSCalendarUnitMonth fromDate:end];
    self.checkInWeekdayLabel.text = [NSString stringWithFormat:@"%@,%lu", self.numberToStringDict[[NSNumber numberWithInteger:startComponents.weekday]], startComponents.day];
    self.checkInMonthLabel.text = [NSString stringWithFormat:@"%lu", startComponents.month];
    self.checkOutWeekdayLabel.text = [NSString stringWithFormat:@"%@,%lu", self.numberToStringDict[[NSNumber numberWithInteger:endComponents.weekday]], endComponents.day];
    self.checkOutMonthLabel.text = [NSString stringWithFormat:@"%lu", endComponents.month];
    return YES;
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
