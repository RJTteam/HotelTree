//
//  MapViewController.m
//  HotelTree
//
//  Created by Lucas Luo on 1/1/17.
//  Copyright © 2017 RJT. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Annotation.h"
#import "ModelManager.h"

#define METERS_PRE_MILE 1609.34


@interface MapViewController ()<MKMapViewDelegate>
@end

@implementation MapViewController{
    CLLocationCoordinate2D _coordinate;//instance Value
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ModelManager *modelManager = [ModelManager sharedInstance];
    NSDictionary* dic = @{  //TODO: set user search coordinate
                          @"hotelLat":@"28.6049",
                          @"hotelLong":@"77.2235"
                          };
    
    
    [modelManager hotelSearchFromWebService:dic];
    NSArray *array = [modelManager getAllHotel];

    Hotel *hotelOnMapCenter = array[0];
    _coordinate.longitude = [[NSString stringWithFormat:@"-%@",hotelOnMapCenter.hotelLongitude] doubleValue];
    
    _coordinate.latitude = [hotelOnMapCenter.hotelLatitude doubleValue];
    MKMapView *MapPage = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    float ASPECTRATIONOFMAPKIT = MapPage.frame.size.width/MapPage.frame.size.height;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(_coordinate, 0.8*METERS_PRE_MILE, 0.8*METERS_PRE_MILE*ASPECTRATIONOFMAPKIT);
    [MapPage setRegion:region];
    MapPage.mapType = MKMapTypeStandard;
    MapPage.zoomEnabled = YES;
    MapPage.scrollEnabled = YES;
    MapPage.delegate = self;
    

    
    for(Hotel *hotel in array){
        NSLog(@"%@,%@,%@",hotel.hotelName,hotel.hotelLatitude,hotel.hotelLongitude);
        [MapPage addAnnotation:[Annotation annotationWithLatitude:[hotel.hotelLatitude doubleValue] longitude:[[NSString stringWithFormat:@"-%@",hotel.hotelLongitude] doubleValue] title:hotel.hotelName subtitle:hotel.hotelAddress]];
    }
    
    [self.view addSubview:MapPage];
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    MKAnnotationView* hotelannotation = [ mapView dequeueReusableAnnotationViewWithIdentifier: @"Hotels" ];
    if( hotelannotation == nil )
        hotelannotation = [ [ MKAnnotationView alloc ] initWithAnnotation: annotation reuseIdentifier:@"Hotels" ];
    else
        hotelannotation.annotation = annotation;
    hotelannotation.canShowCallout = YES;
    hotelannotation.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    //mapToDetail
    UIImage *image = [ UIImage imageNamed: @"hotel" ];
    hotelannotation.image = image;
    return hotelannotation;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    if ([control isKindOfClass:[UIButton class]]) {
        [mapView deselectAnnotation:view.annotation animated:NO];
        [self performSegueWithIdentifier:@"mapToDetail" sender:view];
    }
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
