//
//  PriendPicViewController.m
//  DWin1.0
//
//  Created by Mac on 13-9-25.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "PriendPicViewController.h"
#import "ZXMacro.h"

#import "DWinUtils.h"
@interface PriendPicViewController ()

@end

@implementation PriendPicViewController

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
    // [btn_left setBackgroundImage:[UIImage imageNamed:@"friendlist_nav_leftbar"] forState:UIControlStateNormal];
    
    UIImage * image = [UIImage imageNamed:@"textedit_leftnavbar"];
    [btn_left setBackgroundImage:image forState:UIControlStateNormal];
    btn_left.tag=1;
    [btn_left addTarget:self action:@selector(navBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:btn_left];
    self.navigationItem.leftBarButtonItem = leftBar;
}
- (void)navBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavgationBar];
    self.navigationItem.title = @"Portfolio";
    
    // 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    //打开用户交互
    imageViewBackGround.userInteractionEnabled = YES;
    [self.view addSubview:imageViewBackGround];
    
    
    
    
    UIImageView *empty_btn = [[UIImageView alloc]init];
    empty_btn.frame = CGRectMake(75, 10, 170, 100);
    empty_btn.image= [UIImage imageNamed:@"empty_pic"];
    [imageViewBackGround addSubview:empty_btn];
    
    
    
    UIImageView *empty_btn1 = [[UIImageView alloc]init];
    empty_btn1.frame = CGRectMake(75, 125, 170, 100);
    empty_btn1.image= [UIImage imageNamed:@"empty_pic"];
    [imageViewBackGround addSubview:empty_btn1];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
