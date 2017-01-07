//
//  MKMapView+regionMap.m
//  HotelTree
//
//  Created by Lucas Luo on 1/1/17.
//  Copyright © 2017 RJT. All rights reserved.
//

#import "MKMapView+regionMap.h"
#define METERS_PRE_MILE 1609.34

@implementation MKMapView (regionMap)

+ (MKMapView *)showMapRegionWithCoordinate:(CLLocationCoordinate2D)coodinate{
    MKMapView *regionMap = [[MKMapView alloc]init];
    float ASPECTRATIONOFMAPKIT = regionMap.frame.size.width/regionMap.frame.size.height;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coodinate, 0.5*METERS_PRE_MILE, 0.5*METERS_PRE_MILE*ASPECTRATIONOFMAPKIT);
    [regionMap setRegion:region];
    
    return regionMap;
}

@end
