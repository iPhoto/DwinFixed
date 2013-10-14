//
//  ChatEachotherViewController.h
//  DWin1.0
//
//  Created by Mac on 13-9-29.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatEachotherViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate
>
{

    CGFloat getViewHeight;
    UITableView *List_tabView;
    UIImageView *imageViewBackGround2;
    UIImageView *imageViewBackGround;
    


}


@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) UISearchBar *searchBar;

@property (nonatomic,retain) NSMutableDictionary *contactDic;
@property (nonatomic,retain) NSMutableArray *searchByName;
@property (nonatomic,retain) NSMutableArray *searchByPhone;
@end
