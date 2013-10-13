//
//  AlertAnimation.m
//  ZhiLian02
//
//  Created by Ibokan on 13-4-10.
//  Copyright (c) 2013年 ABC. All rights reserved.
//

#import "AlertAnimation.h"
#import <QuartzCore/QuartzCore.h>
@implementation AlertAnimation
@synthesize lab;
-(void)AlertString:(NSString*)str
        andTheview:(UIView*)theview
  andTheFrameHight:(int)hight
   andTheFrameWigh:(int)wigh
    andTheFontSize:(int)fontsize
{
   
    lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, wigh, hight)];
   lab.text = str;
   lab.layer.cornerRadius=3;
    [lab setFont:[UIFont systemFontOfSize:fontsize]];
   lab.textColor=[UIColor whiteColor];
    lab.lineBreakMode = NSLineBreakByCharWrapping;
    lab.numberOfLines=0;
    lab.center=theview.center;
    lab.textAlignment=NSTextAlignmentCenter;
    lab.backgroundColor=[UIColor blackColor];
    
    [theview addSubview:lab];
    
    //添加动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(stop)];
    [UIView setAnimationDuration:5
     ];
    lab.alpha=0;
    [UIView commitAnimations];
    NSLog(@"alert");
    
    
}
-(void)stop
{
    [lab removeFromSuperview];
}
@end
