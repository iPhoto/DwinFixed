//
//  GetStaticImage.h
//  DWin1.0
//
//  Created by zang qilong on 13-9-16.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetStaticImage : UIView
@property (nonatomic,retain) UIImage *imageSteal;
@property (nonatomic,retain) UIView *fatherView;
@property (nonatomic,assign) CGFloat blurRadius;
- (id)initWithFatherView:(UIView *)father withRect:(CGRect)rect withBlurRadius:(CGFloat)radius;
@end
