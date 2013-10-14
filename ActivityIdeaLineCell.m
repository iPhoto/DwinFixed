//
//  ActivityIdeaLineCell.m
//  DWin1.0
//
//  Created by Mac on 13-10-12.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "ActivityIdeaLineCell.h"
#import <QuartzCore/QuartzCore.h>
#import "DWinUtils.h"
#import "ZXMacro.h"
@implementation ActivityIdeaLineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 添加好友状态
        
        UIImageView *friendView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 280, 161)];
        friendView.image = [UIImage imageWithContentsOfFile:FileS(@"Activityline_back_", @"png")];
        friendView.layer.cornerRadius = 8;
        friendView.layer.masksToBounds = YES;
        //friendView.alpha = 0.7;
       // friendView.backgroundColor =RGBAlpha(1, 1, 1, 0.3);
        
        [self addSubview:friendView];
        
        UIImageView *friendHeadImageView = [[UIImageView alloc]
                                            initWithFrame:CGRectMake(28, 8, 34, 34)];
        friendHeadImageView.layer.cornerRadius = 8;
        friendHeadImageView.image = [UIImage imageNamed:@"acti_small"];
        friendHeadImageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:friendHeadImageView];
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(156, 145, 8, 33)];
        img.image = [UIImage imageWithContentsOfFile:FileS(@"activity_time_line", @"png")];
        [self addSubview:img];
        
                UIImageView *yinhao_imgv = [[UIImageView alloc]initWithFrame:CGRectMake(28+39, 8, 10, 11)];
                yinhao_imgv.image = [UIImage imageWithContentsOfFile:FileS(@"activity_idea_grayyinhao1", @"png")];
        
               [self addSubview:yinhao_imgv];
       
                UIImageView *yinhao_imgv2 = [[UIImageView alloc]initWithFrame:CGRectMake(504/2+20, 264/2, 10, 11)];
                yinhao_imgv2.image = [UIImage imageWithContentsOfFile:FileS(@"activity_idea_grayyinhao2", @"png")];
        
               [self addSubview:yinhao_imgv2];

        
        
        //////////////////解析数据返回来的arr、、、、、、、、、、、、、
        
        //单签界面的绿条的名字叫 activity_green_idea.png
        //录音按钮的名字叫 activity_idea_recordbtn.png
        
        NSArray *arr=[[NSArray alloc]initWithObjects:@"123", nil];
        
        if ([[arr objectAtIndex:0] isKindOfClass:[NSString class]])
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(28+39, 50, 220, 35)];
            label.text = @"Idear:  childhood ";
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:16];
            [self addSubview:label];
            
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(28+39, 85, 220, 35)];
            label1.text = @"Idear:  childhood wo shi  yi ge hao ren  a na ni ne ";
            label1.backgroundColor = [UIColor clearColor];
            label1.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:16];
            label1.numberOfLines=2;
            [label1 sizeToFit];
            [self addSubview:label1];

            
            
        }
        if ([[arr objectAtIndex:0] isMemberOfClass:[UIImage class]])
        {
            NSLog(@"1234567");
        
        }
        if ([[arr objectAtIndex:0] isMemberOfClass:[NSNumber class]])
        {
            NSLog(@"1234567");
        }

        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
