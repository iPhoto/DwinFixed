//
//  MapDetailsAnimation.h
//  DWin1.0
//
//  Created by zang qilong on 13-9-26.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface MapDetailsAnimation : UIView
@property (nonatomic,retain) MKMapView *mapView;
@property (nonatomic,retain) CLLocationManager *locationManager;
@end
