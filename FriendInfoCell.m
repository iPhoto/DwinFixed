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
        _friendHeadImageView = [[UIImageView alloc]
                                            initWithFrame:CGRectMake(5, 5, 34, 34)];
        _friendHeadImageView.layer.cornerRadius = 8;
        _friendHeadImageView.image = [UIImage imageNamed:@"dog.jpg"];
        _friendHeadImageView.backgroundColor = [UIColor whiteColor];
        [friendTitleView addSubview:_friendHeadImageView];
        //头像下面加btn
        UIButton *bt = [UIButton buttonWithType: UIButtonTypeCustom];
        bt.tag=1000+i;
        i++;
        [bt setFrame:CGRectMake(0, 0, friendView.frame.size.width, 44)];
        [bt addTarget:self action:@selector(bu:) forControlEvents:UIControlEventTouchUpInside];
        //bt.backgroundColor = [UIColor redColor];
        [friendTitleView addSubview:bt];
        
        
        // 好友姓名
        _frienName2 = [DWinUtils createLabelForAutoSize:CGPointMake(43, 5) WithContent:@"zang qi long" WithFontSize:18 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor whiteColor]] ;
        
        [friendTitleView addSubview:_frienName2];
        // 地址图标
        UIImageView *imageLocation = [[UIImageView alloc] initWithFrame:CGRectMake(_frienName2.frame.origin.x+_frienName2.frame.size.width, 8, 8, 14)];
        imageLocation.image = [UIImage imageNamed:@"friendlist_location"];
        [friendTitleView addSubview:imageLocation];
        // 地址信息
        _locationText2 = [DWinUtils createLabelForAutoSize:CGPointMake(imageLocation.frame.origin.x+10, 10) WithContent:@"Xiangxieshe" WithFontSize:11 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor whiteColor]];
        [friendTitleView addSubview:_locationText2];
        // Tag
        _kindOfTag = [DWinUtils createLabelForAutoSize:CGPointMake(43, 28) WithContent:@"#Love" WithFontSize:12 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor redColor]];
        [friendTitleView addSubview:_kindOfTag];
        
                // 介绍
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:12];
        _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descriptionLabel.numberOfLines = 3;
        _descriptionLabel.text = @"兵者，国之大事，死生之地，存亡之道，不可不察也。故经之以五事，校之以计，而索其情：一曰道，二曰天，三曰地，四曰将，五曰法。道者，令民于上同意，可与之死，可与之生，而不诡也；天者，阴阳、寒暑、时制也；地者，远近、险易、广狭、死生也；将者，智、信、仁、勇、严也";
        _descriptionLabel.textColor = [UIColor whiteColor];
        NSLog(@"%f,%f",_descriptionLabel.frame.size.height,_descriptionLabel.frame.size.width);
        _descriptionLabel.frame = CGRectMake(5, 50, 290, 45);
        [friendView addSubview:_descriptionLabel];
        _descriptionLabel.backgroundColor = [UIColor clearColor];
        // 图片
        _imageFriendImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 110, 135, 80)];
        _imageFriendImage.image = [UIImage imageNamed:@"mainpage_imagebg.png"];
        [friendView addSubview:_imageFriendImage];
        // video
        _imageFriendVideo = [[UIImageView alloc] initWithFrame:CGRectMake(160, 110, 135, 80)];
        _imageFriendVideo.image = [UIImage imageNamed:@"mainpage_videobg.png"];
        [friendView addSubview:_imageFriendVideo];
        // 播放键
        UIImageView *imageplay = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        imageplay.center = CGPointMake(CGRectGetWidth(_imageFriendVideo.frame)/2, CGRectGetHeight(_imageFriendVideo.frame)/2);
        imageplay.image = [UIImage imageNamed:@"friendlist_playbtn"];
        [_imageFriendVideo addSubview:imageplay];
        // line
        UIImageView *imageLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 195, friendView.frame.size.width, 1)];
        imageLine.image = [UIImage imageNamed:@"friendlist_line"];
        [friendView addSubview:imageLine];
        // comments number
        _labelCommentNum = [[UILabel alloc] initWithFrame:CGRectMake(10, 205, 100, 30)];
        _labelCommentNum.textColor = [UIColor whiteColor];
        _labelCommentNum.text = @"10000Notes";
        _labelCommentNum.backgroundColor = [UIColor clearColor];
        [friendView addSubview:_labelCommentNum];
        //写留言
        
        
        
        NSArray *arr=[[NSArray alloc]initWithObjects:@"friendlist_leavecomment",@"friendlist_share",@"friendlist_star", nil];
        UIButton *writeCommentBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        writeCommentBtn.frame=CGRectMake(150+25+45*0, 205, 25, 25);
        [writeCommentBtn setBackgroundImage:[UIImage imageNamed:[arr objectAtIndex:0]] forState:UIControlStateNormal];
        [friendView addSubview:writeCommentBtn];
        // 转发
        
        UIButton *shareBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        shareBtn.frame=CGRectMake(150+25+45*1, 205, 25, 25);
        [shareBtn setBackgroundImage:[UIImage imageNamed:[arr objectAtIndex:1]] forState:UIControlStateNormal];
        [friendView addSubview:shareBtn];
        // 赞
        _voteBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        _voteBtn.frame=CGRectMake(150+25+45*2, 205, 25, 25);
        [_voteBtn setBackgroundImage:[UIImage imageNamed:[arr objectAtIndex:2]] forState:UIControlStateNormal];
        [friendView addSubview:_voteBtn];
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
