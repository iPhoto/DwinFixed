//
//  MySpaceViewController.h
//  DWin1.0
//
//  Created by Mac on 13-9-24.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXMacro.h"

#import "DWinUtils.h"
@interface MySpaceViewController : UIViewController<UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{

    CGFloat getViewHeight;
    UIView *userTabBar;
    UIView *userInfoView;
    UIView *controlView;
}

@property (nonatomic,retain) UITableView *mTableView;
@end
