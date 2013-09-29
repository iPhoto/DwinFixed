//
//  Cell.h
//  DWin1.0
//
//  Created by Mac on 13-9-17.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell
@property(nonatomic,strong)UIImageView *imgView,*imgView1;
@property(nonatomic,strong)UILabel *name_lab;
@property(nonatomic,strong)UILabel *time_lab;
@property(nonatomic,strong)UILabel *pinglun_lab;
-(CGFloat)setCellHeightdetail;
@end
