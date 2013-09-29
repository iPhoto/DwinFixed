//
//  ShootViewController.h
//  DWin1.0
//
//  Created by zang qilong on 13-9-20.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ZXMacro.h"
#import "IIViewDeckController.h"
#import "CaptureSessionManager.h"
@class ShootViewController;
@protocol ShootViewControllerDelegate<NSObject>
- (void)shootViewController:(UIImage *)image;

@end
@interface ShootViewController : UIViewController
{
    UIImageView *imageViewShowEffect;
    UIScrollView *filterScroll;
    BOOL isScrollHide;
     CALayer *btnLayer;
     UIImageView*btnImage;
    UIImageView *contentView;
    int flag;
    int flag2;
    BOOL isComplexFilterOpen;
    BOOL isCutModelOpen;
    id <ShootViewControllerDelegate> delegate;
    UIButton *btn_hardFilter ;
    UIButton *btn_cutImage;
}
@property (strong, nonatomic) UIButton *btnChangeFlashAuto;
@property (strong, nonatomic) UIButton *btnChangeCamera;
@property (strong, nonatomic) UIView *controlView;
@property (strong, nonatomic) UIButton *btnHideAndShowFilter;
@property (strong, nonatomic) UIImageView *lastImageView;
@property (strong, nonatomic)  UIButton *btnChangeFlashOpen;
@property (strong, nonatomic)  UIButton *btnChangeFlashClose;
@property (assign,nonatomic) id <ShootViewControllerDelegate> delegate;
@property (strong, nonatomic) UIImage *shootStillImage;

@property (strong, nonatomic)  UIView *viewLightBG;
@property (nonatomic,retain) UIImageView *imagePreView;
@property (nonatomic,retain) UIImage *imageAddFilter;
@property (retain,nonatomic) CaptureSessionManager *captureManager;

@property (nonatomic,retain) UIView *theFilterView;
@property (nonatomic,retain) UIView *filterControlView;
@property(nonatomic,strong) UIButton*mybuton1;
@end
