//
//  FriendInfoCell.m
//  DWin1.0
//
//  Created by zang qilong on 13-9-16.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "FriendInfoCell.h"
#import <QuartzCore/QuartzCore.h>
#import "DWinUtils.h"
#import "ZXMacro.h"
@implementation FriendInfoCell
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
        [bt addTarget:self action:@selector(bu:) forControlEvents:UIControlEventTouchUpInside];
        //bt.backgroundColor = [UIColor redColor];
        [friendTitleView addSubview:bt];
        
        UIImageView *friendHeadImageView = [[UIImageView alloc]
                                            initWithFrame:CGRectMake(5, 5, 34, 34)];
        friendHeadImageView.layer.cornerRadius = 8;
        friendHeadImageView.image = [UIImage imageNamed:@"dog.jpg"];
        friendHeadImageView.backgroundColor = [UIColor whiteColor];
        [friendTitleView addSubview:friendHeadImageView];
        // 好友姓名
        UILabel *frienName2 = [DWinUtils createLabelForAutoSize:CGPointMake(43, 5) WithContent:@"Marry Kelly" WithFontSize:18 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor whiteColor]] ;
        
        [friendTitleView addSubview:frienName2];
        // 地址图标
        UIImageView *imageLocation = [[UIImageView alloc] initWithFrame:CGRectMake(frienName2.frame.origin.x+frienName2.frame.size.width, 8, 8, 14)];
        imageLocation.image = [UIImage imageNamed:@"friendlist_location"];
        [friendTitleView addSubview:imageLocation];
        // 地址信息
        UILabel *locationText2 = [DWinUtils createLabelForAutoSize:CGPointMake(imageLocation.frame.origin.x+10, 10) WithContent:@"Xiangxieshe" WithFontSize:11 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor whiteColor]];
        [friendTitleView addSubview:locationText2];
        // Tag
        UILabel *loveTag = [DWinUtils createLabelForAutoSize:CGPointMake(43, 28) WithContent:@"#Love" WithFontSize:12 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor redColor]];
        [friendTitleView addSubview:loveTag];
        
        UILabel *happyTag = [DWinUtils createLabelForAutoSize:CGPointMake(kCalculateX(loveTag)+3, 28) WithContent:@"#Happy" WithFontSize:12 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor blueColor]];
        [friendTitleView addSubview:happyTag];
        // 介绍
        UILabel *descriptionLabel = [DWinUtils createLabelForAutoSize:CGPointMake(5, 50) WithContent:@"If one begins with the phenomenology of consciousness one must give an account of the origin of material objects as they arise in conscious experience. " WithFontSize:12 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor whiteColor]];
        [friendView addSubview:descriptionLabel];
        // 图片
        UIImageView *imageFriendImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 110, 135, 80)];
        imageFriendImage.image = [UIImage imageNamed:@"mainpage_imagebg.png"];
        [friendView addSubview:imageFriendImage];
        // video
        UIImageView *imageFriendVideo = [[UIImageView alloc] initWithFrame:CGRectMake(160, 110, 135, 80)];
        imageFriendVideo.image = [UIImage imageNamed:@"mainpage_videobg.png"];
        [friendView addSubview:imageFriendVideo];
        // line
        UIImageView *imageLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 195, friendView.frame.size.width, 1)];
        imageLine.image = [UIImage imageNamed:@"friendlist_line"];
        [friendView addSubview:imageLine];
        // comments number
        UILabel *labelComment = [[UILabel alloc] initWithFrame:CGRectMake(10, 205, 100, 30)];
        labelComment.textColor = [UIColor whiteColor];
        labelComment.text = @"10000Notes";
        labelComment.backgroundColor = [UIColor clearColor];
        [friendView addSubview:labelComment];
        //
        
        
        NSArray*arr=[[NSArray alloc]initWithObjects:@"friendlist_leavecomment",@"friendlist_share",@"friendlist_star", nil];
        for (int i=0; i<3; i++) {
            UIButton*shareBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            shareBtn.frame=CGRectMake(150+25+45*i, 205, 25, 25);
            [shareBtn setBackgroundImage:[UIImage imageNamed:[arr objectAtIndex:i]] forState:UIControlStateNormal];
            [friendView addSubview:shareBtn];
        }
       
    }
    return self;
}
-(void)bu:(UIButton*)sender
{
    
    NSLog(@"1234567890");
     int a=sender.tag-1000;
    NSString *str=[NSString stringWithFormat:@"%d",a];
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:str,@"123", nil];
    
   
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"xiangzuo" object:self userInfo:dic ];

   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
