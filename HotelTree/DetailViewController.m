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

#define METERS_PRE_MILE 1609.34

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *toMapBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rantingLabel;

@property (weak, nonatomic) IBOutlet MKMapView *aHotelMap;
@end

@implementation DetailViewController{
    CLLocationCoordinate2D _coordinate;//instance Value
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.aHotel.hotelName;
    self.priceLabel.text = self.aHotel.price;
    self.rantingLabel.text = self.aHotel.hotelRating;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
