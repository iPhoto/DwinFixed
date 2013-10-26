//
//  ItemButton.m
//  XQSearchPlaces
//
//  Created by xf.lai on 13-7-24.
//  Copyright (c) 2013年 iObitLXF. All rights reserved.
//

#import "ItemView.h"
#import <QuartzCore/QuartzCore.h>

#define aScale_Main 3./5.
#define aScale_Other 4./5.

@implementation ItemView

- (id)initWithFrame:(CGRect)frame buttonFrame:(CGRect)frameBtn lineStart:(CGPoint)p1 lineEnd:(CGPoint)p2 block:(ClickItemViewBlock)aBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.blockButton = aBlock;
        
        self.backgroundColor = [UIColor clearColor];
        self.lineStartP = p1;
        self.lineEndP = p2;

        self.button = [UIButton buttonWithType:UIButtonTypeCustom];

        self.button.frame = frameBtn;
        self.button.center = self.center;
        self.button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview: self.button];
        [self.button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];

        if (CGRectGetHeight(frame)==260) {
            
            self.labelBottom.hidden = YES;
            self.labelTitle_Main = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, CGRectGetWidth(self.button.bounds)-40., 20.)];

            self.labelTitle_Main.center  = CGPointMake(CGRectGetWidth(self.button.bounds)/2., 40);//center1;
            self.labelTitle_Main.textColor = [Utils getColorByTag:self.tag];
            self.labelTitle_Main.textAlignment = NSTextAlignmentCenter;
            self.labelTitle_Main.font = [UIFont boldSystemFontOfSize:12.];

            self.labelTitle_Main.backgroundColor = [UIColor clearColor];
            [self.button addSubview:self.labelTitle_Main];
            // 添加头像
            self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
            self.headImageView.center = CGPointMake(CGRectGetWidth(self.button.bounds)/2., 20);
            self.headImageView.image = [UIImage imageNamed:@"3.jpg"];
            [self.button addSubview:self.headImageView];
            // 添加details
            self.labelDetails = [[UILabel alloc] initWithFrame:CGRectMake(5, 45, CGRectGetWidth(self.button.bounds)-10, 100)];
            [_labelDetails setNumberOfLines:0];
            _labelDetails.lineBreakMode = NSLineBreakByWordWrapping;
            // 测试字串
           NSString *s = @"这是一个测试！！！adsfsaf时发生发勿忘我勿忘我勿忘我勿忘我勿忘我阿阿阿阿阿阿阿阿阿阿阿阿阿啊00000000阿什顿。。。这是一个测试！！！adsfsaf时发生发勿忘我勿忘我勿忘我勿忘我勿忘我阿阿阿阿阿阿阿阿阿阿阿阿阿啊00000000阿什顿。。这是一个测试！！！adsfsaf时发生发勿忘我勿忘我勿忘我勿忘我勿忘我阿阿阿阿阿阿阿阿阿阿阿阿阿啊00000000阿什顿。。";
            UIFont *font = [UIFont systemFontOfSize:8];
            _labelDetails.font = font;
            _labelDetails.backgroundColor = [UIColor clearColor];
            
            //_labelDetails.frame = CGRectMake(0, 40, labelsize.width, labelsize.height);
            _labelDetails.text = s;
            [self.button addSubview:_labelDetails];

        }
        else
        {

            self.labelBottom = [[UILabel alloc]init];
            CGRect labelFrame = CGRectMake(0, 0, CGRectGetWidth(frameBtn), CGRectGetWidth(frameBtn));//
            self.labelBottom.frame = labelFrame;
           self.labelBottom.center  = CGPointMake(CGRectGetWidth(self.button.bounds)/2., CGRectGetHeight(self.button.bounds)/2.);
            self.labelBottom.textAlignment = NSTextAlignmentCenter;
            self.labelBottom.font = [UIFont systemFontOfSize:10.];
            self.labelBottom.textColor = [Utils getColorByTag:self.tag];

            self.labelBottom.backgroundColor = [UIColor clearColor];
            [self.button addSubview:self.labelBottom];
            // 添加图片
            self.childItemImageView = [[UIImageView alloc] init];
            self.childItemImageView.frame = CGRectMake(0, 0, 44, 44);
            self.childItemImageView.center = CGPointMake(CGRectGetWidth(self.button.bounds)/2., CGRectGetHeight(self.button.bounds)/2.);
            [self.button addSubview:self.childItemImageView];
        }

    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    
    if (self.lineEndP.x == self.lineStartP.x && self.lineStartP.y == self.lineEndP.y) {
        return;
    }
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
}
-(void)drawInContext:(CGContextRef)context
{
    CGContextSetLineWidth(context,1.);
    CGContextMoveToPoint(context, self.lineStartP.x, self.lineStartP.y);//起点
    CGContextAddLineToPoint(context, self.lineEndP.x, self.lineEndP.y);//终点
   CGContextSetStrokeColorWithColor(context, [UIColor purpleColor].CGColor);//设置线的颜色
    CGContextStrokePath(context);
    
   
}

-(IBAction)clickButton:(id)sender
{
    self.blockButton(self);
}
@end
