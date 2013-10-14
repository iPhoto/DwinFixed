//
//  ChatEachotherViewController.m
//  DWin1.0
//
//  Created by Mac on 13-9-29.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "ChatEachotherViewController.h"
#import "ZXMacro.h"
#import "DRNRealTimeBlurView.h"
#import "DWinUtils.h"
#define kTabAlreadyUpUserViewY -80
#import "GetStaticImage.h"
#import <QuartzCore/QuartzCore.h>
@interface ChatEachotherViewController ()

@end

@implementation ChatEachotherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)tableViewInit {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, 320, self.view.frame.size.height-44) style:UITableViewStylePlain] ;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
   // UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.tableView.frame];
   // imageView.image=[UIImage imageNamed:@"friendlistbg1"];
    self.tableView.dataSource=self;
	self.tableView.delegate=self;
    //[self.tableView setSeparatorColor:[UIColor redColor]];
    self.tableView.backgroundColor=[UIColor clearColor];
    //设置tabelView的分割线
   // [self.tableView setBackgroundView:imageView];
  //  self. tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //  self.tableView.separatorColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"allcell_line.png"]];
	[self.view addSubview:self.tableView];
}
- (void)searchBarInit {
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 290.0f, 44.0f)];
    
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	self.searchBar.keyboardType = UIKeyboardTypeDefault;
	self.searchBar.backgroundColor=[UIColor clearColor];
	_searchBar.translucent=YES;
	self.searchBar.placeholder=@"搜索";
	self.searchBar.delegate = self;
	self.searchBar.barStyle=UIBarStyleDefault;
    self.searchBar.showsCancelButton=NO;
    self.searchBar.  backgroundColor=[UIColor clearColor];
    [[self.searchBar.subviews objectAtIndex:0]removeFromSuperview];
    
    self.tableView.tableHeaderView=self.searchBar;
    
    UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    img.image=[UIImage imageNamed:@"serarh_listLuYin"];
    
    
    
}
- (void)setNavgationBar
{
//        // 导航条左按钮
//    UIButton *btn_left = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn_left.frame = CGRectMake(10, 10, 25, 25);
//    [btn_left setBackgroundImage:[UIImage imageNamed:@"friendlist_nav_leftbar"] forState:UIControlStateNormal];
//    btn_left.tag=1;
//    [btn_left addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:btn_left];
//    
//    
//    
//    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:btn_left];
//    self.navigationItem.leftBarButtonItem = leftBar;
//    
//    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn_right.frame = CGRectMake(0, 0, 34, 34);
//    [btn_right setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    [btn_right setTitle:@"Add" forState:UIControlStateNormal];
//    btn_right.tag=2;
//    [btn_right addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
//    self.navigationItem.rightBarButtonItem = rightBar;
//    [self.view addSubview:btn_right];

    // 导航条左按钮
    UIButton *btn_left = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_left.frame = CGRectMake(0, 0, 18, 18);
    [btn_left setBackgroundImage:[UIImage imageNamed:@"friendlist_nav_leftbar"] forState:UIControlStateNormal];
    btn_left.tag=1;
    [btn_left addTarget:self action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:btn_left];
    self.navigationItem.leftBarButtonItem = leftBar;
    // 导航条右按钮
    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_right.frame = CGRectMake(0, 0, 92/2, 44);
    [btn_right setTitle:@"Edit" forState:UIControlStateNormal];
    btn_right.tag=2;
    [btn_right addTarget:self action:@selector(navBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
    self.navigationItem.rightBarButtonItem = rightBar;

}
-(void)toggleLeftView
{



}
-(void)navBtnClick
{
    
    NSLog(@"12345678");
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Chat";
    // 背景图
    imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    imageViewBackGround.userInteractionEnabled = YES;
    [self.view addSubview:imageViewBackGround];
    UIView * back_colorview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    [back_colorview setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:0.5]];
    [imageViewBackGround addSubview:back_colorview];
    [self tableViewInit];
    [self searchBarInit];
    
  [self setNavgationBar];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)_tableView
{
    //* 出现几组
	//if(aTableView == self.tableView) return 27;
	return 1;
}
//划动cell是否出现del按钮
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
	return YES;  //是否需要删除图标
}

- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 55;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.listarray count];    //*每组要显示的行数
    //NSInteger i = [[listarray objectAtIndex:section] ]
   
    return 5;
}

//-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
//    //返回类型选择按钮
//    
//    return UITableViewCellAccessoryDisclosureIndicator;   //每行右边的图标
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier =@"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
    if (cell ==nil) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CustomCellIdentifier];
    }
	   
 

//    cell.imageView.image=[UIImage imageNamed:@"123"];
//    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(10, 3, 38, 38)];
//    headView.backgroundColor=[UIColor whiteColor];
//    headView.layer.cornerRadius = 5;
//    [cell.imageView addSubview:headView];
//    
//    UIImageView*ima=[[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 34, 34)];
//    ima.image = [UIImage imageNamed:@"123"];
//    [headView addSubview:ima];
    cell.imageView.image=[UIImage imageNamed:@"123"];
    cell.textLabel.text=@"super";
    cell.detailTextLabel.text=@"1234567890-=";
    return cell;
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)searchBar:(UISearchBar *)_searchBar textDidChange:(NSString *)searchText
{
    //[[SearchCoreManager share] Search:searchText searchArray:nil nameMatch:searchByName phoneMatch:self.searchByPhone];
    
    [self.tableView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton=YES;
    for(id cc in [self.searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *sbtn = (UIButton *)cc;
            sbtn.hidden=YES;
            
            
            sbtn.tag=1001;
            
            
            UIButton*search_buton=[[UIButton alloc]init];
            
            
            search_buton.frame=CGRectMake(260, 5, 50, 35);
            search_buton.tag=1001;
            
            [search_buton setTitle:@"取消" forState:UIControlStateNormal];
            
            
            search_buton.titleLabel.font=[UIFont fontWithName:@"Arial" size:17.0];
            
            [search_buton addTarget:self action:@selector(search_buton_cancel) forControlEvents:UIControlEventTouchUpInside];
            [search_buton  showsTouchWhenHighlighted ];
            
            [self.searchBar addSubview:search_buton];
            
        }}
    
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    
    
}
-(void)search_buton_cancel
{
    
    [self.searchBar resignFirstResponder];
    self.searchBar.showsCancelButton=NO;
}

@end
