//
//  AudiolineViewController.h
//  DWin1.0
//
//  Created by Mac on 13-10-13.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudiolineViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>{UIButton* starbtn;}
@property (nonatomic,strong) UITableView *mTableView;

@end
