//
//  SucViewController.m
//  DWin1.0
//
//  Created by Mac on 13-10-10.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "SucViewController.h"
//#import "Cell1.h"
//#import "Cell2.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
@interface SucViewController ()

@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;

@property (nonatomic,retain) UITableView *expansionTableView;



@end

@implementation SucViewController
@synthesize isOpen,selectIndex;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _nameArray = [[NSMutableArray alloc] init];
        NSArray *array1 = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
        NSArray *array2 = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g", nil];
        NSArray *array3 = [NSArray arrayWithObjects:@"liu",@"ping",@"wei",@"ni",@"hao",@"haha",@"your", nil];
        NSArray *array4 = [NSArray arrayWithObjects:@"apple",@"banana",@"orange",@"give",@"me",@"off",@"up", nil];
        NSArray *array5 = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
               [_nameArray addObject:array1];
        [_nameArray addObject:array2];
        [_nameArray addObject:array3];
        [_nameArray addObject:array4];
        [_nameArray addObject:array5];
               

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
    NSLog(@"Next");
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    imageViewBackGround.userInteractionEnabled = YES;
    [self.view addSubview:imageViewBackGround];
    
    [self setNavgationBar];
	self.navigationItem.title = @"Chat";

    NSString *path  = [[NSBundle mainBundle] pathForResource:@"ExpansionTableTestData" ofType:@"plist"];
    _dataList = [[NSMutableArray alloc] initWithContentsOfFile:path];
    NSLog(@"%@",path);
    
  // self.expansionTableView.sectionFooterHeight = 0;
  //  self.expansionTableView.sectionHeaderHeight = 0;
    self.isOpen = NO;
    self.expansionTableView=[[UITableView alloc]initWithFrame:CGRectMake(1, 0, 318, 400) style:UITableViewStyleGrouped];
   // self.expansionTableView.frame=CGRectMake(11, 22, 300, 400);
    self.expansionTableView.delegate=self;
    self.expansionTableView.dataSource=self;
    
    self.expansionTableView.backgroundColor=[UIColor redColor];;
    self.expansionTableView.separatorStyle=NO;
    
    self.expansionTableView.backgroundView = [[UIView alloc]init];
    self.expansionTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.expansionTableView];
    
    
    
    boolArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.nameArray.count; i++) {
        [boolArray addObject:@"no"];
    }
    

	// Do any additional setup after loading the view.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [_dataList count];
      return [_nameArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (self.isOpen) {
//        if (self.selectIndex.section == section) {
//            return [[[_dataList objectAtIndex:section] objectForKey:@"list"] count]+1;;
//        }
//    }
//    return 1;

    if ([boolArray[section] isEqual: @"yes"]) {
        return [[_nameArray objectAtIndex:section] count];
    }else{
        return 2;
    }

}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       return 88;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }
    if ([[_nameArray objectAtIndex:indexPath.section] count] > indexPath.row) {
        cell.textLabel.text = [[_nameArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    
    if ([boolArray[indexPath.section] isEqual: @"no"] &&
        indexPath.row == 1 &&
        [[self.nameArray objectAtIndex:indexPath.section] count] != 2&&indexPath.section==0)
    
    {
        cell.textLabel.text = nil;
        cell.textLabel.text = @"更多";
        cell.detailTextLabel.text = @"123456789";
    }
    
    return cell;

    
    
    
    
//    if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {
//        static NSString *CellIdentifier = @"Cell2";
//        Cell2 *cell = (Cell2*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        
//        if (!cell) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
//        }
////        NSArray *list = [[_dataList objectAtIndex:self.selectIndex.section] objectForKey:@"list"];
////        NSLog(@"+++++++++++++++++++++%d",indexPath.row);
////        
////        
////        if (indexPath.row==1) {
////         
////           cell.li.text =@"Partner:";
////            
////            cell.li2.text =@"My grandfather died when I was a small boy";
////            cell.li2.tag =1001;
////
////        }
////        if (indexPath.row==2) {
////            cell.li.text = @"My grandfather died when I was a small boy";
////                      
////        }
////   
////        cell.contentView.backgroundColor=[UIColor clearColor];
////        cell.selectionStyle=NO; 
////        [cell setBackgroundColor:[UIColor clearColor]];
////        
////        UIImageView *bacView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
////        UIImageView *linview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44+69, 300, 1)];
////        bacView.userInteractionEnabled = YES;
////        bacView .image = [UIImage imageNamed:@"activity_aph_"];
////        linview .image = [UIImage imageNamed:@"activity_line"];
////        
////       // [cell.contentView addSubview: bacView];
////      //  [back_View addSubview: linview];
////        UIView *tempView = [[UIView alloc] init];
////        [cell setBackgroundView:tempView];
////       // [cell setBackgroundColor:[UIColor clearColor]];
//        return cell;
//    }else
//    {
//    [[self.expansionTableView viewWithTag:1001] removeFromSuperview];
//        static NSString *CellIdentifier = @"Cell1";
//        Cell1 *cell = (Cell1*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (!cell) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
//        }
//        NSString *name = [[_dataList objectAtIndex:indexPath.section] objectForKey:@"name"];
//        cell.titleLabel.text = name;
//        [cell changeArrowWithUp:([self.selectIndex isEqual:indexPath]?YES:NO)];
//         cell.selectionStyle=NO;
//        [cell setBackgroundColor:[UIColor clearColor]];
//     
//        
//        UIImageView *bacView  = [[UIImageView alloc]initWithFrame:CGRectMake(9, 0, 300, 44)];
//        UIImageView *linview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44+69, 300, 1)];
//        bacView.userInteractionEnabled = YES;
//        bacView .image = [UIImage imageNamed:@"activity_aph_"];
//        linview .image = [UIImage imageNamed:@"activity_line"];
//        
//        [cell addSubview: bacView];
//        
//        
//        UIView *tempView = [[UIView alloc] init] ;
//        [cell setBackgroundView:tempView];
//      //  [cell setBackgroundColor:[UIColor clearColor]];
//           return cell;
//       // [back_View addSubview: linview];
//
//    }
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0)
//    {
//                
//        
//        if ([indexPath isEqual:self.selectIndex]) {
//            self.isOpen = NO;
//            [self didSelectCellRowFirstDo:NO nextDo:NO];
//            self.selectIndex = nil;
//            
//        }else
//        {
//            if (!self.selectIndex) {
//                self.selectIndex = indexPath;
//                [self didSelectCellRowFirstDo:YES nextDo:NO];
//                
//            }else
//            {
//                
//                [self didSelectCellRowFirstDo:NO nextDo:YES];
//            }
//        }
//        
//    }else
//    {
//        NSDictionary *dic = [_dataList objectAtIndex:indexPath.section];
//        NSArray *list = [dic objectForKey:@"list"];
//        NSString *item = [list objectAtIndex:indexPath.row-1];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:item message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
//        [alert show];
//    }
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:indexPath.section]];
    
    if ([boolArray[indexPath.section] isEqual: @"no"]) {
        boolArray[indexPath.section] = @"yes";
        cell.textLabel.text = [[self.nameArray objectAtIndex:indexPath.section]objectAtIndex:1];
        
        for (NSInteger i = 2; i < [[_nameArray objectAtIndex:indexPath.section] count]; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
            [array addObject:index];
        }
        [self.expansionTableView insertRowsAtIndexPaths:array
                              withRowAnimation:UITableViewRowAnimationFade];
        
    }else{
        boolArray[indexPath.section] = @"no";
        cell.textLabel.text = @"更多";
        for (NSInteger i = 2; i < [[_nameArray objectAtIndex:indexPath.section] count]; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
            [array addObject:index];
        }
        [self.expansionTableView deleteRowsAtIndexPaths:array
                              withRowAnimation:UITableViewRowAnimationFade];
        
    }

}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[self.nameArray objectAtIndex:indexPath.section] count] == 2) {
        return nil;
    }
    if ([boolArray[indexPath.section] isEqual: @"yes"]) {
        return indexPath;
    }else{
        if (indexPath.row == 1) {
            return indexPath;
        }else{
            return nil;
        }
    }
    
}
//- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
//{
//    self.isOpen = firstDoInsert;
//    
//    Cell1 *cell = (Cell1 *)[self.expansionTableView cellForRowAtIndexPath:self.selectIndex];
//    [cell changeArrowWithUp:firstDoInsert];
//    
//    [self.expansionTableView beginUpdates];
//    
//    int section = self.selectIndex.section;
//    int contentCount = [[[_dataList objectAtIndex:section] objectForKey:@"list"] count];
//	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
//	for (NSUInteger i = 1; i < contentCount + 1; i++) {
//		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
//		[rowToInsert addObject:indexPathToInsert];
//	}
//	
//	if (firstDoInsert)
//    {   [self.expansionTableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
//    }
//	else
//    {
//        [self.expansionTableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
//    }
//    
//
//	
//	[self.expansionTableView endUpdates];
//    if (nextDoInsert) {
//        self.isOpen = YES;
//        self.selectIndex = [self.expansionTableView indexPathForSelectedRow];
//        [self didSelectCellRowFirstDo:YES nextDo:NO];
//    }
//    if (self.isOpen) [self.expansionTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
//}
//
//
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
