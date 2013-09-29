//
//  DWinUtils.h
//  DWin1.0
//
//  Created by zang qilong on 13-9-13.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWinUtils : NSObject
+ (UILabel *)createLabelForAutoSize:(CGPoint)point WithContent:(NSString *)str WithFontSize:(CGFloat)fontsize WithFontKind:(NSString *)fontKind WithTextColor:(UIColor *)textColor;
+ (UIImage *)getBlurImage:(UIView *)fatherView withRect:(CGRect)rectfromView WithRadius:(CGFloat)radius;
@end
