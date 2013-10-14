//
//  VideolineViewController.m
//  DWin1.0
//
//  Created by Mac on 13-10-13.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "VideolineViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
#import "VideolineCell.h"
@interface VideolineViewController ()

@end

@implementation VideolineViewController

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
    NSLog(@"Done");
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    imageViewBackGround.userInteractionEnabled = YES;
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    [self.view addSubview:imageViewBackGround];
    [self setNavgationBar];
    
    UIView*viewb = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    viewb.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    [self.view addSubview:viewb];
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    
    _mTableView.backgroundColor = [UIColor clearColor];
    _mTableView.dataSource = self;
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [viewb addSubview:_mTableView];
    
    UIView *toobar_view = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-88, 320, 44)];
    toobar_view.backgroundColor = RGB(240, 240, 240);
    [self.view addSubview:toobar_view];
    
    UIButton* cordbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cordbtn.frame = CGRectMake(278/2, 0, 44, 44);
    [cordbtn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_timeline_record", @"png")] forState:UIControlStateNormal];
    [toobar_view addSubview:cordbtn];
    
    starbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    starbtn.frame = CGRectMake(320-44, 0, 44, 44);
    [starbtn addTarget:self action:@selector(chage) forControlEvents:UIControlEventTouchUpInside];
    [starbtn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_timeline_unclicstar", @"png")] forState:UIControlStateNormal];
    [toobar_view addSubview:starbtn];

}
-(void)chage
{
    [starbtn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_timeline_clicstar", @"png")] forState:UIControlStateNormal];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"FriendInfoCell";
    VideolineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell = [[VideolineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    [(UIButton*)[self.view viewWithTag:9002] addTarget:self action:@selector(star) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)star
{
    NSLog(@"1234567");
    [(UIButton*)[self.view viewWithTag:9002] setBackgroundImage:[UIImage imageNamed:@"star_yellow.png"] forState:UIControlStateNormal];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  174;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
