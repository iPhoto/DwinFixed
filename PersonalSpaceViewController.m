//
//  PersonalSpaceViewController.m
//  DWin1.0
//
//  Created by zang qilong on 13-10-12.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "PersonalSpaceViewController.h"
#import "MySpaceViewController.h"
#import "FriendSpaceViewController.h"
#import "PriendPicViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PersonalSpaceViewController ()

@end

@implementation PersonalSpaceViewController

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
    btn_left.frame = CGRectMake(0, 0, 27, 27);
    // [btn_left setBackgroundImage:[UIImage imageNamed:@"friendlist_nav_leftbar"] forState:UIControlStateNormal];
    UIImageView *imageviewleft = [[UIImageView alloc] initWithFrame:CGRectMake(9, 3, 19, 18)];
    imageviewleft.image = [UIImage imageNamed:@"friendlist_nav_leftbar"];
    [btn_left addSubview:imageviewleft];
    btn_left.tag=1;
    [btn_left addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:btn_left];
    self.navigationItem.leftBarButtonItem = leftBar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
	// Do any additional setup after loading the view.
}

- (void)setupView
{
    [self setNavgationBar];
    self.navigationItem.title = @"Bubble space";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 背景图
    UIImageView *imageViewBackGround  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    UIImageView *imageViewBackGround2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    
    imageViewBackGround.image  = [UIImage imageNamed:@"friendlistbg1"];
    imageViewBackGround2.image = [UIImage imageNamed:@"friendlistbg1"];
    
    // 设置高度
    getViewHeight = 0;
    
    // 用户信息
    
    userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0-3, kScreen_Width, 326/2-44)];
    UIImage *imageUserInfobg = [DWinUtils getBlurImage:imageViewBackGround2 withRect:CGRectMake(0, 0, kScreen_Width, 326/2-44) WithRadius:0.3];
    imageViewBackGround2.frame = CGRectMake(0, 0, kScreen_Width, 130);
    imageViewBackGround2.image = imageUserInfobg;
    
    [self.view    addSubview: imageViewBackGround];
    [userInfoView addSubview:imageViewBackGround2];
    
    
    userInfoView.userInteractionEnabled        = YES;
    imageViewBackGround.userInteractionEnabled = YES;
    [self.view addSubview:userInfoView];
    
    
    
    
    // 用户头像
    UIImage *roundImage = [self makeRoundedImage:[UIImage imageNamed:@"mike"] radius:55/2];
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
    imageView_sex.image = [UIImage imageNamed:@"friendlist_male"];
    [userInfoView addSubview:imageView_sex];
    UILabel *label_sex = [DWinUtils createLabelForAutoSize:CGPointMake(84, 41) WithContent:@"female" WithFontSize:10 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor colorWithRed:1 green:47.0/255 blue:227/255.0 alpha:1]];
    label_sex.backgroundColor = [UIColor clearColor];
    [userInfoView addSubview:label_sex];
    // 用户职业
    UILabel *label_Job = [[UILabel alloc] initWithFrame:CGRectMake(120, 42, 100, 10)];
    label_Job.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:10];
    label_Job.backgroundColor = [UIColor clearColor];
    label_Job.textColor = [UIColor whiteColor];
    label_Job.text = [NSString stringWithFormat:@"Job:%@",@"studentdddddd"];
    [userInfoView addSubview:label_Job];
    // tabbar
    userTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, 82, 320, 50)];
    userTabBar.backgroundColor = [UIColor clearColor];
    [userInfoView addSubview:userTabBar];
    
    
    
    //////////////////////////// 用户选项 //////////////
    UIButton *btn_comment = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn_activity = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn_map = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn_comment.frame  = CGRectMake(10, 9, 100, 30);
    btn_activity.frame = CGRectMake(110, 9, 100, 30);
    btn_map.frame      = CGRectMake(210, 9, 100, 30);
    
    [btn_comment setTitle:@"Her space" forState:UIControlStateNormal];
    [btn_map     setTitle:@"CV" forState:UIControlStateNormal];
    
    [btn_comment  setBackgroundImage:[UIImage imageNamed:@"friendlist_moment"] forState:UIControlStateNormal];
    [btn_activity setBackgroundImage:[UIImage imageNamed:@"friendlist_activity"] forState:UIControlStateNormal];
    [btn_map     setBackgroundImage:[UIImage imageNamed:@"friendlist_map"] forState:UIControlStateNormal];
    
//    [userTabBar addSubview:btn_comment];
//    [userTabBar addSubview:btn_activity];
//    [userTabBar addSubview:btn_map];
    
    
    
    // 上拉下拉标志
    UIImageView *imageArrowUpDown = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width/2, 0, 10, 5)];
    imageArrowUpDown.image = [UIImage imageNamed:@"friendlist_uparrow"];
    [userTabBar addSubview:imageArrowUpDown];
    // 设置tableview
    getViewHeight = getViewHeight+userInfoView.frame.size.height;
    // 设置转盘
    // [self createControlPanel];
    
    
    
    ///////////////////////////////////第一个view//////////////////////////////////////
    ///////////////////////////////////第二个view//////////////////////////////////////
    
    UIView *firstView  = [[UIView alloc]initWithFrame:CGRectMake(10, (326-88+26)/2+12-5-1, 300, 86+65+2)];
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(10, (326-88+26)/2+12+85+65+13-6, 300, 390/2)];
    firstView.layer.cornerRadius  = 5;
    secondView.layer.cornerRadius = 5;
    
    firstView .userInteractionEnabled = YES;
    secondView.userInteractionEnabled = YES;
    
    
    [firstView  setBackgroundColor:RGBAlpha(1, 1, 1, 0.3)];
    [secondView setBackgroundColor:RGBAlpha(1, 1, 1, 0.3)];
    
    [imageViewBackGround addSubview: firstView];
    [imageViewBackGround addSubview:secondView];
    
    //////////////////////////////////////两个上的分割线//////////////////////////////////
    UIImageView *img  = [[UIImageView alloc]initWithFrame:CGRectMake(1, 43, 298, 1)];
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(1, 43+43+2, 298, 1)];
    UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(1, 75, 298, 1)];
    
    img.image  = [UIImage imageNamed:@"space_line.png"];
    img1.image = [UIImage imageNamed:@"space_line.png"];
    img2.image = [UIImage imageNamed:@"space_line.png"];
    
    [firstView addSubview:img];
    [firstView addSubview:img1];
    [secondView addSubview:img2];
    
    
    
    /////////////////////////////////////view 上的字体/////////////////////////////////////
    UILabel *lab              = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 180, 43-16)];
    UILabel *lab1             = [[UILabel alloc]initWithFrame:CGRectMake(110, 8, 180, 43-16)];
    //
    UIButton *btn_godegree = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_godegree.frame = CGRectMake(280, 10, 9, 16);
    btn_godegree.contentMode = UIViewContentModeScaleAspectFit;
    [btn_godegree setBackgroundImage:[UIImage imageNamed:@"friendlist_rightarrow"] forState:UIControlStateNormal];
    [firstView addSubview:btn_godegree];
    //
    UILabel *lab_univiercity  = [[UILabel alloc]initWithFrame:CGRectMake(10, 51, 180, 43-16)];
    UILabel *lab_univiercity1 = [[UILabel alloc]initWithFrame:CGRectMake(110, 51, 180, 43-16)];
    UILabel *lab_skill        = [[UILabel alloc]initWithFrame:CGRectMake(10, 86+17, 100, 30)];
    
    lab.text              = @"Degree:";
    lab1.text              = @"Degree1";
    lab_univiercity .text = @"University:";
    lab_univiercity1.text = @"University1";
    lab_skill.text        = @"Skill:";
    
    lab.backgroundColor              = [UIColor clearColor];
    lab1.backgroundColor = [UIColor clearColor];
    lab_univiercity.backgroundColor  = [UIColor clearColor];
    lab_univiercity1.backgroundColor = [UIColor clearColor];
    lab_skill.backgroundColor        = [UIColor clearColor];
    
    lab.textColor              = [UIColor whiteColor];
    lab1.textColor             = [UIColor whiteColor];
    lab_univiercity1.textColor = [UIColor whiteColor];
    lab_univiercity.textColor  = [UIColor whiteColor];
    lab_skill.textColor        = [UIColor whiteColor];
    
    
    lab1.textAlignment=2;
    lab_univiercity1.textAlignment = 2;
    lab_univiercity1.textAlignment = 2;
    
    [firstView addSubview:lab];
   
    [firstView addSubview:lab_univiercity];
    [firstView addSubview:lab_univiercity1];
    [firstView addSubview:lab_skill];
    
    
    
    
    /////////////////////第二个view上个人说明详细信息下面的btn////////////////////////
    
    UIButton *second_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *empty_btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    
    second_btn.frame = CGRectMake(0, 0, 300, 75);
    empty_btn.frame  = CGRectMake(82, 13+75, 328/2, 188/2);
    
    [empty_btn setBackgroundImage:[UIImage imageNamed:@"empty_pic"] forState:UIControlStateNormal];
    
    second_btn.backgroundColor = [UIColor clearColor];
    [second_btn addTarget:self action:@selector(detail_txt) forControlEvents:UIControlEventTouchUpInside];
    [empty_btn  addTarget:self action:@selector(empty) forControlEvents:UIControlEventTouchUpInside];
    
    [secondView addSubview:second_btn];
    [secondView addSubview:empty_btn];
    
    
    
    ///////////////////////////view2 上的字体///////////////////////////////
    UILabel *self_evaluation        = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 30)];
    UILabel *self_evaluation_detail = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 280, 30)];
    UILabel *Portfolio              = [[UILabel alloc]initWithFrame:CGRectMake(10, 77, 150, 30)];
    self_evaluation_detail.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:12];
    self_evaluation.text        = @"Self-evaluation:";
    self_evaluation_detail.text = @"you are right";
    Portfolio.text              = @"Portfolio:";
    
    
    self_evaluation_detail.numberOfLines = 2;
    
    
    self_evaluation.backgroundColor        = [UIColor clearColor];
    self_evaluation_detail.backgroundColor = [UIColor clearColor];
    Portfolio.backgroundColor              = [UIColor clearColor];
    
    
    self_evaluation.textColor        = [UIColor whiteColor];
    self_evaluation_detail.textColor = [UIColor whiteColor];
    Portfolio.textColor              = [UIColor whiteColor];
    
    [self_evaluation_detail sizeToFit];
    
    [secondView addSubview:       self_evaluation];
    [secondView addSubview:self_evaluation_detail];
    [secondView addSubview:             Portfolio];
    
    
    //view2-2 上的字体
    
    

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
