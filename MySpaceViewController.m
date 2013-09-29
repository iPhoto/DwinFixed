//
//  MySpaceViewController.m
//  DWin1.0
//
//  Created by Mac on 13-9-24.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "MySpaceViewController.h"
#import "FriendSpaceViewController.h"
#import "PriendPicViewController.h"
#define kTabAlreadyDownUserViewY 0
#define kTabAlreadyUpUserViewY -80
#define kScrollAlreadyUp 50
#define kScrollAlreadyDown 130
#import <QuartzCore/QuartzCore.h>
#import "FriendListViewController.h"
@interface MySpaceViewController ()

@end

@implementation MySpaceViewController

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
-(void)navBtnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavgationBar];
    self.navigationItem.title = @"Lily space";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    //打开用户交互
    imageViewBackGround.userInteractionEnabled = YES;
    [self.view addSubview:imageViewBackGround];

    
    // 设置高度
    getViewHeight = 0;
    
    // 用户信息
    UIImageView *imageViewBackGround2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    NSLog(@"%f",kScreen_Height);
    imageViewBackGround2.image = [UIImage imageNamed:@"friendlistbg1"];
    
    userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0-3, kScreen_Width, 326/2-44)];
    UIImage *imageUserInfobg = [DWinUtils getBlurImage:imageViewBackGround2 withRect:CGRectMake(0, 0, kScreen_Width, 326/2-44) WithRadius:0.3];
    imageViewBackGround2.frame = CGRectMake(0, 0, kScreen_Width, 130);
    imageViewBackGround2.image = imageUserInfobg;
    [userInfoView addSubview:imageViewBackGround2];
    userInfoView.userInteractionEnabled = YES;
    [self.view addSubview:userInfoView];
    // 添加手势
    UITapGestureRecognizer *swipeGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    //[swipeGes setDirection:UISwipeGestureRecognizerDirectionDown];
    swipeGes.numberOfTapsRequired = 1;
    [userInfoView addGestureRecognizer:swipeGes];
    
    //添加好友btn
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(490/2, 112/2, 124/2, 48/2);
    [btn setBackgroundImage:[UIImage imageNamed:@"add_friend"] forState:UIControlStateNormal];
    [userInfoView addSubview:btn];
    
    // 用户头像
    UIImage *roundImage = [self makeRoundedImage:[UIImage imageNamed:@"user_headpic"] radius:55/2];
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 12, 55, 55)];
    headImageView.image = roundImage;
    headImageView.layer.cornerRadius = 55/2;
    headImageView.layer.masksToBounds = YES;
    headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [userInfoView addSubview:headImageView];
    // 用户姓名
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(75, 20, 100, 20)];
    userName.backgroundColor = [UIColor clearColor];
    userName.font = [UIFont fontWithName:HELVETICANUEU size:14];
    userName.textColor = [UIColor whiteColor];
    userName.text = @"Mike Jordon";
    [userInfoView addSubview:userName];
    // 用户性别
    UIImageView *imageView_sex = [[UIImageView alloc] initWithFrame:CGRectMake(75, 42,5, 8)];
    imageView_sex.image = [UIImage imageNamed:@"friendlist_female"];
    [userInfoView addSubview:imageView_sex];
    UILabel *label_sex = [DWinUtils createLabelForAutoSize:CGPointMake(84, 41) WithContent:@"Female" WithFontSize:10 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor colorWithRed:232.0/255 green:47.0/255 blue:227/255.0 alpha:1]];
    label_sex.backgroundColor = [UIColor clearColor];
    [userInfoView addSubview:label_sex];
    // 用户职业
    UILabel *label_Job = [[UILabel alloc] initWithFrame:CGRectMake(120, 42, 100, 10)];
    label_Job.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:10];
    label_Job.backgroundColor = [UIColor clearColor];
    label_Job.textColor = [UIColor whiteColor];
    label_Job.text = [NSString stringWithFormat:@"Job:%@",@"student"];
    [userInfoView addSubview:label_Job];
    // tabbar
    userTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, 82, 320, 50)];
    userTabBar.backgroundColor = [UIColor clearColor];
    [userInfoView addSubview:userTabBar];
    // 用户选项
    UIButton *btn_comment = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_comment.frame = CGRectMake(10, 9, 100, 30);
    [btn_comment setTitle:@"Her space" forState:UIControlStateNormal];
    
    [btn_comment setBackgroundImage:[UIImage imageNamed:@"friendlist_moment"] forState:UIControlStateNormal];
    [userTabBar addSubview:btn_comment];
    
    UIButton *btn_activity = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_activity.frame = CGRectMake(110, 9, 100, 30);
    [btn_activity setBackgroundImage:[UIImage imageNamed:@"friendlist_activity"] forState:UIControlStateNormal];
    [userTabBar addSubview:btn_activity];
    
    UIButton *btn_map = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_map.frame = CGRectMake(210, 9, 100, 30);
    [btn_map setTitle:@"CV" forState:UIControlStateNormal];
    [btn_map setBackgroundImage:[UIImage imageNamed:@"friendlist_map"] forState:UIControlStateNormal];
    [userTabBar addSubview:btn_map];
    // 上拉下拉标志
    UIImageView *imageArrowUpDown = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width/2, 0, 10, 5)];
    imageArrowUpDown.image = [UIImage imageNamed:@"friendlist_uparrow"];
    [userTabBar addSubview:imageArrowUpDown];
    // 设置tableview
    getViewHeight = getViewHeight+userInfoView.frame.size.height;
       // 设置转盘
   // [self createControlPanel];
  
    UIView *firstView =[[UIView alloc]initWithFrame:CGRectMake(10, (326-88+26)/2+12-5-1, 300, 86+65+2)];
    firstView.layer.cornerRadius=5;
    [firstView setBackgroundColor:RGBAlpha(1, 1, 1, 0.3)];
     
    [imageViewBackGround addSubview:firstView];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(1, 43, 298, 1)];
    img.image = [UIImage imageNamed:@"space_line.png"];
    [firstView addSubview:img];
    
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(1, 43+43+2, 298, 1)];
    img1.image = [UIImage imageNamed:@"space_line.png"];
    [firstView addSubview:img1];
    
    //view 上的字体
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 180, 43-16)];
    lab.text = @"Degree:";
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = [UIColor whiteColor];
    [firstView addSubview:lab];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(110, 8, 180, 43-16)];
    lab1.text = @"Degree:";
    lab1.textAlignment=2;
    lab1.backgroundColor = [UIColor clearColor];
    lab1.textColor = [UIColor whiteColor];
    [firstView addSubview:lab1];
    
    //view 上的字体
    UILabel *lab_univiercity = [[UILabel alloc]initWithFrame:CGRectMake(10, 51, 180, 43-16)];
    lab_univiercity.text = @"University:";
    lab_univiercity.backgroundColor = [UIColor clearColor];
    lab_univiercity.textColor = [UIColor whiteColor];
    [firstView addSubview:lab_univiercity];
    
    //view 上的字体
    UILabel *lab_univiercity1 = [[UILabel alloc]initWithFrame:CGRectMake(110, 51, 180, 43-16)];
    lab_univiercity1.text = @"University:";
    lab_univiercity1.backgroundColor = [UIColor clearColor];
    lab_univiercity1.textAlignment = 2;
    lab_univiercity1.textColor = [UIColor whiteColor];
    [firstView addSubview:lab_univiercity1];

    
    //view 上的字体
    UILabel *lab_skill = [[UILabel alloc]initWithFrame:CGRectMake(10, 86+17, 100, 30)];
    lab_skill.text = @"Skill:";
    lab_skill.backgroundColor = [UIColor clearColor];
    lab_skill.textColor = [UIColor whiteColor];
    [firstView addSubview:lab_skill];

  
    
    UIView *secondView =[[UIView alloc]initWithFrame:CGRectMake(10, (326-88+26)/2+12+85+65+13-6, 300, 390/2)];
    [secondView setBackgroundColor:RGBAlpha(1, 1, 1, 0.3)];
    secondView.userInteractionEnabled = YES;
     secondView.layer.cornerRadius=5;
    [imageViewBackGround addSubview:secondView];
    
    UIButton *second_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    second_btn.backgroundColor = [UIColor clearColor];
    [second_btn addTarget:self action:@selector(detail_txt) forControlEvents:UIControlEventTouchUpInside];
    second_btn.frame = CGRectMake(0, 0, 300, 75);
    [secondView addSubview:second_btn];
    
    UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(1, 75, 298, 1)];
    img2.image = [UIImage imageNamed:@"space_line.png"];
    
    [secondView addSubview:img2];
    
    //view2 上的字体
    UILabel *self_evaluation = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 30)];
    self_evaluation.text = @"Self-evaluation:";
    self_evaluation.backgroundColor = [UIColor clearColor];
    self_evaluation.textColor = [UIColor whiteColor];
    [secondView addSubview:self_evaluation];
   
    UILabel *self_evaluation_detail = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 280, 30)];
    self_evaluation_detail.text = @"124wrewtrgdfgjghfkuyluiy;hkj;jkl'jkll,jfhsewtawgzsdgserh123253464576589678087-";
    self_evaluation_detail.numberOfLines=2;
    [self_evaluation_detail sizeToFit];
    self_evaluation_detail.backgroundColor = [UIColor clearColor];
    self_evaluation_detail.textColor = [UIColor whiteColor];
    [secondView addSubview:self_evaluation_detail];
    
    
    //view2-2 上的字体
    UILabel *Portfolio = [[UILabel alloc]initWithFrame:CGRectMake(10, 77, 150, 30)];
    Portfolio.text = @"Portfolio:";
    Portfolio.backgroundColor = [UIColor clearColor];
    Portfolio.textColor = [UIColor whiteColor];
    [secondView addSubview:Portfolio];
    
    UIButton *empty_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    empty_btn.frame = CGRectMake(82, 13+75, 328/2, 188/2);
    [empty_btn setBackgroundImage:[UIImage imageNamed:@"empty_pic"] forState:UIControlStateNormal];
    [empty_btn addTarget:self action:@selector(empty) forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:empty_btn];
}
//pic
-(void)empty
{
    PriendPicViewController *friend_pic = [[PriendPicViewController alloc]init];
    [self.navigationController pushViewController:friend_pic animated:YES];
}
//详细说明
-(void)detail_txt
{
    
    FriendSpaceViewController*friend = [[FriendSpaceViewController alloc]init];
    [self.navigationController pushViewController:friend animated:YES];
}
-(void)setView
{



}
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"gestures work");
//    [UIView animateWithDuration:0.5 animations:^{
//        userInfoView.frame = CGRectMake(0, kTabAlreadyUpUserViewY, kScreen_Width, 130);
//        _mTableView.frame = CGRectMake(0, kScrollAlreadyUp, kScreen_Width, kScreen_Height);
//        
//    }];
}
-(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) radius;
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
