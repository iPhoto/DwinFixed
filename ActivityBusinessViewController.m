//
//  ActivityBusinessViewController.m
//  DWin1.0
//
//  Created by Mac on 13-10-10.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "ActivityBusinessViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
@interface ActivityBusinessViewController ()

@end

@implementation ActivityBusinessViewController

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
	self.navigationItem.title = @"Business";
    
    
    
    CGRect scrollViewRect = [self.view bounds];
    scrollViewRect.size.height -= 50;
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 24, 320, self.view.frame.size.height-44)];
    myScrollView.pagingEnabled = YES;//开启多个试图
    myScrollView.contentSize = CGSizeMake(scrollViewRect.size.width *9,5);
    myScrollView.showsHorizontalScrollIndicator = NO;//上下滑动条
    myScrollView.showsVerticalScrollIndicator = NO;//左右滑动条
    myScrollView.delegate = self;//设置代理
    
    myPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-44-10, 320, 10)];
    myPageControl.backgroundColor = [UIColor clearColor];
    myPageControl.numberOfPages =9;
    myPageControl.currentPage = 0;
    [myPageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    //create pages
    [self createPages];
    
    //add to main view
    [imageViewBackGround addSubview:myScrollView];
    [imageViewBackGround addSubview:myPageControl];

}
- (void)createPages
{
    CGRect pageRect = myScrollView.frame;
    
    //create pages
    UIView *page1 = [[UIView alloc] initWithFrame:pageRect];
    page1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
