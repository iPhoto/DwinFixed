//
//  MakejobSecondViewController.m
//  DWin1.0
//
//  Created by Mac on 13-10-13.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "MakejobSecondViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
@interface MakejobSecondViewController ()

@end

@implementation MakejobSecondViewController

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
    [title removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//////////////导航上的头像文字//////////////
    
    title= [[UIView alloc]initWithFrame:CGRectMake(100, 0, 120, 44)];
    
    [self.navigationController.view addSubview:title];
    
    UIImageView*imag = [[UIImageView alloc]initWithFrame:CGRectMake(60-34-2, 5, 34, 34)];
    imag.image = [UIImage imageWithContentsOfFile:FileS(@"acti_small", @"png")];
    [title addSubview:imag];
    UILabel*lab = [[UILabel alloc]initWithFrame:CGRectMake(60+2, 5, 34, 34)];
    lab.text = @"Lily";
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = [UIColor whiteColor];
    [title addSubview:lab];
    
    scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 500)];
    scr.backgroundColor = [UIColor whiteColor];
    scr.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    scr.backgroundColor = [UIColor clearColor];
    scr.contentSize = CGSizeMake(320, 1444);
    // 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    imageViewBackGround.userInteractionEnabled = YES;
    [self.view addSubview:imageViewBackGround];
    
    [self setNavgationBar];
	self.navigationItem.title = @"";

    [imageViewBackGround addSubview:scr];
    
    //////////////////////back_view 1////////////////////
    
    
    UIView * back_View = [[UIView alloc]initWithFrame:CGRectMake(10, 30, 300, 44+69+76)];
    
    back_View.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    back_View.layer.cornerRadius = 5;
    [scr  addSubview:back_View];
    
    /////////////////////////////////titleview line/
    
    UIImageView *bacView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    UIImageView *linview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44+69, 300, 1)];
    UIImageView *linview1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44+69+69, 300, 1)];
    bacView.userInteractionEnabled = YES;
    
    bacView .image = [UIImage imageNamed:@"activity_aph_"];
    linview .image = [UIImage imageNamed:@"activity_line"];
    linview1.image = [UIImage imageNamed:@"activity_line"];
    
    [back_View addSubview: bacView];
    [back_View addSubview: linview];
    // [back_View addSubview:linview1];
    
    
    
    /////////////////edit btn////////////////////
    
    
    UIButton *edit_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    edit_btn.frame= CGRectMake(300-44, 0, 44, 44);
    [edit_btn setTitle:@"edit" forState:UIControlStateNormal];
    [edit_btn
     setTitleColor:RGB(177, 255, 199) forState:UIControlStateNormal    ];
    [edit_btn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    [back_View addSubview:edit_btn];
    
    //////////////////////////////lines name///////////////////////////////
    
    
    UILabel *lab_title0 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 44)];
    UILabel *lab_title1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0+32, 300, 60)];
    lab_title2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 0+50+69, 250, 60)];
    
    
    lab_title0.text = @"Sell:bike";
    lab_title1.text = @"Price:";
    lab_title2.text = @"qwrewqtvwerburtyi,yuip.uio[sdfgdfhga/iop";
    
    [lab_title2 setEnabled:NO];
    lab_title0.backgroundColor = [UIColor clearColor];
    lab_title1.backgroundColor = [UIColor clearColor];
    lab_title2.backgroundColor = [UIColor clearColor];
    
    
    lab_title0.textColor = [UIColor whiteColor];

    [lab_title2 sizeToFit];
    //[lab_title2 setEnabled:NO];
    [back_View addSubview:lab_title0];
    [back_View addSubview:lab_title1];
    [back_View addSubview:lab_title2];
    
    
    /////////////////////////////////textfild///////////////////////////////
    
    topic =[[UITextField alloc]initWithFrame:CGRectMake(10, 80, 300, 44)];
    Partner =[[UITextField alloc]initWithFrame:CGRectMake(10, 80+69, 300, 44)];
    
   
    topic.text = @"2000RMB";
    [topic setEnabled:NO];
    Partner.placeholder = @"Describe the partner you need";
    //[topic setEnabled:NO];
    //[Partner setEnabled:NO];
    [back_View addSubview:topic];
    //[back_View addSubview:Partner];
    
 
    
    
    
    
    //////////////////////////view2
    
    back_View2 = [[UIView alloc]initWithFrame:CGRectMake(10, 30+44+69+76+10, 300, 44+69+76)];
    
    
    back_View2.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    back_View2.layer.cornerRadius = 5;
    [scr  addSubview:back_View2];
    
    UIImageView *bacView2  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    bacView2.userInteractionEnabled = YES;
    bacView2.image = [UIImage imageNamed:@"activity_aph_"];
    [back_View2 addSubview:bacView2];
    
    
    
    UILabel *lab_title22 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 44)];
    lab_title22.textColor = [UIColor whiteColor];
    lab_title22.text = @"Visitor";
    lab_title22.backgroundColor = [UIColor clearColor];
    [back_View2 addSubview:lab_title22];
    
    ////////////////bacview2 上的btn
    
    for (int a = 0; a<2; a++)
    {
        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag= 9000+a;
        if (a==0) {
            btn.frame = CGRectMake(80, 14, 16, 8);
            [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_clasfied_up", @"png")] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(up) forControlEvents:UIControlEventTouchUpInside];
        }
        //        if (a==3) {
        //            btn.frame = CGRectMake(150-22, 0, 44, 44);
        //            [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_classfied_unlock", @"png")] forState:UIControlStateNormal];
        //             [btn addTarget:self action:@selector(lock) forControlEvents:UIControlEventTouchUpInside];
        //        }
        //
        [bacView2 addSubview:btn
         ];
    }
    for (int a = 0; a<4; a++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(16+a*74, 51, 46, 46);
        btn.tag= 100+a;
        [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"bighead", @"png")] forState:UIControlStateNormal];
        [back_View2 addSubview:btn];
    }
    for (int a = 0; a<4; a++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(16+a*74, 51+46+20, 46, 46);
        [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"bighead", @"png")] forState:UIControlStateNormal];
        btn.tag= 200+a;
        [back_View2 addSubview:btn];
    }
    for (int a = 0; a<4; a++) {
        UILabel *lab = [[UILabel  alloc]initWithFrame:CGRectMake(16+a*74, 51+46, 46, 20)];
        lab.tag= 300+a;
        lab.text = @"Marry";
        lab.backgroundColor = [UIColor clearColor];
        [back_View2 addSubview:lab];
    }
    for (int a = 0; a<4; a++) {
        
        UILabel *lab = [[UILabel  alloc]initWithFrame:CGRectMake(16+a*74, 51+46+20+46, 46, 20)];
        lab .tag= 400+a;
        lab.text = @"Join";
        lab.backgroundColor = [UIColor clearColor];
        [back_View2 addSubview:lab];
    }
    /////////////////edit btn////////////////////
    
    
    UIButton *chat_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    chat_btn.frame= CGRectMake(300-44, 0, 44, 44);
    [chat_btn setTitle:@"Chat" forState:UIControlStateNormal];
    [chat_btn
     setTitleColor:RGB(177, 255, 199) forState:UIControlStateNormal    ];
    [chat_btn addTarget:self action:@selector(chat) forControlEvents:UIControlEventTouchUpInside];
    [back_View2 addSubview:chat_btn];
    
}
-(void)edit
{

    [topic setEnabled:YES];
    [lab_title2 setEnabled:YES];

}
-(void)chat
{
    NSLog(@"chat");
    //////////////////////////view2
    
    back_View3 = [[UIView alloc]initWithFrame:CGRectMake(10, 30+44+69+76+10+back_View2.frame.size.height+10, 300, 44+69+76)];
    
    
    back_View3.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    back_View3.layer.cornerRadius = 5;
    [scr  addSubview:back_View3];
    
    UIImageView *bacView2  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    bacView2.userInteractionEnabled = YES;
    bacView2.image = [UIImage imageNamed:@"activity_aph_"];
    [back_View3 addSubview:bacView2];
    
    
    
    UILabel *lab_title22 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 44)];
    lab_title22.textColor = [UIColor whiteColor];
    lab_title22.text = @"Chat";
    lab_title22.backgroundColor = [UIColor clearColor];
    [back_View3 addSubview:lab_title22];
    
    ////////////////bacview2 上的btn
    
    for (int a = 0; a<2; a++)
    {
        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag= 9000+a;
        if (a==0) {
            btn.frame = CGRectMake(80, 14, 16, 8);
            [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_clasfied_up", @"png")] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(upup) forControlEvents:UIControlEventTouchUpInside];
        }
        //        if (a==3) {
        //            btn.frame = CGRectMake(150-22, 0, 44, 44);
        //            [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_classfied_unlock", @"png")] forState:UIControlStateNormal];
        //             [btn addTarget:self action:@selector(lock) forControlEvents:UIControlEventTouchUpInside];
        //        }
        //
        [bacView2 addSubview:btn
         ];
    }
    
    /////////////////edit btn////////////////////
    
    
    UIButton *reply_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    reply_btn.frame= CGRectMake(300-55, 0, 55, 44);
    [reply_btn setTitle:@"Reply" forState:UIControlStateNormal];
    [reply_btn
     setTitleColor:RGB(177, 255, 199) forState:UIControlStateNormal    ];
    [reply_btn addTarget:self action:@selector(reply) forControlEvents:UIControlEventTouchUpInside];
    [back_View3 addSubview:reply_btn];
    
    
}
-(void)reply
{
    
}
-(void)upup
{
    if (flagUp3==NO) {
        
        [UIView animateWithDuration:1 animations:^{
            back_View3.frame = CGRectMake(10, 30+44+69+76+10+10+back_View2.frame.size.height, 300, 44);
            
        }];
        flagUp3=YES;
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            back_View3.frame = CGRectMake(10, 30+44+69+76+10+44+69+76+10, 300, 44+69+76);
        }];
        flagUp3= NO;
        
    }
    
    
    
}
-(void)up
{
    if (flagUp==NO) {
        [[back_View2 viewWithTag:100] setHidden:YES];
        [[back_View2 viewWithTag:101] setHidden:YES];
        [[back_View2 viewWithTag:102] setHidden:YES];
        [[back_View2 viewWithTag:103] setHidden:YES];
        [[back_View2 viewWithTag:200] setHidden:YES];
        [[back_View2 viewWithTag:201] setHidden:YES];
        [[back_View2 viewWithTag:202] setHidden:YES];
        [[back_View2 viewWithTag:203] setHidden:YES];
        [[back_View2 viewWithTag:300] setHidden:YES];
        [[back_View2 viewWithTag:301] setHidden:YES];
        [[back_View2 viewWithTag:302] setHidden:YES];
        [[back_View2 viewWithTag:303] setHidden:YES];
        [[back_View2 viewWithTag:400] setHidden:YES];
        [[back_View2 viewWithTag:401] setHidden:YES];
        [[back_View2 viewWithTag:402] setHidden:YES];
        [[back_View2 viewWithTag:403] setHidden:YES];
        [UIView animateWithDuration:0.5 animations:^{
            back_View2.frame = CGRectMake(10, 30+44+69+76+10, 300, 44);
            back_View3.frame = CGRectMake(10, 30+44+69+76+10+10+back_View2.frame.size.height, 300, 44+69+76);
        }];
        flagUp=YES;
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            back_View2.frame = CGRectMake(10, 30+44+69+76+10, 300, 44+69+76);
        } completion:^(BOOL finished) {
            [[back_View2 viewWithTag:100] setHidden:NO];
            [[back_View2 viewWithTag:101] setHidden:NO];
            [[back_View2 viewWithTag:102] setHidden:NO];
            [[back_View2 viewWithTag:103] setHidden:NO];
            [[back_View2 viewWithTag:200] setHidden:NO];
            [[back_View2 viewWithTag:201] setHidden:NO];
            [[back_View2 viewWithTag:202] setHidden:NO];
            [[back_View2 viewWithTag:203] setHidden:NO];
            [[back_View2 viewWithTag:300] setHidden:NO];
            [[back_View2 viewWithTag:301] setHidden:NO];
            [[back_View2 viewWithTag:302] setHidden:NO];
            [[back_View2 viewWithTag:303] setHidden:NO];
            [[back_View2 viewWithTag:400] setHidden:NO];
            [[back_View2 viewWithTag:401] setHidden:NO];
            [[back_View2 viewWithTag:402] setHidden:NO];
            [[back_View2 viewWithTag:403] setHidden:NO];

        }];
        flagUp= NO;
        back_View3.frame = CGRectMake(10, 30+44+69+76+10+44+69+76+10, 300, 44+69+76);
         
    }
    
    
}
-(void)lock
{
    if (flaglock ==NO) {
        [(UIButton *)[self.view viewWithTag:9001] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_classfied_lock", @"png")] forState:UIControlStateNormal];
        flaglock=YES;
    }
    else{
        [(UIButton *)[self.view viewWithTag:9001] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_classfied_unlock", @"png")] forState:UIControlStateNormal];
        flaglock=NO;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
