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
@interface FriendListViewController : UIViewController<UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    CGFloat getViewHeight;
    UIView *userTabBar;
    UIView *userInfoView;
    UIView *controlView;
    UIImageView *whiteBlock;
    UIButton *btn_comment;
    UIButton *btn_activity;
    UIButton *btn_map ;
}
@property (nonatomic,retain) UITableView *mTableView;
@property (nonatomic,retain) MapDetailsAnimation *mapInfoView;
@end
