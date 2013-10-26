//
//  ActivityViewController.m
//  DWin1.0
//
//  Created by Mac on 13-10-8.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "ActivityViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
#import "ActivityProjrctViewController.h"
#import "MakeIdeaViewController.h"
#import "MakejobViewController.h"
#import "MakeClassfiedViewController.h"
@interface ActivityViewController ()

@end

@implementation ActivityViewController

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
	self.view.backgroundColor=[UIColor whiteColor];
    
    // 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    imageViewBackGround.userInteractionEnabled = YES;
    [self.view addSubview:imageViewBackGround];
    
    [self setNavgationBar];
	self.navigationItem.title = @"Activity";
    
    UIView * back_View = [[UIView alloc]initWithFrame:CGRectMake(10, 30, 300, 574/2)];
   
     back_View.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
     back_View.layer.cornerRadius = 5;
     [imageViewBackGround addSubview:back_View];
    
    /////////////////////////////////accessview///////////////////////////////////
    
    UIImageView *accessview0 = [[UIImageView alloc]initWithFrame:CGRectMake(564/2, 44+22, 9, 16)];
    UIImageView *accessview1 = [[UIImageView alloc]initWithFrame:CGRectMake(564/2, 44+22+60, 9, 16)];
    UIImageView *accessview2 = [[UIImageView alloc]initWithFrame:CGRectMake(564/2, 44+22+60+60, 9, 16)];
    UIImageView *accessview3 = [[UIImageView alloc]initWithFrame:CGRectMake(564/2, 44+22+60+60+60, 9, 16)];
    
    accessview0.image = [UIImage imageNamed:@"right-arrow"];
    accessview1.image = [UIImage imageNamed:@"right-arrow"];
    accessview2.image = [UIImage imageNamed:@"right-arrow"];
    accessview3.image = [UIImage imageNamed:@"right-arrow"];
    
    [back_View addSubview:accessview0];
    [back_View addSubview:accessview1];
    [back_View addSubview:accessview2];
    [back_View addSubview:accessview3];

    
    /////////////////////////////////titleview line//////////////////////////////////
    
    UIImageView *bacView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    UIImageView *linview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 82+22, 300, 1)];
    UIImageView *linview1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 82+60+22, 300, 1)];
    UIImageView *linview2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 82+120+22, 300, 1)];
    
    bacView .image = [UIImage imageNamed:@"activity_aph_"];
    linview .image = [UIImage imageNamed:@"activity_line"];
    linview1.image = [UIImage imageNamed:@"activity_line"];
    linview2.image = [UIImage imageNamed:@"activity_line"];
    
    [back_View addSubview: bacView];
    [back_View addSubview: linview];
    [back_View addSubview:linview1];
    [back_View addSubview:linview2];
    
    ////////////////////////////////////////////tag image//////////////////////////////
    
    UIImageView *tagimg0 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 51, 46, 46)];
    UIImageView *tagimg1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 51+60, 46, 46)];
    UIImageView *tagimg2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 51+60+60, 46, 46)];
    UIImageView *tagimg3 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 51+60+60+60, 46, 46)];
    UIImageView *tagimg4 = [[UIImageView alloc]initWithFrame:CGRectMake(10+150-14, 51+60+60+60+142, 28, 8)];
    
    tagimg0.image = [UIImage imageNamed:@"activity_light"];
    tagimg1.image = [UIImage imageNamed:@"activity_computer"];
    tagimg2.image = [UIImage imageNamed:@"activity_comror"];
    tagimg3.image = [UIImage imageNamed:@"activity_class"];
    tagimg4.image = [UIImage imageNamed:@"activity_choose1"];
    
    [back_View addSubview:tagimg0];
    [back_View addSubview:tagimg1];
    [back_View addSubview:tagimg2];
    [back_View addSubview:tagimg3];
    [imageViewBackGround addSubview:tagimg4];
    
    
    
   //////////////////////////////lines name///////////////////////////////
    
    
    UILabel *lab_title0 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    UILabel *lab_title1 = [[UILabel alloc]initWithFrame:CGRectMake(66, 0+44, 300, 60)];
    UILabel *lab_title2 = [[UILabel alloc]initWithFrame:CGRectMake(66, 0+44+60, 300, 60)];
    UILabel *lab_title3 = [[UILabel alloc]initWithFrame:CGRectMake(66, 0+44+60+60, 300, 60)];
    UILabel *lab_title4 = [[UILabel alloc]initWithFrame:CGRectMake(66, 0+44+60+60+60, 300, 60)];
    
    lab_title0.text = @"Step1: Chose Activity";
    lab_title1.text = @"Idea";
    lab_title2.text = @"Project";
    lab_title3.text = @"Job";
    lab_title4.text = @"Classifilds";
    
    lab_title0.backgroundColor = [UIColor clearColor];
    lab_title1.backgroundColor = [UIColor clearColor];
    lab_title2.backgroundColor = [UIColor clearColor];
    lab_title3.backgroundColor = [UIColor clearColor];
    lab_title4.backgroundColor = [UIColor clearColor];
    
    lab_title0.textAlignment = 1;
    lab_title0.textColor = [UIColor whiteColor];
    
    
    [bacView addSubview:lab_title0];
    [bacView addSubview:lab_title1];
    [bacView addSubview:lab_title2];
    [bacView addSubview:lab_title3];
    [bacView addSubview:lab_title4];
    
    for (int a=0; a<4; a++) {
        
 
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
              btn.tag = 300+a;
              btn.frame = CGRectMake(0, 44+60*a, 300, 60);
              [btn addTarget:self
                action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
              [back_View addSubview:btn];
        
    }
    
}
-(void)change:(UIButton*)sender

{
    if (sender.tag-300==0)
    {
        NSLog(@"1");
        MakeIdeaViewController*ma=[[MakeIdeaViewController alloc]init];
        [self.navigationController pushViewController:ma animated:YES];
    }
    if (sender.tag-300==1) {
         NSLog(@"2");
        ActivityProjrctViewController*ac=[[ActivityProjrctViewController alloc]init];
        [self.navigationController pushViewController:ac animated:YES];
    }
    if (sender.tag-300==2) {
        NSLog(@"3");
        MakejobViewController*job=[[MakejobViewController alloc]init];
        [self.navigationController pushViewController:job animated:YES];
    }
    if (sender.tag-300==3) {
        NSLog(@"4");
        MakeClassfiedViewController *make = [[MakeClassfiedViewController alloc]init];
        [self.navigationController pushViewController:make animated:YES];
    }



}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
