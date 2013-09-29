//
//  AlertAnimation.h
//  ZhiLian02
//
//  Created by Ibokan on 13-4-10.
//  Copyright (c) 2013年 ABC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertAnimation : NSObject
{
    
}
@property(retain,nonatomic)UILabel * lab;
-(void)AlertString:(NSString*)str
andTheview:(UIView*)theview
  andTheFrameHight:(int)hight
   andTheFrameWigh:(int)wigh
andTheFontSize:(int)fontsize;

@end
