//
//  TVShowViewController.m
//  DWin1.0
//
//  Created by zang qilong on 13-9-27.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "TVShowViewController.h"

@interface TVShowViewController ()

@end

@implementation TVShowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -Setup View

- (void)setupView
{
    //设置 navigationbar
    
    self.view.userInteractionEnabled = YES;
    [self setNavgationBar];
        // 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    [self.view addSubview:imageViewBackGround];
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    
    _mTableView.backgroundColor = [UIColor clearColor];
    _mTableView.dataSource = self;
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mTableView];
    
    
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
    [btn_left addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:btn_left];
    self.navigationItem.leftBarButtonItem = leftBar;
    // 导航条右按钮
    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_right.frame = CGRectMake(0,8 , 50, 17);
    [btn_right setBackgroundImage:[UIImage imageNamed:@"tvshow_review"] forState:UIControlStateNormal];
    btn_right.tag=2;
    [btn_right addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
    self.navigationItem.rightBarButtonItem = rightBar;
    // 标题
    self.navigationItem.title = @"TV SHOW";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"TVShowCell";
    TVShowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell = [[TVShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  260;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MomentDetailViewController *moment=[[MomentDetailViewController alloc]init];
//    
//    [self.navigationController pushViewController:moment animated:YES];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
