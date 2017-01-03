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
#import "DetailViewController.h"

#define METERS_PRE_MILE 1609.34


@interface MapViewController ()<MKMapViewDelegate>
@property (nonatomic,strong) NSArray *hotelArray;
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
    self.hotelArray = [modelManager getAllHotel];

    Hotel *hotelOnMapCenter = self.hotelArray[0];
    _coordinate.longitude = [[NSString stringWithFormat:@"-%@",hotelOnMapCenter.hotelLong] doubleValue];
    
    _coordinate.latitude = [hotelOnMapCenter.hotelLat doubleValue];
    MKMapView *MapPage = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    float ASPECTRATIONOFMAPKIT = MapPage.frame.size.width/MapPage.frame.size.height;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(_coordinate, 0.8*METERS_PRE_MILE, 0.8*METERS_PRE_MILE*ASPECTRATIONOFMAPKIT);
    [MapPage setRegion:region];
    MapPage.mapType = MKMapTypeStandard;
    MapPage.zoomEnabled = YES;
    MapPage.scrollEnabled = YES;
    MapPage.delegate = self;
    

    
    for(Hotel *hotel in self.hotelArray){
        NSLog(@"%@,%@,%@",hotel.hotelName,hotel.hotelLat,hotel.hotelLong);
        [MapPage addAnnotation:[Annotation annotationWithLatitude:[hotel.hotelLat doubleValue] longitude:[[NSString stringWithFormat:@"-%@",hotel.hotelLong] doubleValue] title:hotel.hotelName subtitle:hotel.hotelAdd]];
    }
    
    [self.view addSubview:MapPage];
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    MKAnnotationView* hotelannotation = [ mapView dequeueReusableAnnotationViewWithIdentifier: @"Hotels" ];
    if( hotelannotation == nil )
        hotelannotation = [ [ MKAnnotationView alloc ] initWithAnnotation: annotation reuseIdentifier:@"Hotels" ];
    else
        hotelannotation.annotation = annotation;
    
    NSUInteger index = [mapView.annotations indexOfObject:hotelannotation.annotation];
    
    hotelannotation.canShowCallout = YES;
    hotelannotation.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    Hotel *obj = [self.hotelArray objectAtIndex:index];
    ImageStoreManager *imageGetter = [[ImageStoreManager alloc]init];
    UIImage *image = [UIImage imageWithContentsOfFile:[imageGetter getImageStoreFilePathByHotelId:obj.hotelId]];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(0, 0, 32, 32);
    hotelannotation.leftCalloutAccessoryView = imageView;
    
    UIImage *pinimage = [ UIImage imageNamed: @"hotel" ];
    hotelannotation.image = pinimage;
    hotelannotation.tag = index;
    return hotelannotation;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    if ([control isKindOfClass:[UIButton class]]) {
        [mapView deselectAnnotation:view.annotation animated:NO];
        [self performSegueWithIdentifier:@"mapToDetail" sender:view];
        
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"mapToDetail"]) {
            DetailViewController *desitViewControl = segue.destinationViewController;
        if ([sender isKindOfClass:[MKAnnotationView class]]) {
            MKAnnotationView *annotion = (MKAnnotationView *)sender;
            desitViewControl.aHotel = [self.hotelArray objectAtIndex:annotion.tag];
        }
    }
}

-(IBAction)returnFromDetail:(UIStoryboardSegue *)unwindsegue {
}
@end
