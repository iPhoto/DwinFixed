//
//  MakeIdeaViewController.m
//  DWin1.0
//
//  Created by Mac on 13-10-13.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "MakeIdeaViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
#import "IdeasViewController.h"
@interface MakeIdeaViewController ()

@end

@implementation MakeIdeaViewController

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
    IdeasViewController*surcced=[[IdeasViewController alloc]init];
//    // SucViewController*surcced=[[SucViewController alloc]init];
    [self.navigationController pushViewController:surcced animated:YES];
    
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
    lab_title2.text = @"Media:";
    lab_title3.text = @"Introduce:";
    
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
    //[back_View addSubview:Partner];
    [back_View addSubview:Introduction];
    NSArray *arr = [[NSArray alloc]initWithObjects:@"Text",@"Photo",@"Audio",@"Video", nil];
  
    
    for (int a = 0; a<4; a++) {
     
   
    UIButton*btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
       // btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(10+70*a, 80+60, 70, 44);
    [btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 1000+a;
        
        [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"ideaunclic", @"png")] forState:UIControlStateNormal];
        if (a==0) {
            [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"Ideaclic", @"png")] forState:UIControlStateNormal];
        }
        [btn setTitle:[arr objectAtIndex:a] forState:UIControlStateNormal];
        [back_View addSubview:btn];
    }
}
-(void)choose:(UIButton*)sender

{
    
    if ( sender.tag - 1000 == 0 ) {
        [(UIButton*)[self.view viewWithTag:1000] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"Ideaclic", @"png")] forState:UIControlStateNormal ];
        [(UIButton*)[self.view viewWithTag:1001] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"ideaunclic", @"png")] forState:UIControlStateNormal ];
        [(UIButton*)[self.view viewWithTag:1002] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"ideaunclic", @"png")] forState:UIControlStateNormal ];
        [(UIButton*)[self.view viewWithTag:1003] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"ideaunclic", @"png")] forState:UIControlStateNormal ];
    }
    if ( sender.tag - 1000 == 1 ) {
        [(UIButton*)[self.view viewWithTag:1000] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"ideaunclic", @"png")] forState:UIControlStateNormal ];
        [(UIButton*)[self.view viewWithTag:1001] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"Ideaclic", @"png")] forState:UIControlStateNormal ];
        [(UIButton*)[self.view viewWithTag:1002] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"ideaunclic", @"png")] forState:UIControlStateNormal ];
        [(UIButton*)[self.view viewWithTag:1003] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"ideaunclic", @"png")] forState:UIControlStateNormal ];
    }
    if ( sender.tag - 1000 == 2 ) {
        [(UIButton*)[self.view viewWithTag:1000] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"ideaunclic", @"png")] forState:UIControlStateNormal ];
        [(UIButton*)[self.view viewWithTag:1001] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"ideaunclic", @"png")] forState:UIControlStateNormal ];
        [(UIButton*)[self.view viewWithTag:1002] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"Ideaclic", @"png")] forState:UIControlStateNormal ];
        [(UIButton*)[self.view viewWithTag:1003] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"ideaunclic", @"png")] forState:UIControlStateNormal ];
    }
    if ( sender.tag - 1000 == 3 ) {
        [(UIButton*)[self.view viewWithTag:1000] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"ideaunclic", @"png")] forState:UIControlStateNormal ];
        [(UIButton*)[self.view viewWithTag:1001] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"ideaunclic", @"png")] forState:UIControlStateNormal ];
        [(UIButton*)[self.view viewWithTag:1002] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"ideaunclic", @"png")] forState:UIControlStateNormal ];
        [(UIButton*)[self.view viewWithTag:1003] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"Ideaclic", @"png")] forState:UIControlStateNormal ];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
