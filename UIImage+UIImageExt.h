//
//  UIImage+UIImageExt.h
//  merror
//
//  Created by Mac on 13-8-6.
//  Copyright (c) 2013年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageExt)
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;
- (UIImage *)createThumbImage:(UIImage *)image size:(CGSize )thumbSize percent:(float)percent toPath:(NSString *)thumbPath;
@end
