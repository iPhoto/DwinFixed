//
//  TextSubPhotoView.m
//  DWin1.0
//
//  Created by zang qilong on 13-10-10.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "TextSubPhotoView.h"
#import "ShootViewController.h"
@implementation TextSubPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        // 拍照
        for (int i=0; i<4; i++) {
            if (i==1) {
                continue;
            }
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(16*(i+1)+60*i, 40, 60, 60);
            if (i==2) {
                btn.center = CGPointMake(160, 70);
            }
            
            [btn addTarget:self action:@selector(navAction) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 1000+i;
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"controlphoto%d",i+1]];
            [btn setBackgroundImage:image forState:UIControlStateNormal];
            [self addSubview:btn];
        }
       
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
