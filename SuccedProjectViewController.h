//
//  SuccedProjectViewController.h
//  DWin1.0
//
//  Created by Mac on 13-10-9.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuccedProjectViewController : UIViewController<UIScrollViewDelegate>

{
    
    UIView *back_View,*back_View2,*back_View3,*back_View4,*back_View5;
    BOOL flag_shouqi;
    BOOL flag_shouqi1;
    BOOL flag_shouqi2;
    BOOL flag_shouqi3;
    
    UIButton * shou_btn;
    UIButton * shou_btn3;
    UIButton * shou_btn4;
    UIButton * shou_btn5;
    
    UIScrollView *myScrollView;
    UIPageControl *myPageControl;
}
@property (nonatomic,retain)UIScrollView*scrollview;
@end
