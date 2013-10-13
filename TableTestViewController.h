//
//  TableTestViewController.h
//  VideoCapture
//
//  Created by zang qilong on 13-10-12.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableTestViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain) UITableView *mTableView;
@property (nonatomic,retain) UIView *headerView;
@property (nonatomic,retain) NSMutableArray *keys;
@property (nonatomic,retain) NSMutableArray *name;
@property (nonatomic,retain) UISearchBar *mSearchBar;
@end
