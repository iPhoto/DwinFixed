//
//  GetStaticImage.m
//  DWin1.0
//
//  Created by zang qilong on 13-9-16.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "GetStaticImage.h"
#import "UIImage+BoxBlur.h"
#import <QuartzCore/QuartzCore.h>
@implementation GetStaticImage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
- (id)initWithFatherView:(UIView *)father withRect:(CGRect)rect withBlurRadius:(CGFloat)radius
{
    self = [super initWithFrame:rect];
    if (self) {
        self.fatherView = father;
        self.blurRadius = radius;
        [self drawRect:rect];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGRect visibleRect = [self.fatherView convertRect:self.frame toView:self];
    visibleRect.origin.y += self.frame.origin.y;
    visibleRect.origin.x += self.frame.origin.x;
    
    //hide all the blurred views from the superview before taking a screenshot
//    CGFloat alpha = self.alpha;
//    [self toggleBlurViewsInView:superview hidden:YES alpha:alpha];
    
    //Render the layer in the image context
    UIGraphicsBeginImageContextWithOptions(visibleRect.size, NO, 1.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -visibleRect.origin.x, -visibleRect.origin.y);
    CALayer *layer = self.fatherView.layer;
    [layer renderInContext:context];
    
    //show all the blurred views from the superview before taking a screenshot
    //[self toggleBlurViewsInView:superview hidden:NO alpha:alpha];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    image = [[UIImage imageWithData:imageData] drn_boxblurImageWithBlur:_blurRadius];
    self.imageSteal = image;
   
}


@end
