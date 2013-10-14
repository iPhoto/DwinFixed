//
//  ActivityTimelineViewController.m
//  DWin1.0
//
//  Created by Mac on 13-10-11.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "ActivityTimelineViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
@interface ActivityTimelineViewController ()

@end

@implementation ActivityTimelineViewController

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
	self.navigationItem.title = @"Time line";

    
    UIView *back_View = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height-44)];
    
    back_View.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    
    [imageViewBackGround addSubview:back_View];
    
    UIScrollView * back_scro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height-44)];
    
    back_scro.contentSize = CGSizeMake(800, 800);
    [imageViewBackGround addSubview:back_scro];
    UIImageView *imge= [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, 800, 1)];
   // imge.image=[UIImage imageWithContentsOfFile:FileS(@"activity_line", @"png")];
    imge.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:FileS(@"activity_line", @"png")]];
   // imge.image=[UIImage nil];
    [back_scro addSubview:imge];

    UILabel *time_lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 2, 50, 40)];
    time_lab.textAlignment =1;
    time_lab.text = @"13-09";
    time_lab.backgroundColor = [UIColor clearColor];
    [back_scro addSubview:time_lab];
    
    for (int a=0; a<7; a++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(12+22+40+40*a, 2, 40, 40)];
        lab.textAlignment =1;
        lab.tag = 600+a;
        lab.text = @"03";
        lab.backgroundColor = [UIColor clearColor];
        [back_scro addSubview:lab];
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
