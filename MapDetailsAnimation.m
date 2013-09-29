//
//  MapDetailsAnimation.m
//  DWin1.0
//
//  Created by zang qilong on 13-9-26.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "MapDetailsAnimation.h"

@implementation MapDetailsAnimation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 44, self.bounds.size.width, self.bounds.size.height-44)];
        _mapView.showsUserLocation = YES;
        CLLocationCoordinate2D userlocation = _mapView.userLocation.coordinate;
        NSLog(@"%f,%f",userlocation.latitude,userlocation.longitude);
        MKCoordinateRegion region = [_mapView regionThatFits:MKCoordinateRegionMakeWithDistance(_mapView.userLocation.location.coordinate, 2000, 2000)];
        [_mapView setRegion:region];
        [self addSubview:_mapView];
        //
        self.locationManager = [[CLLocationManager alloc] init];
  
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        self.locationManager.distanceFilter = 10; // or whatever
       
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
