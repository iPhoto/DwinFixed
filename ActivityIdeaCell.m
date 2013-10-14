//
//  ActivityIdeaCell.m
//  DWin1.0
//
//  Created by Mac on 13-10-12.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "ActivityIdeaCell.h"
#import <QuartzCore/QuartzCore.h>
#import "DWinUtils.h"
#import "ZXMacro.h"
@implementation ActivityIdeaCell
static int i=0;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        // 添加好友状态
        UIView *friendView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 240)];
        friendView.layer.cornerRadius = 8;
        friendView.layer.masksToBounds = YES;
        //friendView.alpha = 0.7;
        friendView.backgroundColor =RGBAlpha(1, 1, 1, 0.3);
        
        [self addSubview:friendView];
        // 标题视图
        UIView *friendTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, friendView.frame.size.width, 44)];
        friendTitleView.backgroundColor = RGBAlpha(0, 0, 0, 0.3);
        [friendView addSubview:friendTitleView];
        // 好友头像
        
        //头像下面加btn
        UIButton *bt = [UIButton buttonWithType: UIButtonTypeCustom];
        bt.tag=1000+i;
        i++;
        [bt setFrame:CGRectMake(0, 0, friendView.frame.size.width, 44)];
        // [bt addTarget:self action:@selector(bu:) forControlEvents:UIControlEventTouchUpInside];
        //bt.backgroundColor = [UIColor redColor];
        [friendTitleView addSubview:bt];
        
        UIImageView *friendHeadImageView = [[UIImageView alloc]
                                            initWithFrame:CGRectMake(8, 8, 28, 28)];
        friendHeadImageView.layer.cornerRadius = 8;
        friendHeadImageView.image = [UIImage imageNamed:@"acti_small"];
        friendHeadImageView.backgroundColor = [UIColor whiteColor];
        [friendTitleView addSubview:friendHeadImageView];
        
        
        // 好友姓名
        UILabel *frienName2 = [DWinUtils createLabelForAutoSize:CGPointMake(43, 5) WithContent:@"Marry" WithFontSize:30*0.6 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor whiteColor]] ;
        
        [friendTitleView addSubview:frienName2];
        // 地址图标
        UIImageView *imageLocation = [[UIImageView alloc] initWithFrame:CGRectMake(frienName2.frame.origin.x+frienName2.frame.size.width, 12, 6, 9)];
        imageLocation.image = [UIImage imageNamed:@"friendlist_location"];
        [friendTitleView addSubview:imageLocation];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(245, 0, 100, 25)];
        lab.text = @"2013-09-09";
        lab.backgroundColor = [UIColor clearColor];
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont fontWithName:HELVETICANUEU size:18*0.6];
        [self addSubview:   lab ];
        
        ///////////////////////////// 地址信息 // Tag// 介绍  // ////////////////////
        UILabel *locationText2    = [DWinUtils createLabelForAutoSize:CGPointMake(imageLocation.frame.origin.x+10, 10) WithContent:@"Xiangxieshe" WithFontSize:18*0.6 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor whiteColor]];
        UILabel *loveTag          = [DWinUtils createLabelForAutoSize:CGPointMake(43, 24) WithContent:@"#Love" WithFontSize:22*0.6 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor redColor]];
                UIImageView *yinhao_imgv = [[UIImageView alloc]initWithFrame:CGRectMake(19, 49, 10, 11)];
               yinhao_imgv.image = [UIImage imageWithContentsOfFile:FileS(@"activit_idea_yinhao1", @"png")];
        
                [self addSubview:yinhao_imgv];
        
                UIImageView *yinhao_imgv2 = [[UIImageView alloc]initWithFrame:CGRectMake(566/2+10, 169, 10, 11)];
                yinhao_imgv2.image = [UIImage imageWithContentsOfFile:FileS(@"activit_idea_yinhao2", @"png")];
        
               [self addSubview:yinhao_imgv2];
        
        UILabel *descriptionLabel = [DWinUtils createLabelForAutoSize:CGPointMake(43, 50) WithContent:@"Childhood" WithFontSize:22*0.6 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor whiteColor]];
        
        UILabel *descriptionLabel1 = [DWinUtils createLabelForAutoSize:CGPointMake(43, 100) WithContent:@"If one begins with the phenomenology of consciousness one must give an account " WithFontSize:22*0.6 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor whiteColor]];
        [self addSubview:descriptionLabel1];
        UILabel *happyTag = [DWinUtils createLabelForAutoSize:CGPointMake(kCalculateX(loveTag)+3, 24) WithContent:@"#Happy" WithFontSize:22*0.6 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor blueColor]];
        
        
        [friendTitleView addSubview:locationText2];
        [friendTitleView addSubview:loveTag];
        [friendTitleView addSubview:happyTag];
        [friendView addSubview:descriptionLabel];
        
        
        
        /////////////////////////   // 图片// video// line   //////////////////////////
        
        UIButton *imageFriendImage = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *imageFriendVideo = [UIButton buttonWithType:UIButtonTypeCustom];
        imageFriendImage.frame = CGRectMake(10, 110, 135, 80);
        imageFriendVideo.frame = CGRectMake(160, 110, 135, 80);
        
        UIImageView *imageLine        = [[UIImageView alloc] initWithFrame:CGRectMake(0, 195, friendView.frame.size.width, 1)];
        
        [imageFriendImage setBackgroundImage:[UIImage imageNamed:@"mainpage_imagebg.png"] forState:UIControlStateNormal];
        
        [imageFriendVideo setBackgroundImage:[UIImage imageNamed:@"mainpage_videobg.png"] forState:UIControlStateNormal];
        imageLine.image = [UIImage imageNamed:@"friendlist_line"];
        
        // [friendView addSubview:imageFriendImage];
        //  [friendView addSubview:imageFriendVideo];
        [friendView addSubview:imageLine];
        
        ////////////////////////////// comments number ////////////////////////////
        
        UILabel *labelComment = [[UILabel alloc] initWithFrame:CGRectMake(10, 205, 100, 30)];
        labelComment.textColor = [UIColor whiteColor];
        labelComment.text = @"10000 Joins";
        labelComment.backgroundColor = [UIColor clearColor];
        [friendView addSubview:labelComment];
        //
        
        ////////////////////////////// 评论，转发，赞的三个pic/////////////////////////////
        
        NSArray*arr=[[NSArray alloc]initWithObjects:@"activity_luyin",@"friendlist_star", nil];
        
        
        
        
        
        ////////////////////////////// 评论，转发，赞的三个btn /////////////////////////////
        
        for (int i=0; i<2; i++)
        {
            UIButton*shareBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            if (i==0) {
                shareBtn.frame=CGRectMake(200+44*i, 196, 44, 44);
            }
            if (i==1) {
                shareBtn.frame=CGRectMake(200+54*i, 205, 25, 25);
            }
            
            
            [shareBtn setBackgroundImage:[UIImage imageNamed:[arr objectAtIndex:i]] forState:UIControlStateNormal];
            shareBtn.tag = 9000+i;
            
            [friendView addSubview:shareBtn];
        }
        UIImageView *access_imgv3 = [[UIImageView alloc]initWithFrame:CGRectMake(558/2, 17, 9, 16)];
        access_imgv3.image = [UIImage imageWithContentsOfFile:FileS(@"activity_right_arrow", @"png")];
        [self addSubview:access_imgv3];
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
