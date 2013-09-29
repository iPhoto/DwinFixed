//
//  ShootViewController.m
//  DWin1.0
//
//  Created by zang qilong on 13-9-20.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "ShootViewController.h"
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import <ImageIO/ImageIO.h>
#import "ImageUtil.h"
#import <QuartzCore/QuartzCore.h>
//#import "ColorMatrix.h"
//LOMO
const float colormatrix_lomo[] = {
    1.7f,  0.1f, 0.1f, 0, -73.1f,
    0,  1.7f, 0.1f, 0, -73.1f,
    0,  0.1f, 1.6f, 0, -73.1f,
    0,  0, 0, 1.0f, 0 };

//黑白
const float colormatrix_heibai[] = {
    0.8f,  1.6f, 0.2f, 0, -163.9f,
    0.8f,  1.6f, 0.2f, 0, -163.9f,
    0.8f,  1.6f, 0.2f, 0, -163.9f,
    0,  0, 0, 1.0f, 0 };
//复古
const float colormatrix_huajiu[] = {
    0.2f,0.5f, 0.1f, 0, 40.8f,
    0.2f, 0.5f, 0.1f, 0, 40.8f,
    0.2f,0.5f, 0.1f, 0, 40.8f,
    0, 0, 0, 1, 0 };

//哥特
const float colormatrix_gete[] = {
    1.9f,-0.3f, -0.2f, 0,-87.0f,
    -0.2f, 1.7f, -0.1f, 0, -87.0f,
    -0.1f,-0.6f, 2.0f, 0, -87.0f,
    0, 0, 0, 1.0f, 0 };

//锐化
const float colormatrix_ruise[] = {
    4.8f,-1.0f, -0.1f, 0,-388.4f,
    -0.5f,4.4f, -0.1f, 0,-388.4f,
    -0.5f,-1.0f, 5.2f, 0,-388.4f,
    0, 0, 0, 1.0f, 0 };


//淡雅
const float colormatrix_danya[] = {
    0.6f,0.3f, 0.1f, 0,73.3f,
    0.2f,0.7f, 0.1f, 0,73.3f,
    0.2f,0.3f, 0.4f, 0,73.3f,
    0, 0, 0, 1.0f, 0 };

//酒红
const float colormatrix_jiuhong[] = {
    1.2f,0.0f, 0.0f, 0.0f,0.0f,
    0.0f,0.9f, 0.0f, 0.0f,0.0f,
    0.0f,0.0f, 0.8f, 0.0f,0.0f,
    0, 0, 0, 1.0f, 0 };

//清宁
const float colormatrix_qingning[] = {
    0.9f, 0, 0, 0, 0,
    0, 1.1f,0, 0, 0,
    0, 0, 0.9f, 0, 0,
    0, 0, 0, 1.0f, 0 };

//浪漫
const float colormatrix_langman[] = {
    0.9f, 0, 0, 0, 63.0f,
    0, 0.9f,0, 0, 63.0f,
    0, 0, 0.9f, 0, 63.0f,
    0, 0, 0, 1.0f, 0 };

//光晕
const float colormatrix_guangyun[] = {
    0.9f, 0, 0,  0, 67.9f,
    0, 0.9f,0,  0, 67.9f,
    0, 0, 0.9f,  0, 67.9f,
    0, 0, 0, 1.0f, 0 };

//蓝调
const float colormatrix_landiao[] = {
    2.1f, -1.4f, 0.6f, 0.0f, -31.0f,
    -0.3f, 2.0f, -0.3f, 0.0f, -31.0f,
    -1.1f, -0.2f, 2.6f, 0.0f, -31.0f,
    0.0f, 0.0f, 0.0f, 1.0f, 0.0f
};

//梦幻
const float colormatrix_menghuan[] = {
    0.8f, 0.3f, 0.1f, 0.0f, 46.5f,
    0.1f, 0.9f, 0.0f, 0.0f, 46.5f,
    0.1f, 0.3f, 0.7f, 0.0f, 46.5f,
    0.0f, 0.0f, 0.0f, 1.0f, 0.0f
};

//夜色
const float colormatrix_yese[] = {
    1.0f, 0.0f, 0.0f, 0.0f, -66.6f,
    0.0f, 1.1f, 0.0f, 0.0f, -66.6f,
    0.0f, 0.0f, 1.0f, 0.0f, -66.6f,
    0.0f, 0.0f, 0.0f, 1.0f, 0.0f
};

enum
{
    kLightAuto = 1000,
    kLightOpen,
    kLightClose,
};
@interface ShootViewController ()

@end

@implementation ShootViewController
@synthesize delegate=_delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)setupView
{
    
    // 添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveImageToPhotoAlbum) name:kImageCapturedSuccessfully object:nil];
    // 禁止侧边栏滑动
    self.viewDeckController.panningMode = IIViewDeckNoPanning;
    // 初始化captureSessionManager
    self.captureManager = [[CaptureSessionManager alloc] init];
    
    [self.captureManager addVideoInputFrontCamera:NO];
    [self.captureManager addStillImageOutput];
    [[self captureManager] addVideoPreviewLayer];
	CGRect layerRect = CGRectMake(0, 0, kScreen_Width, 426.6);
    [[[self captureManager] previewLayer] setBounds:layerRect];
    [[[self captureManager] previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),CGRectGetMidY(layerRect))];
	[[[self view] layer] addSublayer:[[self captureManager] previewLayer]];
    // controlview
    self.controlView = [[UIView alloc] initWithFrame:CGRectMake(0, kContent_Height-68, 320, 68)];
    self.controlView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.controlView];
        // 取消按钮
    UIButton *btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_cancel setBackgroundImage:[UIImage imageNamed:@"takephoto_cancel"] forState:UIControlStateNormal];
    btn_cancel.frame = CGRectMake(5, 5, 44, 44);
    [btn_cancel addTarget:self action:@selector(popView:) forControlEvents:UIControlEventTouchUpInside];
    [_controlView addSubview:btn_cancel];
    
    // 拍摄按钮
    UIButton *btn_shoot = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_shoot setBackgroundImage:[UIImage imageNamed:@"takephoto_shoot"] forState:UIControlStateNormal];
    btn_shoot.frame = CGRectMake(0, 0, 60, 60);
    btn_shoot.center = CGPointMake(160, 35);
    [btn_shoot addTarget:self action:@selector(scanButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_controlView addSubview:btn_shoot];
    // 小图片
    self.lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 8, 36, 36)];
    [self.controlView addSubview:_lastImageView];
    UITapGestureRecognizer *tapShowImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeLastImageViewFrame:)];
    self.lastImageView.userInteractionEnabled = YES;
    self.lastImageView.image = [UIImage imageNamed:@"takephoto_gallery"];
    tapShowImage.numberOfTapsRequired =1;
    [self.lastImageView addGestureRecognizer:tapShowImage];
    // session运行
    [self.captureManager.captureSession startRunning];
    
}

- (void)changeLastImageViewFrame:(id)sender
{
    
}

- (void)setupFilterView
{
    isScrollHide = NO;
    // 初始化滤镜视图
    _theFilterView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_theFilterView];
    // 设置图片
    imageViewShowEffect = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, kScreen_Height)];
    imageViewShowEffect.image = self.shootStillImage;
    imageViewShowEffect.userInteractionEnabled = YES;
   //imageViewShowEffect.contentMode = UIViewContentModeScaleAspectFit;
    [_theFilterView addSubview:imageViewShowEffect];
    // 初始化控制界面
    _filterControlView = [[UIView alloc] initWithFrame:CGRectMake(0, kContent_Height-68, kContent_Width, 68)];
    _filterControlView.backgroundColor = RGBAlpha(1, 1, 1, 0.5);
    [_theFilterView addSubview:_filterControlView];
    // 取消按钮
    UIButton *btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_cancel setBackgroundImage:[UIImage imageNamed:@"takephoto_cancel"] forState:UIControlStateNormal];
     btn_cancel.frame = CGRectMake(5, 5, 44, 44);
    [btn_cancel addTarget:self action:@selector(popView:) forControlEvents:UIControlEventTouchUpInside];
    [_filterControlView addSubview:btn_cancel];
    // 滤镜
    filterScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kContent_Height-138, 320, 70)];
    filterScroll.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    filterScroll.contentSize = CGSizeMake(320*2+50, 70);
    for (int i=0; i<14; i++) {
        UIButton *seg_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        seg_btn.tag=1000+i;
        [seg_btn setFrame:CGRectMake(i*50, 0, 50, 70)];
        [seg_btn addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
        // [seg_btn setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        [seg_btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]] forState:UIControlStateNormal];
        if (i==0) {
            [seg_btn setBackgroundImage:[UIImage imageNamed:@"1filter"] forState:UIControlStateNormal];
        } 
        if (i==1)
        {
            [seg_btn setBackgroundImage:[UIImage imageNamed:@"2filter"] forState:UIControlStateNormal];
        }
        [filterScroll addSubview:seg_btn];
    }
    [_theFilterView addSubview:filterScroll];
    // 收起滤镜
    UIButton *btn_hideFilter = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_hideFilter.frame = CGRectMake(320-40, kContent_Height-138-24, 36, 24);
    [btn_hideFilter setBackgroundImage:[UIImage imageNamed:@"takephoto_hidefilter"] forState:UIControlStateNormal];
    [btn_hideFilter addTarget:self action:@selector(hideFilterScroll:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_hideFilter];
    // 确定
    UIButton *btn_confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_confirm.frame = CGRectMake(320-40, 5, 36, 36);
    [btn_confirm setBackgroundImage:[UIImage imageNamed:@"takephoto_sure"] forState:UIControlStateNormal];
    [btn_confirm addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_filterControlView addSubview:btn_confirm];
    // 复杂滤镜
    btn_hardFilter = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_hardFilter.frame = CGRectMake(80, 5, 44, 44);
    [btn_hardFilter setBackgroundImage:[UIImage imageNamed:@"takephoto_complefilter"] forState:UIControlStateNormal];
    [btn_hardFilter addTarget:self action:@selector(complexFilter:) forControlEvents:UIControlEventTouchUpInside];
    [_filterControlView addSubview:btn_hardFilter];
    // 裁剪图片
   btn_cutImage = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_cutImage.frame = CGRectMake(200, 5, 44, 44);
    [btn_cutImage setBackgroundImage:[UIImage imageNamed:@"takephoto_cutpicture"] forState:UIControlStateNormal];
    [btn_cutImage addTarget:self action:@selector(cutPicture:) forControlEvents:UIControlEventTouchUpInside];
    [_filterControlView addSubview:btn_cutImage];
    
}
-(void)createCube
{

    //创建移动的比btn试图
    
    
    //按钮上添加一个imgeView
    
    
    btnImage=[[UIImageView alloc]initWithFrame:CGRectMake(150,150, 150, 150)];
    btnImage.userInteractionEnabled=YES;
    
    
    //self.mybuton1 = [[UIButton alloc]initWithFrame:CGRectMake(150, 150, 150, 150)];
    
    
    btnLayer = [btnImage layer];
    btnLayer.borderColor = [[UIColor grayColor] CGColor];
    btnLayer.borderWidth = 2.0f;
    
   
    
    // 拖移的 Recognizer
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self                                               action:@selector(handlePan:)];
    [btnImage addGestureRecognizer:panGestureRecognizer];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alert)];
    
    [btnImage addGestureRecognizer:tap];
    [imageViewShowEffect addSubview:btnImage];

    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [btnImage addGestureRecognizer:pinchGestureRecognizer];
   // [pinchGestureRecognizer requireGestureRecognizerToFail:panGestureRecognizer];
    
    
    
//    //按钮上添加一个imgeView
//    btnImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.mybuton1.frame.size.width, self.mybuton1.frame.size.height)];
//    btnImage.userInteractionEnabled=YES;

}

- (void) handlePinch:(UIPinchGestureRecognizer*) recognizer
{
    NSLog(@"捏合, %f", recognizer.scale);
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}
- (void)handlePan:(UIPanGestureRecognizer*) recognizer
{
    //NSLog(@"拖移，慢速移动");
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    btnImage.image=nil;
    btnLayer.borderWidth = 2.0f;
    if(recognizer.view.center.x-btnImage.frame.size.height/2 <0)
    {
        recognizer.view.center=CGPointMake(btnImage.frame.size.height/2, recognizer.view.center.y);
    }
    if(recognizer.view.center.y-btnImage.frame.size.height/2 <0)
    {
        recognizer.view.center=CGPointMake(recognizer.view.center.x, btnImage.frame.size.height/2);
    }
    if(recognizer.view.center.x+btnImage.frame.size.height/2 >self.view.frame.size.width)
    {
        recognizer.view.center=CGPointMake(self.view.frame.size.width-btnImage.frame.size.height/2, recognizer.view.center.y);
    }
    if(recognizer.view.center.y+btnImage.frame.size.height/2 >self.view.frame.size.height)
    {
        recognizer.view.center=CGPointMake(recognizer.view.center.x, self.view.frame.size.height-btnImage.frame.size.height/2);}
    
}


- (void)confirmButtonClick:(UIButton *)sender
{
    [self.delegate shootViewController:imageViewShowEffect.image];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -pop viewcontroller
-(void)popView:(id)sender
{
    NSLog(@"pop");
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)complexFilter:(UIButton *)sender
{
    if (isComplexFilterOpen) {
        [sender setBackgroundImage:[UIImage imageNamed:@"takephoto_complexfilter"] forState:UIControlStateNormal];
        [btnImage removeFromSuperview];
        isComplexFilterOpen = !isComplexFilterOpen;
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"takephoto_complefilterselected"] forState:UIControlStateNormal];
        isComplexFilterOpen = YES;
        [self createCube];
    }
   
}

- (void)cutPicture:(UIButton *)sender
{
    
}

- (void)hideFilterScroll:(UIButton *)sender
{
    NSLog(@"hello hide");
    if (isScrollHide) {
        [UIView animateWithDuration:0.2 animations:^{
            
            sender.frame =CGRectMake(320-40, kContent_Height-138-24, 36, 24);
            [sender setBackgroundImage:[UIImage imageNamed:@"takephoto_hidefilter"] forState:UIControlStateNormal];
           
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                filterScroll.frame = CGRectMake(0, kContent_Height-138, 320, 70);
            }];
        }];
        isScrollHide = !isScrollHide;
        
    }else
    {
        [UIView animateWithDuration:0.2 animations:^{
            sender.frame =CGRectMake(320-40, kContent_Height-24-70, 36, 24);
            [sender setBackgroundImage:[UIImage imageNamed:@"takephoto_showfilter"] forState:UIControlStateNormal];
           
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                 filterScroll.frame = CGRectMake(320, kContent_Height-138, 320, 70);
            }];
        }];
        isScrollHide = !isScrollHide;
    }
}

//两张图片合并
-(UIImage *)addImage:(UIImage *)image1 withPoint1:(CGPoint)point1 toImage:(UIImage *)image2 withPoint2:(CGPoint)point2
{
    UIGraphicsBeginImageContext(image1.size);
    //Draw image1
    [image1 drawInRect:CGRectMake(point1.x, point1.y, kScreen_Width, kScreen_Height)];
    //Draw image2
    [image2 drawInRect:CGRectMake(point2.x, point2.y, image2.size.width, image2.size.height)];
    
   
    
    UIImage *resultImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

- (void)changeImage:(UIButton *)sender
{
    if (isComplexFilterOpen) {
        //btnLayer.borderWidth = 0.0f;
        CGRect rect = CGRectMake(btnImage.frame.origin.x, btnImage.frame.origin.y, btnImage.frame.size.width, btnImage.frame.size.height);//创建矩形框
        
        contentView = [[UIImageView alloc] initWithFrame:rect];
        contentView.image=[UIImage imageWithCGImage:CGImageCreateWithImageInRect([imageViewShowEffect.image CGImage], rect)];
        flag = sender.tag-1000;
        UIImage *wholeImage = imageViewShowEffect.image;
        if (flag==0) {
            
            btnImage.image=contentView.image;
        }
        if (flag==1) {
            NSLog(@"flag 1");
            UIImage*ima=
            [ImageUtil imageWithImage:contentView.image withColorMatrix:colormatrix_lomo];
            UIImage *image1 = [self addImage:wholeImage withPoint1:CGPointMake(0, 0) toImage:ima withPoint2:CGPointMake(btnImage.frame.origin.x, btnImage.frame.origin.y)];
            imageViewShowEffect.image = image1;
            btnImage.image=ima;
        }
        
        if (flag==2) {
            UIImage*ima=
            [ImageUtil imageWithImage:contentView.image withColorMatrix:colormatrix_lomo];
            UIImage *image1 = [self addImage:wholeImage withPoint1:CGPointMake(0, 0) toImage:ima withPoint2:CGPointMake(btnImage.frame.origin.x, btnImage.frame.origin.y)];
            imageViewShowEffect.image = image1;
            btnImage.image=ima;
        }
        if (flag==3) {
            UIImage*ima=
            [ImageUtil imageWithImage:contentView.image withColorMatrix:colormatrix_lomo];
            UIImage *image1 = [self addImage:wholeImage withPoint1:CGPointMake(0, 0) toImage:ima withPoint2:CGPointMake(btnImage.frame.origin.x, btnImage.frame.origin.y)];
            imageViewShowEffect.image = image1;
            btnImage.image=ima;

        }
        if (flag==4) {
            UIImage*ima=
            [ImageUtil imageWithImage:contentView.image withColorMatrix:colormatrix_lomo];
            UIImage *image1 = [self addImage:wholeImage withPoint1:CGPointMake(0, 0) toImage:ima withPoint2:CGPointMake(btnImage.frame.origin.x, btnImage.frame.origin.y)];
            imageViewShowEffect.image = image1;
            btnImage.image=ima;
        }
        if (flag==5) {
            UIImage*ima=
            [ImageUtil imageWithImage:contentView.image withColorMatrix:colormatrix_lomo];
            UIImage *image1 = [self addImage:wholeImage withPoint1:CGPointMake(0, 0) toImage:ima withPoint2:CGPointMake(btnImage.frame.origin.x, btnImage.frame.origin.y)];
            imageViewShowEffect.image = image1;
            btnImage.image=ima;

        }
        if (flag==6) {
            UIImage*ima=
            [ImageUtil imageWithImage:contentView.image withColorMatrix:colormatrix_lomo];
            UIImage *image1 = [self addImage:wholeImage withPoint1:CGPointMake(0, 0) toImage:ima withPoint2:CGPointMake(btnImage.frame.origin.x, btnImage.frame.origin.y)];
            imageViewShowEffect.image = image1;
            btnImage.image=ima;

        }
        if (flag==7) {
            UIImage*ima=
            [ImageUtil imageWithImage:contentView.image withColorMatrix:colormatrix_lomo];
            UIImage *image1 = [self addImage:wholeImage withPoint1:CGPointMake(0, 0) toImage:ima withPoint2:CGPointMake(btnImage.frame.origin.x, btnImage.frame.origin.y)];
            imageViewShowEffect.image = image1;
            btnImage.image=ima;

        }
        if (flag==8) {
            UIImage*ima=
            [ImageUtil imageWithImage:contentView.image withColorMatrix:colormatrix_lomo];
            UIImage *image1 = [self addImage:wholeImage withPoint1:CGPointMake(0, 0) toImage:ima withPoint2:CGPointMake(btnImage.frame.origin.x, btnImage.frame.origin.y)];
            imageViewShowEffect.image = image1;
            btnImage.image=ima;
        }
        if (flag==9) {
            UIImage*ima=
            [ImageUtil imageWithImage:contentView.image withColorMatrix:colormatrix_lomo];
            UIImage *image1 = [self addImage:wholeImage withPoint1:CGPointMake(0, 0) toImage:ima withPoint2:CGPointMake(btnImage.frame.origin.x, btnImage.frame.origin.y)];
            imageViewShowEffect.image = image1;
            btnImage.image=ima;

        }
        if (flag==10) {
            UIImage*ima=
            [ImageUtil imageWithImage:contentView.image withColorMatrix:colormatrix_lomo];
            UIImage *image1 = [self addImage:wholeImage withPoint1:CGPointMake(0, 0) toImage:ima withPoint2:CGPointMake(btnImage.frame.origin.x, btnImage.frame.origin.y)];
            imageViewShowEffect.image = image1;
            btnImage.image=ima;

        }
        if (flag==11) {
            UIImage*ima=
            [ImageUtil imageWithImage:contentView.image withColorMatrix:colormatrix_lomo];
            UIImage *image1 = [self addImage:wholeImage withPoint1:CGPointMake(0, 0) toImage:ima withPoint2:CGPointMake(btnImage.frame.origin.x, btnImage.frame.origin.y)];
            imageViewShowEffect.image = image1;
            btnImage.image=ima;

        }
        if (flag==12) {
            UIImage*ima=
            [ImageUtil imageWithImage:contentView.image withColorMatrix:colormatrix_lomo];
            UIImage *image1 = [self addImage:wholeImage withPoint1:CGPointMake(0, 0) toImage:ima withPoint2:CGPointMake(btnImage.frame.origin.x, btnImage.frame.origin.y)];
            imageViewShowEffect.image = image1;
            btnImage.image=ima;

        }
        if (flag==13) {
            UIImage*ima=
            [ImageUtil imageWithImage:contentView.image withColorMatrix:colormatrix_lomo];
            UIImage *image1 = [self addImage:wholeImage withPoint1:CGPointMake(0, 0) toImage:ima withPoint2:CGPointMake(btnImage.frame.origin.x, btnImage.frame.origin.y)];
            imageViewShowEffect.image = image1;
            btnImage.image=ima;

        }

        
    }else
    {
        NSLog(@"run filter");
        flag = sender.tag-1000;
        
        if (flag==0) {
            
            imageViewShowEffect.image=_shootStillImage;
        }
        if (flag==1) {
            UIImage*ima=
            [ImageUtil imageWithImage:_shootStillImage withColorMatrix:colormatrix_lomo];
            imageViewShowEffect.image=ima;
        }
        
        if (flag==2) {
            UIImage*ima=
            [ImageUtil imageWithImage:_shootStillImage withColorMatrix:colormatrix_heibai];
            imageViewShowEffect.image=ima;
        }
        if (flag==3) {
            UIImage*ima=
            [ImageUtil imageWithImage:_shootStillImage withColorMatrix:colormatrix_huajiu];
            imageViewShowEffect.image=ima;
        }
        if (flag==4) {
            UIImage*ima=
            [ImageUtil imageWithImage:_shootStillImage withColorMatrix:colormatrix_gete];
            imageViewShowEffect.image=ima;
        }
        if (flag==5) {
            UIImage*ima=
            [ImageUtil imageWithImage:_shootStillImage withColorMatrix:colormatrix_ruise];
            imageViewShowEffect.image=ima;
        }
        if (flag==6) {
            UIImage*ima=
            [ImageUtil imageWithImage:_shootStillImage withColorMatrix:colormatrix_danya];
            imageViewShowEffect.image=ima;
        }
        if (flag==7) {
            UIImage*ima=
            [ImageUtil imageWithImage:_shootStillImage withColorMatrix:colormatrix_jiuhong];
            imageViewShowEffect.image=ima;
        }
        if (flag==8) {
            UIImage*ima=
            [ImageUtil imageWithImage:_shootStillImage withColorMatrix:colormatrix_qingning];
            imageViewShowEffect.image=ima;
        }
        if (flag==9) {
            UIImage*ima=
            [ImageUtil imageWithImage:_shootStillImage withColorMatrix:colormatrix_langman];
            imageViewShowEffect.image=ima;
        }
        if (flag==10) {
            UIImage*ima=
            [ImageUtil imageWithImage:_shootStillImage withColorMatrix:colormatrix_guangyun];
            imageViewShowEffect.image=ima;
        }
        if (flag==11) {
            UIImage*ima=
            [ImageUtil imageWithImage:_shootStillImage withColorMatrix:colormatrix_landiao];
            imageViewShowEffect.image=ima;
        }
        if (flag==12) {
            UIImage*ima=
            [ImageUtil imageWithImage:_shootStillImage withColorMatrix:colormatrix_menghuan];
            imageViewShowEffect.image=ima;
        }
        if (flag==13) {
            UIImage*ima=
            [ImageUtil imageWithImage:_shootStillImage withColorMatrix:colormatrix_yese];
            imageViewShowEffect.image=ima;
        }
    }
    
}

- (void)scanButtonPressed {
	
    [[self captureManager] captureStillImage];
}

// 显示滤镜并且储存照片
- (void)saveImageToPhotoAlbum
{
    self.shootStillImage = [self imageWithImage:self.captureManager.stillImage scaledToSize:CGSizeMake(kScreen_Width,kScreen_Height)];
   // self.shootStillImage = [self getImageFromImage:self.shootStillImage subImageSize:CGSizeMake(kScreen_Width, kScreen_Height) subImageRect:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    NSLog(@"shoot still image frame%f,%f",self.shootStillImage.size.width,self.shootStillImage.size.height);
    [self setupFilterView];
    UIImageWriteToSavedPhotosAlbum([[self captureManager] stillImage], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
   //UIImage *image2 =  [self getImageFromImage:newImage subImageSize:CGSizeMake(320, 460) subImageRect:CGRectMake(0, 0, 320, 460)];
    // Return the new image.
    return newImage;
}

//图片裁剪
-(UIImage *)getImageFromImage:(UIImage*) superImage subImageSize:(CGSize)subImageSize subImageRect:(CGRect)subImageRect {
    //    CGSize subImageSize = CGSizeMake(WIDTH, HEIGHT); //定义裁剪的区域相对于原图片的位置
    //    CGRect subImageRect = CGRectMake(START_X, START_Y, WIDTH, HEIGHT);
    CGImageRef imageRef = superImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, subImageRect);
    UIGraphicsBeginImageContext(subImageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, subImageRect, subImageRef);
    UIImage* returnImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext(); //返回裁剪的部分图像
    return returnImage;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Image couldn't be saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else {
       // [[self scanningLabel] setHidden:YES];
    }
}

- (void)swipLeft:(id)sender
{
    NSLog(@"left");
}



- (void)viewDidLoad
{
    isComplexFilterOpen = NO;
    [super viewDidLoad];
    [self setupView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)alert{
    
    //btnLayer.borderWidth = 0.0f;
    CGRect rect = CGRectMake(btnImage.frame.origin.x, btnImage.frame.origin.y, btnImage.frame.size.width, btnImage.frame.size.height);//创建矩形框
    
    contentView = [[UIImageView alloc] initWithFrame:rect];
    contentView.image=[UIImage imageWithCGImage:CGImageCreateWithImageInRect([imageViewShowEffect.image CGImage], rect)];
     //flag = 1;
      
    
    
    
}


@end
