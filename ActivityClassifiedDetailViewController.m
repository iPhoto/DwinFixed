//
//  ActivityClassifiedDetailViewController.m
//  DWin1.0
//
//  Created by Mac on 13-10-13.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "ActivityClassifiedDetailViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
@interface ActivityClassifiedDetailViewController ()

@end

@implementation ActivityClassifiedDetailViewController

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
   }
-(void)toggleLeftView
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)edit
{

    


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
	self.navigationItem.title = @"";
       
    
    
    
  UIScrollView*  scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 500)];
    scr.backgroundColor = [UIColor whiteColor];
    scr.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    scr.backgroundColor = [UIColor clearColor];
    scr.contentSize = CGSizeMake(320, 1444);
    
    [imageViewBackGround addSubview:scr];
    
    
    UIView * back_View = [[UIView alloc]initWithFrame:CGRectMake(10, 30, 300, 44+69+76)];
    
    back_View.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    back_View.layer.cornerRadius = 5;
    [scr  addSubview:back_View];

    /////////////////////////////////titleview line//////////////////////////////////
    
    UIImageView *bacView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    UIImageView *linview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44+69, 300, 1)];
    UIImageView *linview1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44+69+69, 300, 1)];
    
    bacView .image = [UIImage imageNamed:@"activity_aph_"];
    linview .image = [UIImage imageNamed:@"activity_line"];
    linview1.image = [UIImage imageNamed:@"activity_line"];
    
    [back_View addSubview: bacView];
    [back_View addSubview: linview];
   // [back_View addSubview:linview1];
    
    //////////////////////////////lines name///////////////////////////////
    
    
    UILabel *lab_title0 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 44)];
    UILabel *lab_title1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0+32, 300, 60)];
    lab_title2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 0+50+69, 300, 60)];
    UILabel *lab_title3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0+32+69+69, 300, 60)];
    
    lab_title0.text = @"Step2: Make a project";
    lab_title1.text = @"Salary:";
    lab_title2.placeholder = @"Partner:";
    lab_title3.text = @"Introduction:";
    
    lab_title0.backgroundColor = [UIColor clearColor];
    lab_title1.backgroundColor = [UIColor clearColor];
    lab_title2.backgroundColor = [UIColor clearColor];
    lab_title3.backgroundColor = [UIColor clearColor];
    
    lab_title2.delegate = self;
    lab_title0.textColor = [UIColor whiteColor];
    
    //[lab_title2 setEnabled:NO];
    [back_View addSubview:lab_title0];
    [back_View addSubview:lab_title1];
    [back_View addSubview:lab_title2];
   // [back_View addSubview:lab_title3];
    
    
    
    /////////////////////////////////textfild///////////////////////////////
    
    topic =[[UITextField alloc]initWithFrame:CGRectMake(10, 80, 300, 44)];
    Partner =[[UITextField alloc]initWithFrame:CGRectMake(10, 80+69, 300, 44)];
        
    topic.delegate = self;
    Partner.delegate =self;
    topic.placeholder = @"Obligatory";
    Partner.placeholder = @"Describe the partner you need";
        //[topic setEnabled:NO];
    //[Partner setEnabled:NO];
    [back_View addSubview:topic];
    [back_View addSubview:Partner];
       
    
    /////////////////edit btn////////////////////
    
    
    UIButton *edit_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    edit_btn.frame= CGRectMake(300-44, 0, 44, 44);
    [edit_btn setTitle:@"Edit" forState:UIControlStateNormal];
    [edit_btn
     setTitleColor:RGB(177, 255, 199) forState:UIControlStateNormal    ];
    [edit_btn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    [back_View addSubview:edit_btn];

    UIView * back_View2 = [[UIView alloc]initWithFrame:CGRectMake(10, 30+44+69+76+10, 300, 44+69+76)];
    
    back_View2.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    back_View2.layer.cornerRadius = 5;
    [scr  addSubview:back_View2];
    
     UIImageView *bacView2  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
     bacView2.image = [UIImage imageNamed:@"activity_aph_"];
    [back_View2 addSubview:bacView2];
    
    
    for (int a = 0; a<4; a++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(16+a*74, 51, 46, 46);
        [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"bighead", @"png")] forState:UIControlStateNormal];
        [back_View2 addSubview:btn];
       }
    
    for (int a = 0; a<4; a++) {
        //UILabel *lab = [[UILabel ]];
    }

}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
