//
//  SucViewController.h
//  DWin1.0
//
//  Created by Mac on 13-10-10.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SucViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataList;
    
    NSMutableArray *_nameArray;
    NSIndexPath *_selsectedIndexPath;
    
    NSMutableArray *boolArray;

}

@property (nonatomic, copy) NSMutableArray *nameArray;
@end
