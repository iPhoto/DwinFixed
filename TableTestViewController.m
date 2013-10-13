//
//  TableTestViewController.m
//  VideoCapture
//
//  Created by zang qilong on 13-10-12.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "TableTestViewController.h"
#import "DWinUtils.h"
#import "FriendAddressCell.h"
@interface TableTestViewController ()

@end

@implementation TableTestViewController

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
    self.navigationItem.title = @"Friend";
    // 导航条左按钮
    UIButton *btn_left = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_left.frame = CGRectMake(0, 0, 27, 27);
    // [btn_left setBackgroundImage:[UIImage imageNamed:@"friendlist_nav_leftbar"] forState:UIControlStateNormal];
    UIImageView *imageviewleft = [[UIImageView alloc] initWithFrame:CGRectMake(9, 3, 19, 18)];
    imageviewleft.image = [UIImage imageNamed:@"friendlist_nav_leftbar"];
    [btn_left addSubview:imageviewleft];
    btn_left.tag=1;
    [btn_left addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:btn_left];
    self.navigationItem.leftBarButtonItem = leftBar;
}

- (void)setupView
{
    [self setNavgationBar];
    _mSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 41)];
    [self.view addSubview:_mSearchBar];
    [[_mSearchBar.subviews objectAtIndex:0] removeFromSuperview];
    _mSearchBar.backgroundColor = [UIColor clearColor];
   
    _keys = [[NSMutableArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W", @"X",@"Y",@"Z",nil];
    NSLog(@"%@",_keys);
    _name = [NSMutableArray arrayWithObjects:@"able", @"bruce",@"chanel",@"daniel",@"electric",@"friend",nil];
    UIImageView *imageViewBackGround2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    NSLog(@"%f",kScreen_Height);
    imageViewBackGround2.image = [UIImage imageNamed:@"friendlistbg1"];
    
    
    UIImage *imageUserInfobg = [DWinUtils getBlurImage:imageViewBackGround2 withRect:CGRectMake(0, 0, kScreen_Width, kScreen_Height) WithRadius:0.3];
    imageViewBackGround2.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height);
    imageViewBackGround2.image = imageUserInfobg;
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 41,kScreen_Width , kScreen_Height) style:UITableViewStylePlain];
    
    //_mTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    // _mTableView.backgroundColor = [UIColor clearColor];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    [self.view addSubview:_mTableView];

    _mTableView.backgroundView = imageViewBackGround2;

    [self.view addSubview:_mTableView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _keys;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_keys count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [_keys objectAtIndex:section];
    return key;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
    view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 40, 20)];
    label.backgroundColor= [UIColor clearColor];
    label.text = [_keys objectAtIndex:section];
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"FriendAddressCell";
    FriendAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FriendAddressCell" owner:nil options:nil] lastObject];
            }
    cell.backgroundColor = [UIColor clearColor];
    cell.headImageView.image = [UIImage imageNamed:@"bingbing.jpg"];
    cell.friendNameLabel.text = [_name objectAtIndex:indexPath.row];
    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
