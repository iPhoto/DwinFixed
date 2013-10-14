//
//  MakejobSecondViewController.m
//  DWin1.0
//
//  Created by Mac on 13-10-13.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "MakejobSecondViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
@interface MakejobSecondViewController ()

@end

@implementation MakejobSecondViewController

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
   
}
-(void)toggleLeftView
{
    [title removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//////////////导航上的头像文字//////////////
    
    title= [[UIView alloc]initWithFrame:CGRectMake(100, 0, 120, 44)];
    
    [self.navigationController.view addSubview:title];
    
    UIImageView*imag = [[UIImageView alloc]initWithFrame:CGRectMake(60-34-2, 5, 34, 34)];
    imag.image = [UIImage imageWithContentsOfFile:FileS(@"acti_small", @"png")];
    [title addSubview:imag];
    UILabel*lab = [[UILabel alloc]initWithFrame:CGRectMake(60+2, 5, 34, 34)];
    lab.text = @"Lily";
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = [UIColor whiteColor];
    [title addSubview:lab];
    
    // 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    imageViewBackGround.userInteractionEnabled = YES;
    [self.view addSubview:imageViewBackGround];
    
    [self setNavgationBar];

    UIView * back_View = [[UIView alloc]initWithFrame:CGRectMake(10, 30, 300, 44+69*3)];
    
    back_View.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    back_View.layer.cornerRadius = 5;
    [imageViewBackGround addSubview:back_View];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
