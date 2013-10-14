//
//  ActivityClassifiedViewController.m
//  DWin1.0
//
//  Created by Mac on 13-10-11.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "ActivityClassifiedViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
#define kTabAlreadyDownUserViewY 0
#define kTabAlreadyUpUserViewY -80
#define kScrollAlreadyUp 50
#define kScrollAlreadyDown 130
#import "ActivityClassifiedCell.h"
#import "ActivityClassifiedDetailViewController.h"
@interface ActivityClassifiedViewController ()

@end

@implementation ActivityClassifiedViewController

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
	// 背景图
   imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    imageViewBackGround.userInteractionEnabled = YES;
    [self.view addSubview:imageViewBackGround];
    
    [self setNavgationBar];
	self.navigationItem.title = @"Classified";
    
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    
    _mTableView.backgroundColor = [UIColor clearColor];
    _mTableView.dataSource = self;
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [imageViewBackGround addSubview:_mTableView];

   }
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSLog(@"%f,%f",_mTableView.contentOffset.x,_mTableView.contentOffset.y);
//    if (_mTableView.contentOffset.y<-100) {
//        [UIView animateWithDuration:0.5 animations:^{
//           // userInfoView.frame = CGRectMake(0, kTabAlreadyDownUserViewY, kScreen_Width, 130);
//            _mTableView.frame = CGRectMake(0, kScrollAlreadyDown, kScreen_Width, kScreen_Height);
//            
//        }];
//    }
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"FriendInfoCell";
    ActivityClassifiedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell = [[ActivityClassifiedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
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
    ActivityClassifiedDetailViewController*detail = [[ActivityClassifiedDetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
