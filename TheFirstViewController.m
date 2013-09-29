//
//  TheFirstViewController.m
//  DWin1.0
//
//  Created by Mac on 13-9-25.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "TheFirstViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SignInViewController.h"
@interface TheFirstViewController ()

@end

@implementation TheFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        
    }
    return self;
}
-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewDeckController.panningMode = IIViewDeckNoPanning;
    // 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"kaijilogo"];
    imageViewBackGround.userInteractionEnabled = YES;
    [self.view addSubview:imageViewBackGround];
    
    //注册 btn
    UIButton *signin_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    signin_btn.frame = CGRectMake(0, kContent_Height-88, 184/2, 92/2);
    [signin_btn setBackgroundImage:[UIImage imageNamed:@"signin"] forState:UIControlStateNormal];
    [signin_btn addTarget:self action:@selector(signin) forControlEvents:UIControlEventTouchUpInside];
    [signin_btn setTitle:@"Sign up" forState:UIControlStateNormal];
    [imageViewBackGround addSubview:signin_btn];
    
    //登陆 btn
    UIButton *log_in = [UIButton buttonWithType:UIButtonTypeCustom];
    log_in.frame = CGRectMake(self.view.frame.size.width-184/2, kContent_Height-88, 184/2, 92/2);
    [log_in setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [log_in addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
      [log_in setTitle:@"Log in" forState:UIControlStateNormal];
    [imageViewBackGround addSubview:log_in];
}
-(void)signin
{
    SignInViewController *signin = [[SignInViewController alloc]init];
    [self.navigationController pushViewController:signin animated:YES];
    NSLog(@"zhuce");

}
-(void)login

{

    NSLog(@"denglu ");
    LoginViewController *log = [[LoginViewController alloc]init] ;
    [self.navigationController pushViewController:log animated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
