//
//  FriendListViewController.h
//  DWin1.0
//
//  Created by zang qilong on 13-9-12.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXMacro.h"
#import "DRNRealTimeBlurView.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
#import "MapDetailsAnimation.h"
#import <CoreLocation/CoreLocation.h>

typedef struct {
	CLLocationDegrees latitudeLeft;
    CLLocationDegrees latitudeRight;
	CLLocationDegrees longitudeUp;
    CLLocationDegrees longitudeDown;
} AreaLocation;

@interface FriendListViewController : UIViewController<UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate>
{
    CGFloat getViewHeight;
    UIView *userTabBar;
    UIView *userInfoView;
    UIView *controlView;
    UIImageView *whiteBlock;
    UIButton *btn_comment;
    UIButton *btn_activity;
    UIButton *btn_map ;
    CLLocationCoordinate2D          newLocCoordinate;
    
    UIView *back_View,*back_View2,*back_View3,*back_View4,*back_View5;
    ////////activity///////////
    UIScrollView *scr;
    UIImageView *imageViewBackGround ;
}
@property (strong, nonatomic)  MKMapView *mapView;
@property (nonatomic, strong) NSString *strTitle;
@property (nonatomic, strong) NSMutableArray    *dataArray;
@property (nonatomic,retain) UITableView *mTableView;
@property (nonatomic,retain) MapDetailsAnimation *mapInfoView;
@end
