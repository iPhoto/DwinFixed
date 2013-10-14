//
//  ActivityProjectfirstViewController.h
//  DWin1.0
//
//  Created by Mac on 13-10-12.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityProjectfirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    UIView *back_View,*back_View2,*back_View3,*back_View4,*back_View5;
    UIScrollView *scr;
    UIImageView *imageViewBackGround;
}
@property (nonatomic,strong) UITableView *mTableView;


@end
