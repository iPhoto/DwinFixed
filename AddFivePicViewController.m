//
//  AddFivePicViewController.m
//  DWin1.0
//
//  Created by Mac on 13-9-28.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "AddFivePicViewController.h"
#import "AGViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import "AddPicViewController.h"
#import "AddFourViewController.h"
#import "AddFivePicViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AGImagePickerController.h"
//#import "iCarousel.h"


#import "IIViewDeckController.h"
@interface AddFivePicViewController ()

@end

@implementation AddFivePicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         //self.picarr=[[NSArray alloc]init];
        d=[Singel danli];
      d.fivepicArr=[[NSArray alloc]init];
        
        cutFlag=0;
    }
    return self;
}
-(void)change_titlePic:(UIButton*)sender
{
    if (sender.tag-10000==0)
    {cutFlag=0;
//        [(UIButton*)[self.navigationController.view viewWithTag:10000] setBackgroundImage:[UIImage imageNamed:@"line_cube_clic"] forState:UIControlStateNormal];
//        [(UIButton*)[self.navigationController.view viewWithTag:10001] setBackgroundImage:[UIImage imageNamed:@"line_cube_unclic2"] forState:UIControlStateNormal];
//        [(UIButton*)[self.navigationController.view viewWithTag:10002] setBackgroundImage:[UIImage imageNamed:@"line_cube_unclic3"] forState:UIControlStateNormal];
        [toltle_scroll setHidden:YES];
        [toltle_scoroll1 setHidden:YES];
        [back_view1 setHidden:NO];
    }
    if (sender.tag-10000==1)
    {
        cutFlag=1;
//        [(UIButton*)[self.navigationController.view viewWithTag:10000] setBackgroundImage:[UIImage imageNamed:@"line_cube_unclic"] forState:UIControlStateNormal];
//        [(UIButton*)[self.navigationController.view viewWithTag:10001] setBackgroundImage:[UIImage imageNamed:@"line_cube_clic2"] forState:UIControlStateNormal];
//        [(UIButton*)[self.navigationController.view viewWithTag:10002] setBackgroundImage:[UIImage imageNamed:@"line_cube_unclic3"] forState:UIControlStateNormal];
        
        [toltle_scoroll1 setHidden:YES];
        [back_view1 setHidden:YES];
        toltle_scroll.hidden=NO;
  
        static float a=0;
        //循环向滑动视图上添加img
        for (int i =0; i<[d.fivepicArr count]; i++)
            
        {
            
            UIImage *p=[d.fivepicArr objectAtIndex:i];
            NSLog(@"%f--------%f",p.size.width,p.size.height);
            NSLog(@"++++++++++++++%f",200*p.size.width/p.size.height);
            a=a+200*p.size.width/p.size.height;
            
            
            
            
            NSLog(@"------------%f",a);
            UIImageView*img = [[UIImageView alloc]initWithFrame:CGRectMake(2+a-200*p.size.width/p.size.height, 2, 200*p.size.width/p.size.height, 196)];
            img.contentMode = UIViewContentModeScaleAspectFit;
            img.image = [d.fivepicArr objectAtIndex:i];
            
            [toltle_scroll addSubview: img];
            if (i==[d.fivepicArr count]-1)
            {
                 cutnum_w=a+cutnum_w;
                a=0;
            }
            
            
        }
        
    }
    if (sender.tag-10000==2)
    {
        cutFlag=2;
        
    
//[(UIButton*)[self.navigationController.view viewWithTag:10000] setBackgroundImage:[UIImage imageNamed:@"line_cube_unclic"] forState:UIControlStateNormal];
//        [(UIButton*)[self.navigationController.view viewWithTag:10001] setBackgroundImage:[UIImage imageNamed:@"line_cube_unclic2"] forState:UIControlStateNormal];
//        [(UIButton*)[self.navigationController.view viewWithTag:10002] setBackgroundImage:[UIImage imageNamed:@"line_cube_clic3"] forState:UIControlStateNormal];
        
        [toltle_scroll setHidden:YES];
        [back_view1    setHidden:YES];
        [toltle_scoroll1 setHidden:NO];

   
        
        static float b=0;
        //循环向滑动视图上添加img
        for (int i =0; i<[d.fivepicArr count]; i++)
            
        {
            
            UIImage *p=[d.fivepicArr objectAtIndex:i];
            NSLog(@"%f--------%f",p.size.width,p.size.height);
            NSLog(@"++++++++++++++%f",200*p.size.width/p.size.height);
            b=b+200*p.size.height/p.size.width;
            
            
            
            
            NSLog(@"------------%f",b);
            UIImageView*img = [[UIImageView alloc]initWithFrame:CGRectMake(2, b-200*p.size.height/p.size.width-4*i, 196, 200*p.size.height/p.size.width)];
            img.contentMode = UIViewContentModeScaleAspectFit;
            img.image = [d.fivepicArr objectAtIndex:i];
            
            [toltle_scoroll1 addSubview: img];
            if (i==[d.fivepicArr count]-1)
            {
                
                cutnum_h=b+cutnum_h;
                b=0;
            }
            
            
        }
        

    }
    
}
- (void)setNavgationBar
{
    // 导航条左按钮
    UIButton *btn_left = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_left.frame = CGRectMake(0, 0, 56, 18);
    [btn_left setBackgroundImage:[UIImage imageNamed:@"moment_backBtn"] forState:UIControlStateNormal];
    btn_left.tag=1;
    [btn_left addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:btn_left];
    self.navigationItem.leftBarButtonItem = leftBar;
    // 导航条右按钮
    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_right.frame = CGRectMake(0, 0, 30, 6);
    [btn_right setBackgroundImage:[UIImage imageNamed:@"moment_moreBtn"] forState:UIControlStateNormal];
    btn_right.tag=2;
    [btn_right addTarget:self action:@selector(right_navBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
    self.navigationItem.rightBarButtonItem = rightBar;
}
-(void)navBtnClick:(UIButton*)sender
{
    [[self.navigationController.view viewWithTag:11111] removeFromSuperview];
    
    [[self.navigationController.view viewWithTag:10001] removeFromSuperview];
    
    [[self.navigationController.view viewWithTag:10002] removeFromSuperview];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)right_navBtnClick
{
    
    if (cutFlag==0) {
        CGSize s = toltle_scoroll1.bounds.size;
        UIGraphicsBeginImageContextWithOptions(s, NO, toltle_scoroll1.layer.contentsScale);
        [toltle_scoroll1.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage*image1 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageView *img=[[UIImageView alloc]init];
        img.image=image1;
        UIImageWriteToSavedPhotosAlbum([img image ], nil, nil,nil);
    }
    
    if (cutFlag==1)
    {
        UIImage*im= [self transformScrollViewToImage:toltle_scroll rect:CGRectMake(60,50, cutnum_w-6,200)];
        
        UIImageWriteToSavedPhotosAlbum(im, nil, nil,nil);
        
        
    }
    
    if (cutFlag==2) {
        UIImage*im= [self transformScrollViewToImage:toltle_scoroll1 rect:CGRectMake(60,50, 200,cutnum_h-6)];
        
        UIImageWriteToSavedPhotosAlbum(im, nil, nil,nil);
        
    }
    
    

}
- (UIImage*)transformScrollViewToImage:(UIScrollView*)scrollView rect:(CGRect)rect
{
    UIImage* image = nil;
    CGPoint savedContentOffset = scrollView.contentOffset;
    CGRect savedFrame = scrollView.frame;
    scrollView.contentOffset= CGPointZero;
    
    UIGraphicsBeginImageContext(rect.size);
    scrollView.frame= rect;
    CGSize size = CGSizeMake(rect.size.width*2, rect.size.height*2);
    [scrollView setContentSize:size];
    [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    scrollView.contentOffset= savedContentOffset;
    scrollView.frame= savedFrame;
    return image;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self setNavgationBar];
       //导航栏上的view
    title_view =[[UIView alloc]initWithFrame:CGRectMake(101, 0, 320-202, 44)];
    title_view.backgroundColor = [UIColor clearColor];
    title_view.tag=11111;
    [self.navigationController.view addSubview:title_view];
    
    //导航栏3张图片
    
    titile_picArr = [[NSArray alloc]initWithObjects:@"line_cube_clic",@"line_cube_unclic2",@"line_cube_unclic3", nil];
    titile_unPicArr= [[NSArray alloc]initWithObjects:@"line_cube_unclic",@"line_cube_clic2",@"line_cube_clic3", nil];
    
    
      
    //5张图片
    //点击后的图片
    five_arr = [[NSArray alloc]initWithObjects:@"5-1",@"5-22",@"5-33",@"5-44",@"5-55", nil];
    //没有点击的图片
    unfive_arr= [[NSArray alloc]initWithObjects:@"5-11",@"5-2",@"5-3",@"5-4",@"5-5", nil];
    
    
    for (int i = 0; i < 3; i ++)
    {
        
        UIButton*navUp_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        navUp_btn.frame=CGRectMake(0+46*i, 9, 26, 26);
        navUp_btn.tag= 10000+i;
        [navUp_btn setBackgroundImage:[UIImage imageNamed:[titile_picArr objectAtIndex:i]] forState:UIControlStateNormal];
        [navUp_btn addTarget:self action:@selector(change_titlePic:) forControlEvents:UIControlEventTouchUpInside];
        [title_view addSubview:navUp_btn];
        
    }
    back_view1= [[UIView alloc]initWithFrame:CGRectMake(10, 44+21, 300, (358+4+4+280)/2)];
    [back_view1 setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    [self.view addSubview:back_view1];
    //整个屏幕的大背景
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320,self.view.frame.size.height)];
    imageViewBackGround.userInteractionEnabled= YES;
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    [self.view addSubview:imageViewBackGround];
    
    //滑动选择的btn；
    UIScrollView *sclloer=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
       sclloer.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    sclloer.backgroundColor = [UIColor clearColor];
    sclloer.contentSize = CGSizeMake(444, 44);
    [imageViewBackGround addSubview:sclloer];
    
	UIView * back_view= [[UIView alloc]initWithFrame:CGRectMake(0, 44, 320, self.view.frame.size.height-101+20)];
    back_view.userInteractionEnabled = YES;
    [back_view setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3]];
    [self.view addSubview:back_view];
    
    
    
    
    
    
     back_view1 = [[UIView alloc]initWithFrame:CGRectMake(10, 44+21, 300, (358+4+4+280)/2)];
     [back_view1 setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
     [self.view addSubview:back_view1];

        
    for (int i = 0; i<5; i++)
    {
        
        pic_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        pic_btn.tag = 1000+i;
        [pic_btn setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:i]] forState:UIControlStateNormal];
        pic_btn.frame=CGRectMake(12+54*i, 9, 26, 26);
        [pic_btn addTarget:self action:@selector(change_pic:) forControlEvents:UIControlEventTouchUpInside];
        [sclloer addSubview:pic_btn];
    }
    
    
///////////////////////横竖拼图的滑动试图、////////////////////////////
    
    toltle_scroll   = [[UIScrollView alloc]initWithFrame:CGRectMake(0,200, 320,200)];
    toltle_scoroll1 = [[UIScrollView alloc]initWithFrame:CGRectMake(60,50, 200,400)];
    
    toltle_scroll.backgroundColor   = [UIColor whiteColor];
    toltle_scoroll1.backgroundColor = [UIColor whiteColor];
    
    toltle_scroll  .contentSize = CGSizeMake([d.fivepicArr count]*200+100, 200);
    toltle_scoroll1.contentSize = CGSizeMake(200,1800);
    
    toltle_scroll.hidden   = YES;
    toltle_scoroll1.hidden = YES;
    
    [self.view addSubview:  toltle_scroll];
    [self.view addSubview:toltle_scoroll1];
    
   }

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:back_view1];
    self.img.frame = CGRectMake(point.x-beginx, point.y-beginy, self.img.frame.size.width,self.img.frame.size.height);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:back_view1];
    for (UIImageView *imageview in [back_view1 subviews])
    {
        if ((point.x>=imageview.frame.origin.x&&point.x<=imageview.frame.origin.x+imageview.frame.size.width)&&(point.y>=imageview.frame.origin.y&&point.y<=imageview.frame.origin.y+imageview.frame.size.height))
        {
            NSLog(@"get imageview tag%d",imageview.tag);
            self.img = imageview;
            beginx = point.x-imageview.frame.origin.x;
            beginy = point.y-imageview.frame.origin.y;
            beginoriginx = imageview.frame.origin.x;
            beginoriginy = imageview.frame.origin.y;
            
        }
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:back_view1];
    for (UIImageView *imageview in [back_view1 subviews])
    {
        if ((point.x>=imageview.frame.origin.x&&point.x<=imageview.frame.origin.x+imageview.frame.size.width)&&(point.y>=imageview.frame.origin.y&&point.y<=imageview.frame.origin.y+imageview.frame.size.height))
        {
            NSLog(@"get imageview tag%d",imageview.tag);
            UIImage *imageget = self.img.image;
            self.img.image = imageview.image;
            imageview.image = imageget;
            self.img.frame = CGRectMake(beginoriginx, beginoriginy, self.img.frame.size.width, self.img.frame.size.height);
            
        }
    }
}




-(void)change_pic:(UIButton*)sender
{
    if (sender.tag-1000==0)
    {
        
        NSLog(@"");
        NSLog(@"------**************%@",self.picarr);

        [(UIButton*)[self.view viewWithTag:1000] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:0]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1001] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:1]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1002] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:2]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1003] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:3]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1004] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:4]] forState:UIControlStateNormal];

        
        [[self.view viewWithTag:10001] removeFromSuperview];
        [[self.view viewWithTag:10002] removeFromSuperview];
        [[self.view viewWithTag:10003] removeFromSuperview];
        [[self.view viewWithTag:10004] removeFromSuperview];
        [[self.view viewWithTag:10005] removeFromSuperview];
        
        self.img  = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 294/2, 642/2-2)];
        self.img1 = [[UIImageView alloc]initWithFrame:CGRectMake(2+294/2+2, 2, 294/2, 158/2)];
        self.img2 = [[UIImageView alloc]initWithFrame:CGRectMake(2+294/2+2, 158/2+4, 294/2, 158/2)];
        self.img3 = [[UIImageView alloc]initWithFrame:CGRectMake(2+294/2+2, 158/2+4+2+158/2, 294/2, 158/2)];
        self.img4 = [[UIImageView alloc]initWithFrame:CGRectMake(2+294/2+2, 158/2+4+2+158/2+158/2+2, 294/2, 156/2-2)];
        
        self.img .tag = 10001;
        self.img1.tag = 10002;
        self.img2.tag = 10003;
        self.img3.tag = 10004;
        self.img4.tag = 10005;
        
        self.img. image=[d.fivepicArr objectAtIndex:0];
        self.img1.image=[d.fivepicArr objectAtIndex:1];
        self.img2.image=[d.fivepicArr objectAtIndex:2];
        self.img3.image=[d.fivepicArr objectAtIndex:3];
        self.img4.image=[d.fivepicArr objectAtIndex:4];
        
        
        [back_view1 addSubview:self.img ];
        [back_view1 addSubview:self.img1];
        [back_view1 addSubview:self.img2];
        [back_view1 addSubview:self.img3];
        [back_view1 addSubview:self.img4];
    }
    if (sender.tag-1000==1)
    {
        [(UIButton*)[self.view viewWithTag:1000] setBackgroundImage:[UIImage imageNamed:[unfive_arr objectAtIndex:0]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1001] setBackgroundImage:[UIImage imageNamed:[unfive_arr objectAtIndex:1]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1002] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:2]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1003] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:3]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1004] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:4]] forState:UIControlStateNormal];
    
        
        
        [[self.view viewWithTag:10001] removeFromSuperview];
        [[self.view viewWithTag:10002] removeFromSuperview];
        [[self.view viewWithTag:10003] removeFromSuperview];
        [[self.view viewWithTag:10004] removeFromSuperview];
        [[self.view viewWithTag:10005] removeFromSuperview];
        
        self. img = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 296, 159)];
        self.img1 = [[UIImageView alloc]initWithFrame:CGRectMake(2, 163, 146/2, 158)];
        self.img2 = [[UIImageView alloc]initWithFrame:CGRectMake(146/2+4, 163,146/2, 158)];
        self.img3 = [[UIImageView alloc]initWithFrame:CGRectMake(146+6, 163, 146/2, 158)];
        self.img4 = [[UIImageView alloc]initWithFrame:CGRectMake(146/2+4+146/2+4+146/2, 163, 146/2-2, 158)];
        
        self.img .tag = 10001;
        self.img1.tag = 10002;
        self.img2.tag = 10003;
        self.img3.tag = 10004;
        self.img4.tag = 10005;
        
        self.img. image=[d.fivepicArr objectAtIndex:0];
        self.img1.image=[d.fivepicArr objectAtIndex:1];
        self.img2.image=[d.fivepicArr objectAtIndex:2];
        self.img3.image=[d.fivepicArr objectAtIndex:3];
        self.img4.image=[d.fivepicArr objectAtIndex:4];
        
        
        [back_view1 addSubview:self.img ];
        [back_view1 addSubview:self.img1];
        [back_view1 addSubview:self.img2];
        [back_view1 addSubview:self.img3];
        [back_view1 addSubview:self.img4];
    }
    if (sender.tag-1000==2)
    {
        [(UIButton*)[self.view viewWithTag:1000] setBackgroundImage:[UIImage imageNamed:[unfive_arr objectAtIndex:0]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1001] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:1]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1002] setBackgroundImage:[UIImage imageNamed:[unfive_arr objectAtIndex:2]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1003] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:3]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1004] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:4]] forState:UIControlStateNormal];
        
        [[self.view viewWithTag:10001] removeFromSuperview];
        [[self.view viewWithTag:10002] removeFromSuperview];
        [[self.view viewWithTag:10003] removeFromSuperview];
        [[self.view viewWithTag:10004] removeFromSuperview];
        [[self.view viewWithTag:10005] removeFromSuperview];
        
///////////////////////////拼图的4个imageView/////////////////////////
        
        self.img  = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 296, 179)];
        self.img1 = [[UIImageView alloc]initWithFrame:CGRectMake(2, 183, 147, 138)];
        self.img2 = [[UIImageView alloc]initWithFrame:CGRectMake(151, 183, 147, 138)];
        self.img3 = [[UIImageView alloc]initWithFrame:CGRectMake(151, 183, 147, 138)];
        self.img4 = [[UIImageView alloc]initWithFrame:CGRectMake(151, 183, 147, 138)];
        
        self.img .tag = 10001;
        self.img1.tag = 10002;
        self.img2.tag = 10003;
        self.img3.tag = 10004;
        self.img4.tag = 10005;
        
        self.img. image=[d.fivepicArr objectAtIndex:0];
        self.img1.image=[d.fivepicArr objectAtIndex:1];
        self.img2.image=[d.fivepicArr objectAtIndex:2];
        self.img3.image=[d.fivepicArr objectAtIndex:3];
        self.img4.image=[d.fivepicArr objectAtIndex:4];

        
        [back_view1 addSubview:self.img ];
        [back_view1 addSubview:self.img1];
        [back_view1 addSubview:self.img2];
        [back_view1 addSubview:self.img3];
        [back_view1 addSubview:self.img4];
        
        
        
        
            }
    if (sender.tag-1000==3)
    {
        [(UIButton*)[self.view viewWithTag:1000] setBackgroundImage:[UIImage imageNamed:[unfive_arr objectAtIndex:0]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1001] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:1]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1002] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:2]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1003] setBackgroundImage:[UIImage imageNamed:[unfive_arr objectAtIndex:3]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1004] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:4]] forState:UIControlStateNormal];
    
        
        
        [[self.view viewWithTag:10001] removeFromSuperview];
        [[self.view viewWithTag:10002] removeFromSuperview];
        [[self.view viewWithTag:10003] removeFromSuperview];
        [[self.view viewWithTag:10004] removeFromSuperview];
        [[self.view viewWithTag:10005] removeFromSuperview];
        
        ///////////////////////////拼图的4个imageView/////////////////////////
        
        self.img  = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 296, 179)];
        self.img1 = [[UIImageView alloc]initWithFrame:CGRectMake(2, 183, 147, 138)];
        self.img2 = [[UIImageView alloc]initWithFrame:CGRectMake(151, 183, 147, 138)];
        self.img3 = [[UIImageView alloc]initWithFrame:CGRectMake(151, 183, 147, 138)];
        self.img4 = [[UIImageView alloc]initWithFrame:CGRectMake(151, 183, 147, 138)];
        
        self.img .tag = 10001;
        self.img1.tag = 10002;
        self.img2.tag = 10003;
        self.img3.tag = 10004;
        self.img4.tag = 10005;
        
        self.img. image=[d.fivepicArr objectAtIndex:0];
        self.img1.image=[d.fivepicArr objectAtIndex:1];
        self.img2.image=[d.fivepicArr objectAtIndex:2];
        self.img3.image=[d.fivepicArr objectAtIndex:3];
        self.img4.image=[d.fivepicArr objectAtIndex:4];
        
        [back_view1 addSubview:self.img ];
        [back_view1 addSubview:self.img1];
        [back_view1 addSubview:self.img2];
        [back_view1 addSubview:self.img3];
        [back_view1 addSubview:self.img4];

        
    }
    if (sender.tag-1000==4)
    {
        [(UIButton*)[self.view viewWithTag:1000] setBackgroundImage:[UIImage imageNamed:[unfive_arr objectAtIndex:0]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1001] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:1]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1002] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:2]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1003] setBackgroundImage:[UIImage imageNamed:[five_arr objectAtIndex:3]] forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:1004] setBackgroundImage:[UIImage imageNamed:[unfive_arr objectAtIndex:4]] forState:UIControlStateNormal];
     
        
        
        
        
        [[self.view viewWithTag:10001] removeFromSuperview];
        [[self.view viewWithTag:10002] removeFromSuperview];
        [[self.view viewWithTag:10003] removeFromSuperview];
        [[self.view viewWithTag:10004] removeFromSuperview];
        [[self.view viewWithTag:10005] removeFromSuperview];
        
     ///////////////////////////拼图的4个imageView/////////////////////////
        
        self.img  = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 296, 179)];
        self.img1 = [[UIImageView alloc]initWithFrame:CGRectMake(2, 183, 147, 138)];
        self.img2 = [[UIImageView alloc]initWithFrame:CGRectMake(151, 183, 147, 138)];
        self.img3 = [[UIImageView alloc]initWithFrame:CGRectMake(151, 183, 147, 138)];
        self.img4 = [[UIImageView alloc]initWithFrame:CGRectMake(151, 183, 147, 138)];
        
        self.img .tag = 10001;
        self.img1.tag = 10002;
        self.img2.tag = 10003;
        self.img3.tag = 10004;
        self.img4.tag = 10005;
        
        self.img. image=[d.fivepicArr objectAtIndex:0];
        self.img1.image=[d.fivepicArr objectAtIndex:1];
        self.img2.image=[d.fivepicArr objectAtIndex:2];
        self.img3.image=[d.fivepicArr objectAtIndex:3];
        self.img4.image=[d.fivepicArr objectAtIndex:4];
        
        [back_view1 addSubview:self.img ];
        [back_view1 addSubview:self.img1];
        [back_view1 addSubview:self.img2];
        [back_view1 addSubview:self.img3];
        [back_view1 addSubview:self.img4];

    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
