//
//  ActvityProjectDetailViewController.h
//  DWin1.0
//
//  Created by Mac on 13-10-14.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
@interface ActvityProjectDetailViewController : UIViewController
{

    UILabel *lab_title2;
    UITextField * Partner;
    UITextField * topic;
    UIView * back_View2,*back_View3;
    BOOL flagUp;
    BOOL flaglock;
    UIScrollView*  scr;
    BOOL flagUp3;


}

@end
