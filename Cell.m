//
//  Cell.m
//  DWin1.0
//
//  Created by Mac on 13-9-17.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "Cell.h"
#import <QuartzCore/QuartzCore.h>
@implementation Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
  
        
             //imageview
        self.imgView= [[UIImageView alloc]initWithFrame:CGRectMake(9, 7, 34, 34)];
        self.imgView.image=[UIImage imageNamed:@"headerImge_detail"];
        [self addSubview:self.imgView];
        self.imgView1= [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, 32, 32)];
        self.imgView1.image=[UIImage imageNamed:@""];
        self.imgView1.backgroundColor=[UIColor redColor];
        self.imgView1.layer.cornerRadius=3;
        [self.imgView addSubview:self.imgView1];
        
        self.name_lab=[[UILabel alloc]initWithFrame:CGRectMake(52, 6, 100, 24)];
        self.name_lab.text=@"Aesh";
        self.name_lab.backgroundColor = [UIColor clearColor];
        [self addSubview:self.name_lab];
        
        
        self.time_lab=[[UILabel alloc]initWithFrame:CGRectMake(514/2, 7, 100, 24)];
        self.time_lab.backgroundColor = [UIColor clearColor];
        self.time_lab.font=[UIFont fontWithName:@"Arial" size:12];
        self.time_lab.textColor = [UIColor colorWithRed:80.0/255 green:80.0/255 blue:80.0/255 alpha:1];
        self.time_lab.text=@"2013-8-12";
        [self addSubview:self.time_lab];
        
        self.pinglun_lab = [[UILabel alloc]initWithFrame:CGRectMake(52, 30, 230, 13)];
        
        self.pinglun_lab.text=@"My father was a self-taught mandolin player. He was one of the best string instrument players in our town. He could not read music, but if he heard a tune a few times, he could play it. When he was younger, he was a member of a small country music band. They would play at local dances and on a few occasions would play for the local radio station. He often told us how he had auditioned and earned a position in a band that featured Patsy Cline as their lead singer. He told the family that after he was hired he never went back. Dad was a very religious man. He stated that there was a lot of drinking and cursing the day of his audition and he did not want to be around that type of environment.";
        self.pinglun_lab.font = [UIFont fontWithName:@"Arial" size:14];
        self.pinglun_lab.backgroundColor = [UIColor clearColor];
        
        self.pinglun_lab.numberOfLines=0;
        [self.pinglun_lab sizeToFit];
        [self addSubview:self.pinglun_lab];
    }
    return self;
}
-(CGFloat)setCellHeightdetail
{
    
    NSLog(@"%f------%f",self.imgView.frame.size.height,self.pinglun_lab.frame.size.height-20);

    return self.imgView.frame.size.height+7+self.pinglun_lab.frame.size.height;
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
