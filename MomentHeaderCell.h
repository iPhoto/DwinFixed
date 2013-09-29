//
//  MomentHeaderCell.h
//  DWin1.0
//
//  Created by Mac on 13-9-17.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MomentHeaderCell : UITableViewCell

@property(nonatomic,strong)UILabel *tag_lab;
@property(nonatomic,strong) UILabel *time_lab;
@property(nonatomic,strong)UILabel *usersay_lab;
@property(nonatomic,strong)UIImageView* avatarImage;
@property(nonatomic,strong)UILabel *pinglun_lab;
@property(nonatomic,strong)UILabel *zhuanfa_lab;
-(CGFloat)setCellHeight;
@end
