//
//  SuccedProjectViewController.m
//  DWin1.0
//
//  Created by Mac on 13-10-9.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "SuccedProjectViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
#import "ActivityChatViewController.h"
#import "SucViewController.h"
#import "ActivityGroupChatViewController.h"
#import "ActivityBusinessViewController.h"
#import "ActivityTimelineViewController.h"
@interface SuccedProjectViewController ()

@end

@implementation SuccedProjectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)setNavgationBar
{
    // 导航条左按钮
    UIButton *btn_left = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_left.frame = CGRectMake(0, 0, 56, 18);
    [btn_left setBackgroundImage:[UIImage imageNamed:@"moment_backBtn"] forState:UIControlStateNormal];
    btn_left.tag=1;
    [btn_left addTarget:self action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:btn_left];
    self.navigationItem.leftBarButtonItem = leftBar;
    // 导航条右按钮
    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_right.frame = CGRectMake(0, 0, 92/2, 44);
    [btn_right setBackgroundImage:[UIImage imageNamed:@"done"] forState:UIControlStateNormal];
    btn_right.tag=2;
    [btn_right addTarget:self action:@selector(navBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
    self.navigationItem.rightBarButtonItem = rightBar;
}
-(void)toggleLeftView
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)navBtnClick
{
    NSLog(@"Next");
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    // 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    imageViewBackGround.userInteractionEnabled = YES;
    [self.view addSubview:imageViewBackGround];
    
    [self setNavgationBar];
	self.navigationItem.title = @"Activity";
    
    UIScrollView *scr = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 10, 300, 500)];
    scr.backgroundColor = [UIColor whiteColor];
    scr.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    scr.backgroundColor = [UIColor clearColor];
    scr.contentSize = CGSizeMake(300, 1444);
    
    [imageViewBackGround addSubview:scr];
    
    ///////////////////////////first view ////////////////////////////// 
    
    back_View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 188)];
    
    back_View.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    
    back_View.layer.cornerRadius = 5;
    
    [scr addSubview:back_View];
    
    UIImageView *bacView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    UIImageView *linview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44+69, 300, 1)];
    bacView.userInteractionEnabled = YES;
    bacView .image = [UIImage imageNamed:@"activity_aph_"];
    linview .image = [UIImage imageNamed:@"activity_line"];
    
    [back_View addSubview: bacView];
    [back_View addSubview: linview];
    
    UILabel*lab_title=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 44)];
    lab_title.backgroundColor = [UIColor clearColor];
    lab_title.text = @"Project:make an App";
    lab_title.textColor = [UIColor whiteColor];
    [back_View addSubview:lab_title];
    
    UIButton *btn_title = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_title setTitle:@"Edit" forState:UIControlStateNormal];
    btn_title.frame = CGRectMake(300-44-10, 0, 44, 44);
    [btn_title setTitleColor:RGBAlpha(177, 255, 199, 1) forState:UIControlStateNormal];
    [btn_title addTarget:self action:@selector(changetxt) forControlEvents:UIControlEventTouchUpInside];
    [bacView addSubview:btn_title];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 48, 200, 69/2)];
    
    lab.text = @"Partner:";
    lab.backgroundColor = [UIColor clearColor];
    [back_View addSubview:lab];
    UILabel *dlab = [[UILabel alloc]initWithFrame:CGRectMake(10, 40+69/2, 280, 69/2)];
    dlab.text = @" My grandfather died when I was a small boy ";
    dlab.numberOfLines = 0;
    [dlab sizeToFit];
    dlab.backgroundColor = [UIColor clearColor];
    [back_View addSubview:dlab];
    linview.frame=CGRectMake(0, 50+69/2+dlab.frame.size.height, 300, 1);
    
    UILabel *dlab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50+69/2+dlab.frame.size.height+10, 280, 69/2)];
    dlab1.text = @" My grandfather died when I was a small boy referred to as  She carried with her a powerful aroma. I don't know what kind of perfume she used, but it was the double-barreled, ninety-proof, knockdown";
    dlab1.numberOfLines = 0;
    [dlab1 sizeToFit];
    dlab1.backgroundColor = [UIColor clearColor];
    [back_View addSubview:dlab1];
    back_View.frame=CGRectMake(0, 30, 300, 44+lab.frame.size.height+dlab.frame.size.height+1+dlab1.frame.size.height+20);
    
    ///////////////////////////second view /////////////////////////////
    
//    NSLog(@"=====================%f",bacView.frame.size.height+20);
//    back_View2 = [[UIView alloc]initWithFrame:CGRectMake(0,back_View.frame.size.height+44, 300, 384/2)];
//    
//    back_View2.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
//    back_View2.layer.cornerRadius = 5;
//    [scr addSubview:back_View2];
//
//    
//    UIImageView *bacView2  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
//    
//    bacView2.userInteractionEnabled = YES;
//    bacView2 .image = [UIImage imageNamed:@"activity_aph_"];
//    [back_View2 addSubview: bacView2];
//    
//    UILabel*lab_title2=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
//    lab_title2.backgroundColor = [UIColor clearColor];
//    lab_title2.text = @"CV post";
//    lab_title2.textColor = [UIColor whiteColor];
//    [back_View2 addSubview:lab_title2];
//    
//    shou_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    shou_btn.frame = CGRectMake(70, 0, 44, 44);
//    [shou_btn setBackgroundImage:[UIImage imageNamed:@"activity_shou_img"] forState:UIControlStateNormal];
//    [shou_btn addTarget:self action:@selector(shouqi) forControlEvents:UIControlEventTouchUpInside];
//    [back_View2 addSubview:shou_btn];
//
//    UIButton *btn_title2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_title2 setTitle:@"Chat" forState:UIControlStateNormal];
//    btn_title2.frame = CGRectMake(300-44-10, 0, 44, 44);
//    [btn_title2 setTitleColor:RGBAlpha(177, 255, 199, 1) forState:UIControlStateNormal];
//    [btn_title2 addTarget:self action:@selector(changetxt2) forControlEvents:UIControlEventTouchUpInside];
//    [bacView2 addSubview:btn_title2];
//    
//    for (int a = 0; a<4; a++) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(16 +a*74, 51, 46, 46);
//        btn.tag = 400+a;
//        [btn setBackgroundImage:[UIImage imageNamed:@"bighead"] forState:UIControlStateNormal];
//        [back_View2 addSubview:btn];
//    }
//    
//    for (int a = 0; a<4; a++) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(16 +a*74, 51+46+28, 46, 46);
//        btn.tag = 500+a;
//        [btn setBackgroundImage:[UIImage imageNamed:@"bighead"] forState:UIControlStateNormal];
//        [back_View2 addSubview:btn];
//    }
//    for (int a=0; a<4; a++) {
//        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(16+a*74, 51+46, 46, 20)];
//        lab.text = @"arrir";
//        lab.backgroundColor = [UIColor clearColor];
//        lab.textAlignment = 1;
//        [back_View2 addSubview:lab];
//    }
//    
//    for (int a=0; a<4; a++) {
//        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(16+a*74, 51+46+46+28, 46, 20)];
//        lab.text = @"arrir";
//        lab.backgroundColor = [UIColor clearColor];
//        lab.textAlignment = 1;
//        [back_View2 addSubview:lab];
//    }
    ///////////////////////////therd view /////////////////////////////
    
    NSLog(@"=====================%f",bacView.frame.size.height+20);
    back_View3 = [[UIView alloc]initWithFrame:CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20, 300, 236/2)];
    
    back_View3.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    back_View3.layer.cornerRadius = 5;
    [scr addSubview:back_View3];
    
    
    UIImageView *bacView3  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    
    bacView3.userInteractionEnabled = YES;
    bacView3 .image = [UIImage imageNamed:@"activity_aph_"];
    [back_View3 addSubview: bacView3];
    
    UILabel*lab_title3=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    lab_title3.backgroundColor = [UIColor clearColor];
    lab_title3.text = @"Partners";
    lab_title3.textColor = [UIColor whiteColor];
    [back_View3 addSubview:lab_title3];
    
    UIScrollView *head_scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, 300, 74)];
    
    head_scr.backgroundColor = [UIColor redColor];
    head_scr.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    head_scr.backgroundColor = [UIColor clearColor];
    head_scr.contentSize = CGSizeMake(1800, 74);
    
    [back_View3 addSubview:head_scr];
    
    
    shou_btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    shou_btn3.frame = CGRectMake(75, 0, 44, 44);
    [shou_btn3 setBackgroundImage:[UIImage imageNamed:@"activity_shou_img"] forState:UIControlStateNormal];
    [shou_btn3 addTarget:self action:@selector(shouqi1) forControlEvents:UIControlEventTouchUpInside];
    [back_View3 addSubview:shou_btn3];
    
    UIButton *btn_title3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_title3 setTitle:@"Chat" forState:UIControlStateNormal];
    btn_title3.frame = CGRectMake(300-44-10, 0, 44, 44);
    [btn_title3 setTitleColor:RGBAlpha(177, 255, 199, 1) forState:UIControlStateNormal];
    [btn_title3 addTarget:self action:@selector(changetxt3) forControlEvents:UIControlEventTouchUpInside];
    [bacView3 addSubview:btn_title3];
    
    for (int a = 0; a<7; a++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(16 +a*74, 7, 46, 46);
        btn.tag = 400+a;
        [btn setBackgroundImage:[UIImage imageNamed:@"bighead"] forState:UIControlStateNormal];
        [head_scr addSubview:btn];
    }
    for (int a=0; a<7; a++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(16+a*74, 7+46, 46, 20)];
        lab.text = @"arrir";
        lab.backgroundColor = [UIColor clearColor];
        lab.textAlignment = 1;
        [head_scr addSubview:lab];
    }

    ///////////////////////////four view /////////////////////////////
    
    NSLog(@"=====================%f",bacView.frame.size.height+20);
    back_View4 = [[UIView alloc]initWithFrame:CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20+back_View3.frame.size.height+20, 300, 638/2)];
    
    back_View4.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    back_View4.layer.cornerRadius = 5;
    [scr addSubview:back_View4];
    
    
    UIImageView *bacView4  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    
    bacView4.userInteractionEnabled = YES;
    bacView4 .image = [UIImage imageNamed:@"activity_aph_"];
    [back_View4 addSubview: bacView4];
    
    
    UILabel*lab_title4=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    lab_title4.backgroundColor = [UIColor clearColor];
    lab_title4.text = @"Timeline";
    lab_title4.textColor = [UIColor whiteColor];
    [back_View4 addSubview:lab_title4];
    
    /////////////////// shouqi ////////////////////
    
    shou_btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    shou_btn4.frame = CGRectMake(75, 0, 44, 44);
    [shou_btn4 setBackgroundImage:[UIImage imageNamed:@"activity_shou_img"] forState:UIControlStateNormal];
    [shou_btn4 addTarget:self action:@selector(shouqi2) forControlEvents:UIControlEventTouchUpInside];
    [back_View4 addSubview:shou_btn4];
    
    UIButton *btn_title4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_title4 setTitle:@"View" forState:UIControlStateNormal];
    btn_title4.frame = CGRectMake(300-44-10, 0, 44, 44);
    [btn_title4 setTitleColor:RGBAlpha(177, 255, 199, 1) forState:UIControlStateNormal];
    [btn_title4 addTarget:self action:@selector(changetxt4) forControlEvents:UIControlEventTouchUpInside];
    [bacView4 addSubview:btn_title4];
    
    UIImageView *imge= [[UIImageView alloc]initWithFrame:CGRectMake(0, 84, 300, 1)];
    imge.image=[UIImage imageNamed:@"activity_line"];
    [back_View4 addSubview:imge];
    
    for (int a = 0; a<5; a++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(16 , 94+a*46, 34, 34);
        btn.tag = 500+a;
        [btn setBackgroundImage:[UIImage imageNamed:@"acti_small"] forState:UIControlStateNormal];
        [back_View4 addSubview:btn];
    }

 
    for (int a = 0; a<7; a++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(12+34+32+40*a, 93, 1, 220)];
        img.image = [UIImage imageNamed:@"acti_xuline"];
        [back_View4 addSubview:img];
    }
    
    UILabel *time_lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 44, 50, 40)];
    time_lab.textAlignment =1;
    time_lab.text = @"13-09";
    time_lab.backgroundColor = [UIColor clearColor];
    [back_View4 addSubview:time_lab];
    
    for (int a=0; a<7; a++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(12+42+40*a, 44, 40, 40)];
        lab.textAlignment =1;
        lab.tag = 600+a;
        lab.text = @"03";
        lab.backgroundColor = [UIColor clearColor];
        [back_View4 addSubview:lab];
    }
    [back_View4 viewWithTag:601].backgroundColor = [UIColor purpleColor];;
    [back_View4 viewWithTag:601].layer.cornerRadius=35;
    ///////////////////////////five view /////////////////////////////
    
    NSLog(@"=====================%f",bacView.frame.size.height+20);
    back_View5 = [[UIView alloc]initWithFrame:CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20+back_View3.frame.size.height+20+back_View4.frame.size.height+20, 300, 580/2)];
    
    back_View5.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    back_View5.layer.cornerRadius = 5;
    [scr addSubview:back_View5];
    
    
    UIImageView *bacView5  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    
    bacView5.userInteractionEnabled = YES;
    bacView5 .image = [UIImage imageNamed:@"activity_aph_"];
    [back_View5 addSubview: bacView5];
    
    
    UILabel*lab_title5=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    lab_title5.backgroundColor = [UIColor clearColor];
    lab_title5.text = @"Business";
    lab_title5.textColor = [UIColor whiteColor];
    [back_View5 addSubview:lab_title5];
    
    /////////////////// shouqi ////////////////////
    
    shou_btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    shou_btn5.frame = CGRectMake(80, 0, 44, 44);
    [shou_btn5 setBackgroundImage:[UIImage imageNamed:@"activity_shou_img"] forState:UIControlStateNormal];
    [shou_btn5 addTarget:self action:@selector(shouqi3) forControlEvents:UIControlEventTouchUpInside];
    [back_View5 addSubview:shou_btn5];
    
    UIButton *btn_title5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_title5 setTitle:@"View" forState:UIControlStateNormal];
    btn_title5.frame = CGRectMake(300-44-10, 0, 44, 44);
    [btn_title5 setTitleColor:RGBAlpha(177, 255, 199, 1) forState:UIControlStateNormal];
    [btn_title5 addTarget:self action:@selector(changetxt5) forControlEvents:UIControlEventTouchUpInside];
    [bacView5 addSubview:btn_title5];

    
    CGRect scrollViewRect = [self.view bounds];
    scrollViewRect.size.height -= 50;
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, 300, 580/2-44)];
    myScrollView.pagingEnabled = YES;//开启多个试图
     myScrollView.contentSize = CGSizeMake(scrollViewRect.size.width *9,5);
    myScrollView.showsHorizontalScrollIndicator = NO;//上下滑动条
    myScrollView.showsVerticalScrollIndicator = NO;//左右滑动条
    myScrollView.delegate = self;//设置代理
    
    myPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 544/2, 320, 10)];
    myPageControl.backgroundColor = [UIColor clearColor];
    myPageControl.numberOfPages =9;
    myPageControl.currentPage = 0;
    [myPageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    //create pages
    [self createPages];
    
    //add to main view
    [back_View5 addSubview:myScrollView];
    [back_View5 addSubview:myPageControl];
}
- (void)createPages
{
    CGRect pageRect = myScrollView.frame;
    
    //create pages
    UIView *page1 = [[UIView alloc] initWithFrame:pageRect];
    
    UIView *page2 = [[UIView alloc] initWithFrame:pageRect];
    
    UIView *page3 = [[UIView alloc] initWithFrame:pageRect];
   
    UIView *page4 = [[UIView alloc] initWithFrame:pageRect];
    UIView *page5 = [[UIView alloc] initWithFrame:pageRect];
  
    UIView *page6 = [[UIView alloc] initWithFrame:pageRect];
 
    UIView *page7 = [[UIView alloc] initWithFrame:pageRect];
    UIView *page8 = [[UIView alloc] initWithFrame:pageRect];
  
    UIView *page9 = [[UIView alloc] initWithFrame:pageRect];
       
    //add to scrollview
    [self loadScrollViewWithPage:page1];
    [self loadScrollViewWithPage:page2];
    [self loadScrollViewWithPage:page3];
    [self loadScrollViewWithPage:page4];
    [self loadScrollViewWithPage:page5];
    [self loadScrollViewWithPage:page6];
    [self loadScrollViewWithPage:page7];
    [self loadScrollViewWithPage:page8];
    [self loadScrollViewWithPage:page9];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 44)];
    lb.text = @"PROBLEM";
    lb.backgroundColor = [UIColor clearColor];
    [page1 addSubview:lb];
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 44, 300, 30)];
    lb1.text = @"One evening I visited the English corner of our university. It lies heside our university library where trees and flowers grow and there is a spacious ground. Every evening,large numbers of people go there to improve their English, but I had never been there before.";
    lb1.backgroundColor = [UIColor clearColor];
    lb1.numberOfLines = 0;
    [lb1 sizeToFit];
    [page1 addSubview:lb1];
    
}
- (void)loadScrollViewWithPage:(UIView *)page
{
    int pageCount = [[myScrollView subviews] count];
    
    CGRect bounds = myScrollView.bounds;
    bounds.origin.x = bounds.size.width * pageCount;
    bounds.origin.y = 0;
    page.frame = bounds;
    [myScrollView addSubview:page];
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    myPageControl.currentPage = page;
}

- (void)changePage:(id)sender
{
    int page = myPageControl.currentPage;
    
    // update the scroll view to the appropriate page
    CGRect frame = myScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [myScrollView scrollRectToVisible:frame animated:YES];
}

-(void)shouqi
{
    NSLog(@"1234567890");
    
    if (flag_shouqi==NO)
    {
        [UIView animateWithDuration:1 animations:^{
             back_View2.frame=CGRectMake(0,back_View.frame.size.height+44, 300, 44);
             back_View3.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20, 300, 236/2);
             back_View4.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20+back_View3.frame.size.height+20, 300, 638/2);
             back_View5.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20+back_View3.frame.size.height+20+back_View4.frame.size.height+20, 300, 580/2);
            
            
        }];
        flag_shouqi=YES;
        [shou_btn setBackgroundImage:[UIImage imageNamed:@"activity_shou_imgdown"] forState:UIControlStateNormal];
    }
    else
    {
        [UIView animateWithDuration:1 animations:^{
            back_View2.frame=CGRectMake(0,back_View.frame.size.height+44, 300, 384/2);
            
            back_View3.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20, 300, 236/2);
            back_View4.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20+back_View3.frame.size.height+20, 300, 638/2);
            back_View5.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20+back_View3.frame.size.height+20+back_View4.frame.size.height+20, 300, 580/2);
            
        }];
        flag_shouqi=NO;

     [shou_btn setBackgroundImage:[UIImage imageNamed:@"activity_shou_img"] forState:UIControlStateNormal];
    }
        
}
-(void)shouqi1
{
    
    if (flag_shouqi1==NO)
    {
        [UIView animateWithDuration:1 animations:^{
           
            back_View3.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20, 300, 44);
            back_View4.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20+back_View3.frame.size.height+20, 300, 638/2);
            back_View5.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20+back_View3.frame.size.height+20+back_View4.frame.size.height+20, 300, 580/2);
            
            
        }];
        flag_shouqi1=YES;
        [shou_btn3 setBackgroundImage:[UIImage imageNamed:@"activity_shou_imgdown"] forState:UIControlStateNormal];
    }
    else
    {
        [UIView animateWithDuration:1 animations:^{
            
         
            
            back_View3.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20, 300, back_View3.frame.size.height);
            back_View4.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20+back_View3.frame.size.height+20, 300, 638/2);
            back_View5.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20+back_View3.frame.size.height+20+back_View4.frame.size.height+20, 300, 580/2);
            
        }];
        flag_shouqi1=NO;
        
        [shou_btn3 setBackgroundImage:[UIImage imageNamed:@"activity_shou_img"] forState:UIControlStateNormal];
    }

    
}
-(void)shouqi2
{
    if (flag_shouqi2==NO)
    {
        [UIView animateWithDuration:1 animations:^{
            
            
            back_View4.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20+back_View3.frame.size.height+20, 300, 44);
            back_View5.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20+back_View3.frame.size.height+20+back_View4.frame.size.height+20, 300, 580/2);
            
            
        }];
        flag_shouqi2=YES;
        [shou_btn4 setBackgroundImage:[UIImage imageNamed:@"activity_shou_imgdown"] forState:UIControlStateNormal];
    }
    else
    {
        [UIView animateWithDuration:1 animations:^{
            
            
                      back_View4.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20+back_View3.frame.size.height+20, 300, 638/2);
            back_View5.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20+back_View3.frame.size.height+20+back_View4.frame.size.height+20, 300, 580/2);
            
        }];
        flag_shouqi2=NO;
        
        [shou_btn4 setBackgroundImage:[UIImage imageNamed:@"activity_shou_img"] forState:UIControlStateNormal];
    }
    

    
}
-(void)shouqi3
{
    
    if (flag_shouqi2==NO)
    {
        [UIView animateWithDuration:1 animations:^{
            
            
            
            back_View5.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20+back_View3.frame.size.height+20+back_View4.frame.size.height+20, 300, 44);
            
            
        }];
        flag_shouqi2=YES;
        [shou_btn5 setBackgroundImage:[UIImage imageNamed:@"activity_shou_imgdown"] forState:UIControlStateNormal];
    }
    else
    {
        [UIView animateWithDuration:1 animations:^{
            
            
            
            back_View5.frame=CGRectMake(0,back_View.frame.size.height+44+back_View2.frame.size.height+20+back_View3.frame.size.height+20+back_View4.frame.size.height+20, 300, 580/2);
            
        }];
        flag_shouqi2=NO;
        
        [shou_btn5 setBackgroundImage:[UIImage imageNamed:@"activity_shou_img"] forState:UIControlStateNormal];
    }
    

}
-(void)changetxt
{

    NSLog(@"123456789");
}
-(void)changetxt2
{
    
    NSLog(@"987654321");
   // ActivityChatViewController *act = [[ActivityChatViewController alloc]init];
    SucViewController *act=[[SucViewController alloc]init];
    [self.navigationController pushViewController:act animated:YES];
}
-(void)changetxt3
{
    ActivityGroupChatViewController*group=[[ActivityGroupChatViewController alloc]init];
    [self.navigationController pushViewController:group animated:YES];
    NSLog(@"123456789");
}
-(void)changetxt4
{
    
    NSLog(@"123456789");
    ActivityTimelineViewController*line=[[ActivityTimelineViewController alloc]init];
    [self.navigationController pushViewController:line animated:YES];
}
-(void)changetxt5
{
    ActivityBusinessViewController*bes=[[ActivityBusinessViewController alloc]init];
    [self.navigationController pushViewController:bes animated:YES];
    NSLog(@"123456789");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
