//
//  FriendSpaceViewController.m
//  DWin1.0
//
//  Created by Mac on 13-9-25.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "FriendSpaceViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface FriendSpaceViewController ()

@end

@implementation FriendSpaceViewController

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
- (void)navBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Self-evalution";
    [self setNavgationBar];
    // 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    //打开用户交互
    imageViewBackGround.userInteractionEnabled = YES;
    [self.view addSubview:imageViewBackGround];

    UIImageView*imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 300)];
    imgView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    imgView.layer.cornerRadius = 5;
    [imageViewBackGround addSubview:imgView];
    
    UILabel *textlab = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 290, 300)];
    textlab.backgroundColor = [UIColor clearColor];
    
    textlab.text = @"     My father was a self-taught mandolin player. He was one of the best string instrument players in our town. He could not read music, but if he heard a tune a few times, he could play it. When he was younger, he was a member of a small country music band. They would play at local ";
    textlab.numberOfLines=0;
    [textlab sizeToFit];
    [imgView addSubview:textlab];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
