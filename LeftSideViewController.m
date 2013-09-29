//
//  LeftSideViewController.m
//  DWin1.0
//
//  Created by zang qilong on 13-9-16.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "LeftSideViewController.h"
#import "ZXMacro.h"
#import "IIViewDeckController.h"
#import "TextEditViewController.h"
@interface LeftSideViewController ()

@end

@implementation LeftSideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setupView
{
    arr_title = [NSArray arrayWithObjects:@"Home",@"Bubble Space",@"Friends",@"Chat",@"Message",@"Joined activity",@"Setting", nil];
    _mTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_mTableView];
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    UIImage *imageTableView = [DWinUtils getBlurImage:imageViewBackGround withRect:CGRectMake(0, 0, kScreen_Width, kScreen_Height) WithRadius:0.3];
    UIView *viewBlackCover = [[UIView alloc] initWithFrame:self.view.bounds];
    viewBlackCover.backgroundColor = RGBAlpha(1, 1, 1, 0.5);
    [imageViewBackGround addSubview:viewBlackCover];
    imageViewBackGround.image = imageTableView;
    _mTableView.backgroundView = imageViewBackGround;
   // _mTableView.backgroundColor = [UIColor clearColor];


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
	// Do any additional setup after loading the view.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark -tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:18];
    cell.textLabel.text = (NSString *)[arr_title objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UIView *selectedview = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
//    selectedview.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [cell.contentView addSubview:selectedview];
    self.viewDeckController.centerController = [[TextEditViewController  alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
