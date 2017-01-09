//
//  MKMapView+regionMap.h
//  HotelTree
//
//  Created by Lucas Luo on 1/1/17.
//  Copyright © 2017 RJT. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (regionMap)

+ (MKMapView *)showMapRegionWithCoordinate:(CLLocationCoordinate2D)coodinate;

@end
