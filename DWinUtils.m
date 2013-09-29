//
//  DWinUtils.m
//  DWin1.0
//
//  Created by zang qilong on 13-9-13.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "DWinUtils.h"
#import "GetStaticImage.h"
#import "ZXMacro.h"
@implementation DWinUtils
+ (UILabel *)createLabelForAutoSize:(CGPoint)point WithContent:(NSString *)str WithFontSize:(CGFloat)fontsize WithFontKind:(NSString *)fontKind WithTextColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = [UIFont fontWithName:fontKind size:fontsize];
    CGSize labelsize = [str sizeWithFont:[UIFont systemFontOfSize:fontsize] constrainedToSize:CGSizeMake(320, 568) lineBreakMode:NSLineBreakByWordWrapping];
    label.frame = CGRectMake(point.x, point.y, labelsize.width, labelsize.height);
    label.text = str;
    label.textColor = textColor;
    return label;
}

+ (UIImage *)getBlurImage:(UIView *)fatherView withRect:(CGRect)rectfromView WithRadius:(CGFloat)radius
{

    GetStaticImage *getview = [[GetStaticImage alloc] initWithFatherView:fatherView withRect:rectfromView withBlurRadius:radius];
    UIImage *imageNew = getview.imageSteal;
    return imageNew;
}

@end
