//
//  SignInViewController.m
//  DWin1.0
//
//  Created by Mac on 13-9-25.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "SignInViewController.h"
#import "SignInSencondViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
@interface SignInViewController ()

@end

@implementation SignInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [super viewWillAppear:animated];
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
    SignInSencondViewController *second = [[SignInSencondViewController alloc]init];
    [self.navigationController pushViewController:second animated:YES];
    
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
	self.navigationItem.title = @"New user";
    
    //user name
    self.signin_txt=[[UITextField alloc]initWithFrame:CGRectMake(10, 35, 300, 44)];
    self.signin_txt.font = [UIFont systemFontOfSize:19];
    self.signin_txt.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
  
    self.signin_txt.placeholder = @"Please inout your phone number";
    self.signin_txt.delegate = self;
    self.signin_txt.layer.cornerRadius = 5;
    self.signin_txt.backgroundColor=[UIColor colorWithWhite:0.9 alpha:0.5];
    [imageViewBackGround addSubview:self.signin_txt];
    
    
    UILabel *place_lab=[[UILabel alloc]initWithFrame:CGRectMake(40, 89, 240, 25)];
    place_lab.text = @"We will send you text number";
    place_lab.backgroundColor = [UIColor clearColor];
    [imageViewBackGround addSubview:place_lab];
    
    UILabel *place_lab2=[[UILabel alloc]initWithFrame:CGRectMake(65, 110, 240, 25)];
    place_lab2.text = @"To confirm the identity";
    place_lab2.backgroundColor = [UIColor clearColor];
    [imageViewBackGround addSubview:place_lab2];

//    //忘记密码按钮
//    UIButton*login_btnzhu=[UIButton buttonWithType:UIButtonTypeCustom];
//    [login_btnzhu addTarget:self action:@selector(longin_inzhu) forControlEvents:UIControlEventTouchUpInside];
//    [login_btnzhu setTitle:@"Lost password" forState:UIControlStateNormal];
//    [login_btnzhu setTitleColor:[UIColor colorWithRed:1 green:62/255.0 blue:62/255.0 alpha:1]forState:UIControlStateNormal];
//    login_btnzhu.frame=CGRectMake(181, 118, 300-170, 44);
//    [imageViewBackGround addSubview:login_btnzhu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
