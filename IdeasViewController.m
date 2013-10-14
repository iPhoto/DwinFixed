//
//  IdeasViewController.m
//  DWin1.0
//
//  Created by Mac on 13-10-13.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "IdeasViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
#define kTabAlreadyDownUserViewY 0
#define kTabAlreadyUpUserViewY -80
#define kScrollAlreadyUp 50
#define kScrollAlreadyDown 130
#import "IdeasCell.h"
#import "ActivityIdeaLineViewController.h"
@interface IdeasViewController ()

@end

@implementation IdeasViewController

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
-(void)navBtnClick
{
    NSLog(@"Next");
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    imageViewBackGround.userInteractionEnabled = YES;
    [self.view addSubview:imageViewBackGround];
    
    
	self.navigationItem.title = @"Idea";
    
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    
    _mTableView.backgroundColor = [UIColor clearColor];
    _mTableView.dataSource = self;
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [imageViewBackGround addSubview:_mTableView];
    [self setNavgationBar];

	// Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"FriendInfoCell";
    IdeasCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell = [[IdeasCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
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
    return  260;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  ActivityIdeaLineViewController*line=[[ActivityIdeaLineViewController alloc]init];
   [self.navigationController pushViewController:line animated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
