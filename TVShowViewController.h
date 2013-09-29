//
//  TVShowViewController.h
//  DWin1.0
//
//  Created by zang qilong on 13-9-27.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVShowCell.h"
@interface TVShowViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) UITableView *mTableView;
@end
