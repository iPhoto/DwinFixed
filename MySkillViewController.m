//
//  MySkillViewController.m
//  DWin1.0
//
//  Created by Mac on 13-9-29.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "MySkillViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
@interface MySkillViewController ()

@end

@implementation MySkillViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        flag=0;
           }
    return self;
}

///////////////////////////////// 导航条左you按钮///////////////////////////////
- (void)setNavgationBar
{
//    ////////////////////////////////////点击屏幕任何地方回收键盘/////////////////////////////////////////
//    
//    UIControl *m_control = [[UIControl alloc]initWithFrame:self.view.frame];
//    [m_control addTarget:self action:@selector(keyboardReturn)
//        forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:m_control];

    UIButton *btn_left  = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
    
        btn_left.frame  = CGRectMake(0, 0, 56, 18);
        btn_right.frame = CGRectMake(0, 0, 92/2, 44);
          btn_left.tag  = 1;
          btn_right.tag = 2;
    
    [btn_left  setBackgroundImage:[UIImage imageNamed:@"moment_backBtn"] forState:UIControlStateNormal];
    [btn_right setBackgroundImage:[UIImage imageNamed:@"done"] forState:UIControlStateNormal];
    [btn_left  addTarget:self action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    [btn_right addTarget:self action:@selector(navBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *leftBar  = [[UIBarButtonItem alloc] initWithCustomView:btn_left];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
    
    self.navigationItem.leftBarButtonItem  = leftBar;
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
    
    self.navigationItem.title = @"Skill";
    
    [self setNavgationBar];
    
    
    // 用户信息
    imageViewBackGround2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    imageViewBackGround2.userInteractionEnabled = YES;
    imageViewBackGround2.image = [UIImage imageNamed:@"friendlistbg1"];
    [self.view addSubview:imageViewBackGround2];
    
    
    
    lastView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, 44*5)];
    lastView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    lastView.layer.cornerRadius=5;
    [imageViewBackGround2 addSubview:lastView];
    
    
    
    ///////////////view 上的线条 //////////////////////////////
    
    UIImageView *line00 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, 300, 1)];
    UIImageView *line   = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44+44, 300, 1)];
    UIImageView *line1  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44+42+44, 300, 1)];
    UIImageView *line2  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44+42+42+44, 300, 1)];
    
    line00.image = [UIImage imageNamed: @"_line"];
    line.image   = [UIImage imageNamed: @"_line"];
    line1.image  = [UIImage imageNamed: @"_line"];
    line2.image  = [UIImage imageNamed: @"_line"];
    
    [lastView addSubview:line00];
    [lastView addSubview:line];
    [lastView addSubview:line1];
    [lastView addSubview:line2];
    
    
    /////////////////////////////skill -lab/////////////////////////////////////////
    
    UILabel *more_lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 6, 50, 30)];
    UILabel *more_lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 44+6, 50, 30)];
    UILabel *more_lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 44+44+6, 50, 30)];
    UILabel *more_lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 44+44+6+44, 50, 30)];
    UILabel *more_lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 44+44+6+44+44, 50, 30)];
    
    more_lab1.text = @"1.";
    more_lab2.text = @"2.";
    more_lab3.text = @"3.";
    more_lab4.text = @"4.";
    more_lab5.text = @"5.";
    
    more_lab1.backgroundColor = [UIColor clearColor];
    more_lab2.backgroundColor = [UIColor clearColor];
    more_lab3.backgroundColor = [UIColor clearColor];
    more_lab4.backgroundColor = [UIColor clearColor];
    more_lab5.backgroundColor = [UIColor clearColor];
    
    [lastView addSubview:more_lab1];
    [lastView addSubview:more_lab2];
    [lastView addSubview:more_lab3];
    [lastView addSubview:more_lab4];
    [lastView addSubview:more_lab5];
    
    

    ////////////////////////////////sKill textfiled/////////////////////////////////////
    
    more_texet1 = [[UITextField alloc]initWithFrame:CGRectMake(30, 10, 200, 30)];
    more_texet2 = [[UITextField alloc]initWithFrame:CGRectMake(30, 44+4+6, 200, 30)];
    more_texet3 = [[UITextField alloc]initWithFrame:CGRectMake(30, 44+44+10, 200, 30)];
    more_texet4 = [[UITextField alloc]initWithFrame:CGRectMake(30, 44+44+44+10, 200, 30)];
    more_texet5 = [[UITextField alloc]initWithFrame:CGRectMake(30, 44+44+44+44+10, 200, 30)];
    
    more_texet1.text = @"1.";
    more_texet2.text = @"1.";
    more_texet3.text = @"1.";
    more_texet4.text = @"1.";
    more_texet5.text = @"1.";
    
    more_texet1.tag = 4000;
    more_texet1.tag = 4001;
    more_texet1.tag = 4002;
    more_texet1.tag = 4003;
    more_texet1.tag = 4004;
    
    more_texet1.delegate = self;
    more_texet2.delegate = self;
    more_texet3.delegate = self;
    more_texet4.delegate = self;
    more_texet5.delegate = self;
    
    more_texet1.backgroundColor = [UIColor clearColor];
    more_texet2.backgroundColor = [UIColor clearColor];
    more_texet3.backgroundColor = [UIColor clearColor];
    more_texet4.backgroundColor = [UIColor clearColor];
    more_texet5.backgroundColor = [UIColor clearColor];
    
    [lastView addSubview:more_texet1];
    [lastView addSubview:more_texet2];
    [lastView addSubview:more_texet3];
    [lastView addSubview:more_texet4];
    [lastView addSubview:more_texet5];
    
    
    
	
    ///////////////////////////////选择颜色的背景view///////////////////////////
    
    choose_colorview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, 320, 432/2)];
    choose_colorview.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    [imageViewBackGround2 addSubview:choose_colorview];
    
    clicarr=[[NSArray alloc]initWithObjects:@"red",@"zise",@"zongse",@"yellow", nil];
    uncilcarr=[[NSArray alloc]initWithObjects:@"junlv",@"green",@"tianlan",@"black", nil];

    
    
    //////////////////////////////下面供选择颜色的按钮1////////////////////////////////////////
    for (int j=0; j<4; j++) {
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame= CGRectMake(16+76*j, 32, 60, 60);
        btn.tag=2000+j;
        [btn setBackgroundImage:[UIImage imageNamed: [clicarr objectAtIndex:j]] forState:UIControlStateNormal];
       
        [btn addTarget:self action:@selector(changecolor1: ) forControlEvents:UIControlEventTouchUpInside];
        [choose_colorview addSubview:btn];

        
    }
    
    
    ///////////////////////////////下面供选择颜色的按钮2///////////////////////////////////////
    for (int j=0; j<4; j++) {
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame= CGRectMake(16+76*j, 60+64, 60, 60);
        btn.tag=3000+j;
        [btn setBackgroundImage:[UIImage imageNamed: [uncilcarr objectAtIndex:j]] forState:UIControlStateNormal];
     
   
        [btn addTarget:self action:@selector(changecolor2: ) forControlEvents:UIControlEventTouchUpInside];
        [choose_colorview addSubview:btn];
        
        
    }

    
    ///////////////////////////////txtfiled 后面的选择按钮///////////////////////////////////
    for (int i =0; i <5; i++)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
  
        
        btn.frame= CGRectMake(260, 6+i*44, 30, 30);
        btn.tag=1000+i;
        btn.layer.cornerRadius=5;
        if (i==0)
        {
            btn.backgroundColor = RGB(0, 160, 233);
            
        }
        
        if (i==1)
        {
            
               btn.backgroundColor = RGB(0, 255, 0);
        }

        
        if (i==2) {
            
               btn.backgroundColor = RGB(243, 151, 0);
        }

        
        if (i==3)
        {
            
               btn.backgroundColor = RGB(164, 0 , 91);
        }

        if (i==4)
        {
           
                btn.backgroundColor = RGB(255, 0, 00 );
        }

       
        [btn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        [lastView addSubview:btn];
        
    }
    


}


/////////////////////////////////////点击屏幕任何地方回收键盘//////////////////////////////////////////

- (void) keyboardReturn
{
    [more_texet1 resignFirstResponder];
    [more_texet2 resignFirstResponder];
    [more_texet3 resignFirstResponder];
    [more_texet4 resignFirstResponder];
    [more_texet5 resignFirstResponder];
}


 /////////////////////////////// //txtfiled 后面的选择按钮单击事件//////////////////////////////////

-(void)change:(UIButton *)sender
{

    if (sender.tag-1000==0)
    {
        [[[self.view viewWithTag:1000] layer] setBorderWidth:2];
        [[self.view viewWithTag:1000].layer setBorderColor:[UIColor whiteColor].CGColor];
        [UIView animateWithDuration:2 animations:^{
            choose_colorview.frame = CGRectMake(0,self.view.frame.size.height-432/2-100+44+12+44, 320, 432/2);
        }];
        [self keyboardReturn];
        flag=1000;
    }
    if (sender.tag-1000==1)
    {
        [[[self.view viewWithTag:1001] layer] setBorderWidth:2];
        [[self.view viewWithTag:1001].layer setBorderColor:[UIColor whiteColor].CGColor];
        [UIView animateWithDuration:2 animations:^{
            choose_colorview.frame = CGRectMake(0,self.view.frame.size.height-432/2-100+44+12+44, 320, 432/2);
        }];

        [self keyboardReturn];
        flag=1001;
    }

    if (sender.tag-1000==2)
    {
        [[[self.view viewWithTag:1002] layer] setBorderWidth:2];
        [[ self.view viewWithTag:1002].layer  setBorderColor:[UIColor whiteColor].CGColor];
        [UIView animateWithDuration:2 animations:^{
            choose_colorview.frame = CGRectMake(0,self.view.frame.size.height-432/2-100+44+12+44, 320, 432/2);
        }];
        flag=1002;
    [self keyboardReturn];
        
    }

    if (sender.tag-1000==3)
    {  [[[self.view viewWithTag:1003] layer] setBorderWidth:2];
        [[self.view viewWithTag:1003].layer setBorderColor:[UIColor whiteColor].CGColor];
        [UIView animateWithDuration:2 animations:^{
            choose_colorview.frame = CGRectMake(0,self.view.frame.size.height-432/2-100+44+12+44, 320, 432/2);
        }];
        flag=1003;

        [self keyboardReturn];
    }

    if (sender.tag-1000==4)
    {
        [[[self.view viewWithTag:1004] layer] setBorderWidth:2];
        [[self.view viewWithTag:1004].layer setBorderColor:[UIColor whiteColor].CGColor];
        
        [UIView animateWithDuration:2 animations:^{
            choose_colorview.frame = CGRectMake(0,self.view.frame.size.height-432/2-100+44+12+44, 320, 432/2);
        }];
        flag=1004;

        [self keyboardReturn];
    }


}


////////////////////////////////////下面供选择颜色的按钮1单击事件////////////////////////////////
-(void)changecolor1:(UIButton *)sender
{
    
    if (sender.tag-2000==0)
    {
        NSLog(@"+++++++%d",flag);
        if (flag==1000) {
            [[self.view viewWithTag:1000] setBackgroundColor:RGB(255, 0, 0)];
        }
        if (flag==1001) {
            [[self.view viewWithTag:1001] setBackgroundColor:RGB(255, 0, 0)];
        }
        if (flag==1002) {
            [[self.view viewWithTag:1002] setBackgroundColor:RGB(255, 0, 0)];
        }
        if (flag==1003) {
            [[self.view viewWithTag:1003] setBackgroundColor:RGB(255, 0, 0)];
        }
        if (flag==1004) {
            [[self.view viewWithTag:1004] setBackgroundColor:RGB(255, 0, 0)];
        }
    }
    if (sender.tag-2000==1)
    {
        if (flag==1000) {
            [[self.view viewWithTag:1000] setBackgroundColor:RGB(164, 0, 91)];
        }
        if (flag==1001) {
            [[self.view viewWithTag:1001] setBackgroundColor:RGB(164, 0, 91)];
        }
        if (flag==1002) {
            [[self.view viewWithTag:1002] setBackgroundColor:RGB(164, 0, 91)];
        }
        if (flag==1003) {
            [[self.view viewWithTag:1003] setBackgroundColor:RGB(164, 0, 91)];
        }
        if (flag==1004) {
            [[self.view viewWithTag:1004] setBackgroundColor:RGB(164, 0, 91)];
        }

        
    }
    
    if (sender.tag-2000==2)
    {
        if (flag==1000) {
            [[self.view viewWithTag:1000] setBackgroundColor:RGB(243, 151, 0)];
        }
        if (flag==1001) {
            [[self.view viewWithTag:1001] setBackgroundColor:RGB(243, 151, 0)];
        }
        if (flag==1002) {
            [[self.view viewWithTag:1002] setBackgroundColor:RGB(243, 151, 0)];
        }
        if (flag==1003) {
            [[self.view viewWithTag:1003] setBackgroundColor:RGB(243, 151, 0)];
        }
        if (flag==1004) {
            [[self.view viewWithTag:1004] setBackgroundColor:RGB(243, 151, 0)];
        }

        
    }
    
    if (sender.tag-2000==3)
    {
        if (flag==1000) {
            [[self.view viewWithTag:1000] setBackgroundColor:RGB(255, 244, 92)];
        }
        if (flag==1001) {
            [[self.view viewWithTag:1001] setBackgroundColor:RGB(255, 244, 92)];
        }
        if (flag==1002) {
            [[self.view viewWithTag:1002] setBackgroundColor:RGB(255, 244, 92)];
        }
        if (flag==1003) {
            [[self.view viewWithTag:1003] setBackgroundColor:RGB(255, 244, 92)];
        }
        if (flag==1004) {
            [[self.view viewWithTag:1004] setBackgroundColor:RGB(255, 244, 92)];
        }

        
    }
    
   }

//////////////////////////////////////下面供选择颜色的按钮2单击事件/////////////////////////////////////
-(void)changecolor2:(UIButton *)sender
{
    
    if (sender.tag-3000==0)
    {
        NSLog(@"+++++++%d",flag);
        if (flag==1000) {
            [[self.view viewWithTag:1000] setBackgroundColor:RGB(0, 155, 109)];
        }
        if (flag==1001) {
            [[self.view viewWithTag:1001] setBackgroundColor:RGB(0, 155, 109)];
        }
        if (flag==1002) {
            [[self.view viewWithTag:1002] setBackgroundColor:RGB(0, 155, 109)];
        }
        if (flag==1003) {
            [[self.view viewWithTag:1003] setBackgroundColor:RGB(0, 155, 109)];
        }
        if (flag==1004) {
            [[self.view viewWithTag:1004] setBackgroundColor:RGB(0, 155, 109)];
        }
    }
    if (sender.tag-3000==1)
    {
        if (flag==1000) {
            [[self.view viewWithTag:1000] setBackgroundColor:RGB(0, 255, 0)];
        }
        if (flag==1001) {
            [[self.view viewWithTag:1001] setBackgroundColor:RGB(0, 255, 0)];
        }
        if (flag==1002) {
            [[self.view viewWithTag:1002] setBackgroundColor:RGB(0, 255, 0)];
        }
        if (flag==1003) {
            [[self.view viewWithTag:1003] setBackgroundColor:RGB(0, 255, 0)];
        }
        if (flag==1004) {
            [[self.view viewWithTag:1004] setBackgroundColor:RGB(0, 255, 0)];
        }
        
        
    }
    
    if (sender.tag-3000==2)
    {
        if (flag==1000) {
            [[self.view viewWithTag:1000] setBackgroundColor:RGB(0, 160, 233)];
        }
        if (flag==1001) {
            [[self.view viewWithTag:1001] setBackgroundColor:RGB(0, 160, 233)];
        }
        if (flag==1002) {
            [[self.view viewWithTag:1002] setBackgroundColor:RGB(0, 160, 233)];
        }
        if (flag==1003) {
            [[self.view viewWithTag:1003] setBackgroundColor:RGB(0, 160, 233)];
        }
        if (flag==1004) {
            [[self.view viewWithTag:1004] setBackgroundColor:RGB(0, 160, 233)];
        }
        
        
    }
    
    if (sender.tag-3000==3)
    {
        if (flag==1000) {
            [[self.view viewWithTag:1000] setBackgroundColor:RGB(0, 0, 0)];
        }
        if (flag==1001) {
            [[self.view viewWithTag:1001] setBackgroundColor:RGB(0, 0, 0)];
        }
        if (flag==1002) {
            [[self.view viewWithTag:1002] setBackgroundColor:RGB(0, 0, 0)];
        }
        if (flag==1003) {
            [[self.view viewWithTag:1003] setBackgroundColor:RGB(0, 0, 0)];
        }
        if (flag==1004) {
            [[self.view viewWithTag:1004] setBackgroundColor:RGB(0, 0, 0)];
        }
        
        
    }
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    choose_colorview.frame = CGRectMake(0, self.view.frame.size.height, 320, 432/2);


    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
