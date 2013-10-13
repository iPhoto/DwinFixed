//
//  PersonalSpaceViewController.h
//  DWin1.0
//
//  Created by zang qilong on 13-10-12.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalSpaceViewController : UIViewController
<UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    CGFloat getViewHeight;
    UIView *userTabBar;
    UIView *userInfoView;
    UIView *controlView;
}

@end
