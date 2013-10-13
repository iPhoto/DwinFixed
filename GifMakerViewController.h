//
//  GifMakerViewController.h
//  DWin1.0
//
//  Created by zang qilong on 13-9-20.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FreeGifLoader.h"
@interface GifMakerViewController : UIViewController
@property(nonatomic, retain) NSMutableArray *imageArray;
@property(nonatomic, retain) NSMutableArray *delayArray;
@property (nonatomic,retain) NSMutableArray *imageNewArray;
- (UIImage *) scaleFromImage: (UIImage *) image
                      toSize: (CGSize) size;//图片等比例裁剪函数
- (void) saveGif;//保存gif
- (void) showGif;//显示gif

@end
