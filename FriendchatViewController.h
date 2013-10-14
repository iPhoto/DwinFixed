//
//  FriendchatViewController.h
//  DWin1.0
//
//  Created by Mac on 13-9-27.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendchatViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    CGFloat getViewHeight;
    UITableView *List_tabView;
    UIImageView *imageViewBackGround2;
    UIImageView *imageViewBackGround;
    
    
    
    ////////////////////////////////////////////////////
    
    NSArray *listarray;
    NSArray *secLabelArray;
    NSMutableDictionary *arrayDict;
    NSArray *arrayDictKey;
    UITableView* tableView;
    
    
}

@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) UISearchBar *searchBar;

@property (nonatomic,retain) NSMutableDictionary *contactDic;
@property (nonatomic,retain) NSMutableArray *searchByName;
@property (nonatomic,retain) NSMutableArray *searchByPhone;
////////////////////////////////////////////////////////

@property (nonatomic,retain)NSArray *listarray;
@property (nonatomic,retain)NSArray *secLabelArray;
@property (nonatomic,retain)NSMutableDictionary *arrayDict;
@property (nonatomic,strong)NSArray *arrayDictKey;

@end
