//
//  FriendchatViewController.m
//  DWin1.0
//
//  Created by Mac on 13-9-27.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "FriendchatViewController.h"
#import "ZXMacro.h"
#import "DRNRealTimeBlurView.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
#define kTabAlreadyUpUserViewY -80
#import "SearchCoreManager.h"
#import "ContactPeople.h"
#import "GetStaticImage.h"
#import "ChatListViewController.h"
@interface FriendchatViewController ()

@end

@implementation FriendchatViewController

@synthesize tableView;
@synthesize searchBar;
@synthesize contactDic;
@synthesize searchByName;
@synthesize searchByPhone;


@synthesize listarray;

@synthesize arrayDict;
@synthesize secLabelArray;
@synthesize arrayDictKey;


- (void)tableViewInit {
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, 320, self.view.frame.size.height-44) style:UITableViewStyleGrouped] ;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.tableView.frame];
    imageView.image=[UIImage imageNamed:@"friendlistbg1"];
    imageView.userInteractionEnabled = YES;
    self.tableView.dataSource=self;
	self.tableView.delegate=self;
       self.tableView.backgroundColor=[UIColor clearColor];
    //设置tabelView的分割线
    [self.tableView setBackgroundView:imageView];
    self. tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //  self.tableView.separatorColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"allcell_line.png"]];
	[self.view addSubview:self.tableView];
}
- (void)searchBarInit {
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 290.0f, 44.0f)];
    
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	self.searchBar.keyboardType = UIKeyboardTypeDefault;
	self.searchBar.backgroundColor=[UIColor clearColor];
	searchBar.translucent=YES;
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


    // 导航条左按钮
    UIButton *btn_left = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_left.frame = CGRectMake(10, 10, 25, 25);
    [btn_left setBackgroundImage:[UIImage imageNamed:@"friendlist_nav_leftbar"] forState:UIControlStateNormal];
    btn_left.tag=1;
    [btn_left addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn_left];
    
    
    
   UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:btn_left];
    self.navigationItem.leftBarButtonItem = leftBar;
   
    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_right.frame = CGRectMake(320-40, 5, 34, 34);
    [btn_right setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btn_right setTitle:@"Add" forState:UIControlStateNormal];
    btn_right.tag=2;
    [btn_right addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
    self.navigationItem.rightBarButtonItem = rightBar;
    [self.view addSubview:btn_right];
}
-(void)navBtnClick:(UIButton*)sender
{
    
   [self.navigationController popViewControllerAnimated:YES];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)setNavigationBarview
{
    
       
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.navigationItem.title =@"Friend";
    self.view.backgroundColor=[UIColor whiteColor];
	NSArray *array = [[NSArray alloc] initWithObjects:@"你好", @"BFlower",
                      @"CGrass", @"DFence", @"EHouse", @"FTable", @"GChair",
                      @"HBook", @"ISwing" ,@"JWang" ,@"KDong" ,@"LNi" ,@"MHao" ,@"Na" ,@"Oa" ,@"Pa" ,@"Qa" ,@"Ra" ,@"Sa" ,@"Ta" ,@"Ua" ,@"Va" ,@"Wa" ,@"Xa" ,@"Ya" ,@"Za", nil];
    self.listarray = array;
    NSLog(@"listarryCount:%d",[listarray count]);
    secLabelArray = [[NSArray alloc] initWithObjects:@"A", @"B", @"C",@"D", @"E", @"F",@"G", @"H", @"I",@"J", @"K", @"L",@"M", @"N", @"O",@"P", @"Q", @"R",@"S", @"T", @"U",@"V", @"W", @"X",@"Y", @"Z", nil];
    
    NSArray *arrayA = [[NSArray alloc] initWithObjects:@"测试A1",@"测试A2", nil];
    NSArray *arrayB = [[NSArray alloc] initWithObjects:@"测试B1",@"测试B2",@"测试B3", nil];
    NSArray *arrayC = [[NSArray alloc] initWithObjects:@"测试C1",@"测试C2",@"测试C3",@"测试C4", nil];
    NSArray *arrayD = [[NSArray alloc] initWithObjects:@"测试D1",@"测试D2",@"测试D3",@"测试D4",@"测试D5", nil];
    NSArray *arrayE = [[NSArray alloc] initWithObjects:@"测试E1",@"测试E2",@"测试E3",@"测试E4",@"测试E5",@"测试E6", nil];
    NSArray *arrayF = [[NSArray alloc] initWithObjects:@"测试F1",@"测试F2",@"测试F3",@"测试F4",@"测试F5",@"测试F6",@"测试F7", nil];
    NSArray *arrayG = [[NSArray alloc] initWithObjects:@"测试G1",@"测试G2",@"测试G3",@"测试G4",@"测试G5",@"测试G6", nil];
    arrayDictKey = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G", nil];
    arrayDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:arrayA,[arrayDictKey objectAtIndex:0],
                 arrayB,[arrayDictKey objectAtIndex:1],
                 arrayC,[arrayDictKey objectAtIndex:2],
                 arrayD,[arrayDictKey objectAtIndex:3],
                 arrayE,[arrayDictKey objectAtIndex:4],
                 arrayF,[arrayDictKey objectAtIndex:5],
                 arrayG,[arrayDictKey objectAtIndex:6],
                 nil];
    NSLog(@"arrayrow:%d",[[arrayDict objectForKey:[arrayDictKey objectAtIndex:1]] count]);

	// Do any additional setup after loading the view, typically from a nib.
    imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@""];
    [self.view addSubview:imageViewBackGround];
     [self setNavigationBarview];
    [self tableViewInit];
    [self searchBarInit];
  
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    self.contactDic = dic;
    self.navigationItem.title=@"Friend";
    
    NSMutableArray *nameIDArray = [[NSMutableArray alloc] init];
    self.searchByName = nameIDArray;
    
    NSMutableArray *phoneIDArray = [[NSMutableArray alloc] init];
    
    self.searchByPhone = phoneIDArray;
    ContactPeople *contact = [[ContactPeople alloc] init];
    contact.localID = [NSNumber numberWithInt:0];
    contact.name = @"西，藏";
    
    NSMutableArray *phoneArray = [[NSMutableArray alloc] init];
    [phoneArray addObject:@"13800138000"];
    [phoneArray addObject:@"10086"];
    contact.phoneArray = phoneArray;
    
    [self.contactDic setObject:contact forKey:contact.localID];
    
    //添加到搜索库
    [[SearchCoreManager share] AddContact:contact.localID name:contact.name phone:contact.phoneArray];
    
    for (int i = 1; i < 20; i ++) {
        ContactPeople *contact = [[ContactPeople alloc] init];
        contact.localID = [NSNumber numberWithInt:i];
        contact.name = [NSString stringWithFormat:@"测试%d",i];
        [[SearchCoreManager share] AddContact:contact.localID name:contact.name phone:contact.phoneArray];
        [self.contactDic setObject:contact forKey:contact.localID];
      
        
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
initWithTitle:@"左按钮"
                                       
                                       style:UIBarButtonItemStylePlain
                                       
                                       target:self
                                       
                                       action:@selector(qwe)];
        
        [self.navigationItem setLeftBarButtonItem:leftButton];
                                       
  }

  [self setNavgationBar];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)_tableView
{
    //* 出现几组
	//if(aTableView == self.tableView) return 27;
	return [arrayDict count];
}
//划动cell是否出现del按钮
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
	return YES;  //是否需要删除图标
}

- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 55;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //搜索时显示按索引第几组
    NSInteger count = 0;
    NSLog(@"%@",title);
    for(NSString *character in arrayDictKey)
    {
        
        if([character isEqualToString:title])
        {
            
            return count;
            
        }
        
        count ++;
        
    }
    
    return count;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    /*if([listarray count]==0)
     
     {
     
     return @"";
     
     }*/
    
    //return [listarray objectAtIndex:section];   //*分组标签
    return [arrayDictKey objectAtIndex:section];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.listarray count];    //*每组要显示的行数
    //NSInteger i = [[listarray objectAtIndex:section] ]
    NSInteger i =  [[arrayDict objectForKey:[arrayDictKey objectAtIndex:section]] count];
    return i;
}

-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
    //返回类型选择按钮
    
    return UITableViewCellAccessoryDisclosureIndicator;   //每行右边的图标
}
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[_tableView dequeueReusableCellWithIdentifier:indentifier];
    
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier] ;
		//cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        imageViewBackGround2 = [[UIImageView alloc] initWithFrame:self.tableView.frame];
        
        imageViewBackGround2.image = [UIImage imageNamed:@"friendlistbg1"];
        imageViewBackGround2.userInteractionEnabled = YES;
        UIView*   userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  300,55)];
        
        UIImage *imageUserInfobg = [DWinUtils getBlurImage:imageViewBackGround2 withRect:CGRectMake(0, 0, 300, 55) WithRadius:0.3];
        imageViewBackGround2.frame = CGRectMake(0, 0,  300, 55);
        
        
        imageViewBackGround2.image = imageUserInfobg;
        [userInfoView addSubview:imageViewBackGround2];
        
        [cell.contentView addSubview:userInfoView];
        
        
        UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 54, 300, 1)];
        img.image=[UIImage imageNamed:@"allcell_line"];
        [imageViewBackGround2  addSubview:img];
	}
    
    
    cell.accessoryView.hidden=NO;
    //cell.contentView.backgroundColor=[UIColor clearColor];
    cell.imageView.alpha=0;;
    cell.imageView.image=[UIImage imageNamed:@"123"];
    
    UIImageView *img1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"123"]];
    img1.frame=CGRectMake(9, 4, 55-8, 55-8);
    [cell.contentView addSubview:img1];
    UIImageView *accessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 10, 14)];
    UIImage *image=[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"list_accescce" ofType:@"png"]];
    accessoryImageView.image =image;
    
    cell.accessoryView=accessoryImageView;
    if ([self.searchBar.text length] <= 0) {
        ContactPeople *contact = [[self.contactDic allValues] objectAtIndex:indexPath.row];
        cell.textLabel.text = contact.name;
        cell.textLabel.backgroundColor=[UIColor clearColor];
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.detailTextLabel.text = @"ertyu";
        cell.detailTextLabel.backgroundColor=[UIColor clearColor];
        return cell;
    }
    
    NSNumber *localID = nil;
    NSMutableString *matchString = [NSMutableString string];
    NSMutableArray *matchPos = [NSMutableArray array];
    if (indexPath.row < [searchByName count]) {
        localID = [self.searchByName objectAtIndex:indexPath.row];
        
        //姓名匹配 获取对应匹配的拼音串 及高亮位置
        if ([self.searchBar.text length]) {
            [[SearchCoreManager share] GetPinYin:localID pinYin:matchString matchPos:matchPos];
        }
    } else
    {
        //localID = [self.searchByPhone objectAtIndex:indexPath.row-[searchByName count]];
        //NSMutableArray *matchPhones = [NSMutableArray array];
        
        //号码匹配 获取对应匹配的号码串 及高亮位置
        //        if ([self.searchBar.text length]) {
        //            [[SearchCoreManager share] GetPhoneNum:localID phone:matchPhones matchPos:matchPos];
        //            [matchString appendString:[matchPhones objectAtIndex:0]];
        //        }
    }
    ContactPeople *contact = [self.contactDic objectForKey:localID];
    
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = matchString;
    // cell.imageView.image=[UIImage imageNamed:@""];
    return cell;
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatListViewController *list=[[ChatListViewController alloc]init];
    [self presentViewController:list animated:YES completion:nil];
}

- (void)searchBar:(UISearchBar *)_searchBar textDidChange:(NSString *)searchText
{
    [[SearchCoreManager share] Search:searchText searchArray:nil nameMatch:searchByName phoneMatch:self.searchByPhone];
    
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//右侧添加一个索引表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray* arr=[[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    
    return arr;
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
