//
//  LoginViewController.m
//  DWin1.0
//
//  Created by zang qilong on 13-9-24.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ZXMacro.h"
#import "DWinUtils.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

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
    NSLog(@"Done");
    [self longin_in];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavgationBar];
    
    // 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    imageViewBackGround.userInteractionEnabled = YES;
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    [self.view addSubview:imageViewBackGround];

    
    
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.title=@"Log in";
    self.view.backgroundColor=[UIColor whiteColor];
    
    //user name
    self.login_txt=[[UITextField alloc]initWithFrame:CGRectMake(10, 15, 300, 44)];
    self.login_txt.font = [UIFont systemFontOfSize:19];
    self.login_txt.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    self.login_txt.text=@"123456789";
    self.login_txt.placeholder = @"Account";
    self.login_txt.delegate = self;
    self.login_txt.layer.cornerRadius = 5;
    self.login_txt.backgroundColor=[UIColor colorWithWhite:0.9 alpha:0.5];
    [self.view addSubview:self.login_txt];
    
    //用户密码
    self.login_secret=[[UITextField alloc]initWithFrame:CGRectMake(10, 148/2, 300, 44)];
    self.login_secret.backgroundColor=[UIColor colorWithWhite:0.9 alpha:0.5];
    self.login_secret.text=@"123";
    self.login_secret.delegate = self;
    self.login_secret.placeholder = @"Password";
    self.login_secret.layer.cornerRadius = 5;
    self.login_secret.font = [UIFont systemFontOfSize:19];
    self.login_secret.returnKeyType=UIReturnKeyGo;
    self.login_secret.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:self.login_secret];
    
       
    

    
    //忘记密码按钮
    UIButton*login_btnzhu=[UIButton buttonWithType:UIButtonTypeCustom];
    [login_btnzhu addTarget:self action:@selector(longin_inzhu) forControlEvents:UIControlEventTouchUpInside];
    [login_btnzhu setTitle:@"Lost password" forState:UIControlStateNormal];
    [login_btnzhu setTitleColor:[UIColor colorWithRed:1 green:62/255.0 blue:62/255.0 alpha:1]forState:UIControlStateNormal];
    login_btnzhu.frame=CGRectMake(181, 118, 300-170, 44);
    [self.view addSubview:login_btnzhu];
    
    //点击屏幕任何地方回收键盘
    UIControl *m_control = [[UIControl alloc]initWithFrame:self.view.frame];
    [m_control addTarget:self action:@selector(keyboardReturn)
        forControlEvents:UIControlEventTouchUpInside];
    [imageViewBackGround addSubview:m_control];

	// Do any additional setup after loading the view.
}

//点击屏幕任何地方回收键盘
- (void) keyboardReturn
{
    [self.login_secret resignFirstResponder];
    [self.login_txt resignFirstResponder];
}
//点击键盘 Go 要走的委托方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self longin_in];
    return YES;
}
-(void)downloadCompleteMovieImage:(HttpHelper*)hh{
    NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:hh.downloadData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"dict%@",dict);
    
    if (dict!=nil) {
        NSString*states=[dict objectForKey:@"status"];
        
        if([states isEqual:@"success"])
        {
            [self.navigationController popToRootViewControllerAnimated:YES ];
            
            
        }
        NSDictionary*data=[dict objectForKey:@"data"];
        
        NSLog(@"data=====%@",data);
        
        
        NSArray*arr=[data objectForKey:@"user"];
        NSLog(@"user====%@",arr);
        
        
    }
    
}
-(void)downloadComp:(HttpHelper *)hh{
    NSLog(@"hh = %@",hh.downloadData);
    
}
-(void)longin_inzhu
{
    
    
    NSLog(@"忘记密码");
//    SignupViewController*sin=[[SignupViewController alloc]init];
//    [self.navigationController pushViewController:sin animated:YES];
    
    
}
-(void)longin_in
{
    
    
    NSDictionary*dict=[[NSDictionary alloc]initWithObjectsAndKeys:self.login_txt.text,@"phone",self.login_secret.text,@"password", nil];
    
    _httpHelperMovieImage = [[HttpHelper alloc] init];
    _httpHelperMovieImage.delegate = self;
    _httpHelperMovieImage.method = @selector(downloadCompleteMovieImage:);
    // [_httpHelperMovieImage downloadFromUrlWithASIByPost:@"http://192.168.0.178:9000/login" dict:dict];
    [_httpHelperMovieImage downloadFromUrlWithASIByPost:@"http://192.168.0.168:9000/login" dict:dict file:@""];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
