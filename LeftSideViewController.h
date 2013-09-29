//
//  LeftSideViewController.h
//  DWin1.0
//
//  Created by zang qilong on 13-9-16.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IISideController.h"
#import "DWinUtils.h"
@interface LeftSideViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *arr_title ;
}
@property (nonatomic,retain) UITableView *mTableView;
@end
