//
//  ActivityProjrctViewController.m
//  DWin1.0
//
//  Created by Mac on 13-10-9.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "ActivityProjrctViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
#import "SuccedProjectViewController.h"
#import "SucViewController.h"

@interface ActivityProjrctViewController ()

@end

@implementation ActivityProjrctViewController

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
    SuccedProjectViewController*surcced=[[SuccedProjectViewController alloc]init];
  // SucViewController*surcced=[[SucViewController alloc]init];
    [self.navigationController pushViewController:surcced animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    // 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    imageViewBackGround.userInteractionEnabled = YES;
    [self.view addSubview:imageViewBackGround];
    
    [self setNavgationBar];
	self.navigationItem.title = @"Activity";
    UIView * back_View = [[UIView alloc]initWithFrame:CGRectMake(10, 30, 300, 44+69*3)];
    
    back_View.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    back_View.layer.cornerRadius = 5;
    [imageViewBackGround addSubview:back_View];

    
    /////////////////////////////////titleview line//////////////////////////////////
    
    UIImageView *bacView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    UIImageView *linview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44+69, 300, 1)];
    UIImageView *linview1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44+69+69, 300, 1)];
      
    bacView .image = [UIImage imageNamed:@"activity_aph_"];
    linview .image = [UIImage imageNamed:@"activity_line"];
    linview1.image = [UIImage imageNamed:@"activity_line"];
    
    [back_View addSubview: bacView];
    [back_View addSubview: linview];
    [back_View addSubview:linview1];
 
    
    //////////////////////////////lines name///////////////////////////////
    
    
    UILabel *lab_title0 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    UILabel *lab_title1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0+32, 300, 60)];
    UILabel *lab_title2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0+32+69, 300, 60)];
    UILabel *lab_title3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0+32+69+69, 300, 60)];
       
    lab_title0.text = @"Step2: Make a project";
    lab_title1.text = @"Topic:";
    lab_title2.text = @"Partner:";
    lab_title3.text = @"Introduction:";
        
    lab_title0.backgroundColor = [UIColor clearColor];
    lab_title1.backgroundColor = [UIColor clearColor];
    lab_title2.backgroundColor = [UIColor clearColor];
    lab_title3.backgroundColor = [UIColor clearColor];
      
    lab_title0.textAlignment = 1;
    lab_title0.textColor = [UIColor whiteColor];
    
    
    [back_View addSubview:lab_title0];
    [back_View addSubview:lab_title1];
    [back_View addSubview:lab_title2];
    [back_View addSubview:lab_title3];
    
    
    
   /////////////////////////////////textfild///////////////////////////////
    
    UITextField * topic =[[UITextField alloc]initWithFrame:CGRectMake(10, 80, 300, 44)];
    UITextField * Partner =[[UITextField alloc]initWithFrame:CGRectMake(10, 80+69, 300, 44)];
    UITextField * Introduction =[[UITextField alloc]initWithFrame:CGRectMake(10, 80+69+69, 300, 44)];
    
    topic.placeholder = @"Obligatory";
    Partner.placeholder = @"Describe the partner you need";
    Introduction.placeholder = @"Describe the project in 60 words";
    
    [back_View addSubview:topic];
    [back_View addSubview:Partner];
    [back_View addSubview:Introduction];
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
