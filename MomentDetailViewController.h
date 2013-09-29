//
//  MomentDetailViewController.h
//  DWin1.0
//
//  Created by Mac on 13-9-17.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceToolBar.h"
@interface MomentDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,FaceToolBarDelegate>
{
    UIImageView*imageViewBackGround;
    UIToolbar*toolbar;
}
@property(nonatomic,strong)UITableView *momentTabelView;
@property(nonatomic,strong)UITextField *detail_texfold;
@property(nonatomic,strong)UIImageView *shareView;

@end
