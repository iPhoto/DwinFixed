//
//  ActivityBusinessViewController.h
//  DWin1.0
//
//  Created by Mac on 13-10-10.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityBusinessViewController : UIViewController<UIScrollViewDelegate>
{

    UIScrollView *myScrollView;
    UIPageControl *myPageControl;
}
@property (nonatomic,retain)UIScrollView*scrollview;
@end
