//
//  MomentHeaderCell.m
//  DWin1.0
//
//  Created by Mac on 13-9-17.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "MomentHeaderCell.h"

@implementation MomentHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //tag
        _tag_lab = [[UILabel alloc]initWithFrame:CGRectMake(9, 10, 280, 33)];
        _tag_lab.text=@"#LOVE";
        _tag_lab.backgroundColor=[UIColor clearColor];
        [self addSubview:_tag_lab];
        
        //time
        _time_lab = [[UILabel alloc]initWithFrame:CGRectMake(504/2, 10, 280, 33)];
        _time_lab.backgroundColor=[UIColor clearColor];
        _time_lab.textColor = [UIColor colorWithRed:80.0/255 green:80.0/255 blue:80.0/255 alpha:1];
        _time_lab.font=[UIFont fontWithName:@"Arial" size:12];
        _time_lab.text=@"2013-08-12";
        [self addSubview:_time_lab];
        
        //what user say
        _usersay_lab = [[UILabel alloc]initWithFrame:CGRectMake(9, 40, 302, 26)];
        _usersay_lab.text=@"you aer eorieow isu h hjhsfhjjsb blahsfl  hlasfh b ll l   llhuhlh  hu yuohoiu ";
        _usersay_lab.backgroundColor = [UIColor clearColor];
        [_usersay_lab setNumberOfLines:0];
        [_usersay_lab sizeToFit];
         _usersay_lab.font = [UIFont fontWithName:@"Arial" size:14];
        [self addSubview:_usersay_lab];
        
        //imageview
        _avatarImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 101, 280, 317/2)];
        _avatarImage.image=[UIImage imageNamed:@"momentcell_ceshi_img"];
        [self addSubview:_avatarImage];
        
        //转发，评论label
        _pinglun_lab = [[UILabel alloc]initWithFrame:CGRectMake(9, 628/2-44, 100, 290-101-317/2)];
        _pinglun_lab.text=@"C:(1000)";
        _pinglun_lab.numberOfLines=0;
        _pinglun_lab.backgroundColor=[UIColor clearColor];
        [self addSubview:_pinglun_lab];
        
        _zhuanfa_lab = [[UILabel alloc]initWithFrame:CGRectMake(_pinglun_lab.frame.size.width+9, 628/2-44, 100, 290-101-317/2)];
        _zhuanfa_lab.text=@"R:(1000)";
        _zhuanfa_lab.backgroundColor = [UIColor clearColor];
        _zhuanfa_lab.numberOfLines = 0;
        [self addSubview:_zhuanfa_lab];
        
        // Initialization code
    }
    return self;
}
-(CGFloat)setCellHeight{
    
    
      NSLog(@"---------------------------%f",self.tag_lab.frame.size.height);
    NSLog(@"---------------------------%f",_avatarImage.frame.size.height);
     NSLog(@"---------------------------%f",_usersay_lab.frame.size.height);
    return self.tag_lab.frame.size.height+_avatarImage.frame.size.height+_usersay_lab.frame.size.height+self.pinglun_lab.frame.size.height+44;
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
