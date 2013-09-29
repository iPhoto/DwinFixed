//
//  MapOverlayViewController.h
//  XQTest
//
//  Created by xf.lai on 13-7-18.
//  Copyright (c) 2013年 xf.lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MediaPlayer/MediaPlayer.h>

typedef struct {
	CLLocationDegrees latitudeLeft;
    CLLocationDegrees latitudeRight;
	CLLocationDegrees longitudeUp;
    CLLocationDegrees longitudeDown;
} AreaLocation;

@protocol MapViewControllerDelegate;

@interface MapViewController : UIViewController<MKMapViewDelegate>
{

    CLLocationCoordinate2D          newLocCoordinate;
   
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentController;

@property (nonatomic, strong) NSString *strTitle;
@property (nonatomic, strong) NSMutableArray    *dataArray;
@property (nonatomic, assign) id<MapViewControllerDelegate> delegate;

@end

@protocol MapViewControllerDelegate
-(void)clickBgButton:(UIView *)aView;
-(void)clickCloseButton;
@end
