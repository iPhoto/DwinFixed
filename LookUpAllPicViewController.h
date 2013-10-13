//
//  LookUpAllPicViewController.h
//  DWin1.0
//
//  Created by Mac on 13-9-28.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGViewController.h"
@interface LookUpAllPicViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *pictabView;
    UIImageView *img;
    ALAssetsLibrary *library;
    
    //  NSArray *imageArray;
    
    NSMutableArray *mutableArray;
    UIButton*btn;
    NSMutableArray *arr;


}

@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,assign)int fag_number;
@property(nonatomic,strong)UIScrollView *scrolView;
@end
