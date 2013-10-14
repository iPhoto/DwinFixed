//
//  ActivityChatViewController.m
//  DWin1.0
//
//  Created by Mac on 13-10-10.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "ActivityChatViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
#import "ActivityChatSecondViewController.h"
@interface ActivityChatViewController ()

@end

@implementation ActivityChatViewController

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
    
    ActivityChatSecondViewController *ac = [[ActivityChatSecondViewController alloc]init];
    [self.navigationController pushViewController:ac animated:YES];
    
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
	self.navigationItem.title = @"Chat";
    UIView *back_View = [[UIView alloc]initWithFrame:CGRectMake(10, 30, 300, 188)];
    
    back_View.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    
    back_View.layer.cornerRadius = 5;
    
    [imageViewBackGround addSubview:back_View];
    UIImageView *bacView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    UIImageView *linview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44+69, 300, 1)];
    bacView.userInteractionEnabled = YES;
    bacView .image = [UIImage imageNamed:@"activity_aph_"];
    linview .image = [UIImage imageNamed:@"activity_line"];
    
    [back_View addSubview: bacView];
    [back_View addSubview: linview];

    
    UIImageView *ima = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 34, 34)];
    ima.image = [UIImage imageNamed:@"small_chat"];
    [back_View addSubview: ima];
    UIImageView *ima1 = [[UIImageView alloc]initWithFrame:CGRectMake(52, 25, 6, 9)];
    ima1.image = [UIImage imageNamed:@"activity_place"];
    [back_View addSubview: ima1];
    
    UILabel * nameLab=[[UILabel alloc]initWithFrame:CGRectMake(51, 0, 150, 25)];
    
    nameLab.text = @"Aire";
    
    nameLab.textColor = [UIColor whiteColor];
    
    nameLab.backgroundColor = [UIColor clearColor];
    
    [bacView addSubview:nameLab];
    
    UILabel * denameLab=[[UILabel alloc]initWithFrame:CGRectMake(61, 16, 150, 25)];
    
    denameLab.text = @"Chaoyang";
    
    denameLab.textColor = [UIColor whiteColor];
    
    denameLab.font=[UIFont fontWithName:@"Helvetica-Bold" size:12];
    
    denameLab.backgroundColor = [UIColor clearColor];
    
    [bacView addSubview:denameLab];
    
    

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
