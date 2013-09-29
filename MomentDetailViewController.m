//
//  MomentDetailViewController.m
//  DWin1.0
//
//  Created by Mac on 13-9-17.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "MomentDetailViewController.h"
#import "MomentHeaderCell.h"
#import "Cell.h"
#import <QuartzCore/QuartzCore.h>

@interface MomentDetailViewController ()

@end

@implementation MomentDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
  
}


- (void)setNavgationBar
{
    // 导航条左按钮
    UIButton *btn_left = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_left.frame = CGRectMake(0, 0, 56, 18);
    [btn_left setBackgroundImage:[UIImage imageNamed:@"moment_backBtn"] forState:UIControlStateNormal];
    btn_left.tag=1;
    [btn_left addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:btn_left];
    self.navigationItem.leftBarButtonItem = leftBar;
    // 导航条右按钮
    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_right.frame = CGRectMake(0, 0, 30, 6);
    [btn_right setBackgroundImage:[UIImage imageNamed:@"moment_moreBtn"] forState:UIControlStateNormal];
       btn_right.tag=2;
    [btn_right addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
    self.navigationItem.rightBarButtonItem = rightBar;
}
-(void)navBtnClick:(UIButton*)sender
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
          [self setNavgationBar];
    
    
    imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    imageViewBackGround.userInteractionEnabled = YES;
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    [self.view addSubview:imageViewBackGround];
    
    //导航栏添加图片
    UIImageView *vi=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 34, 34)];
    vi.backgroundColor =[UIColor whiteColor];
    vi.image=[UIImage imageNamed: @""];
    self.navigationItem.titleView=vi;
    UIImageView *titleLabImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"123"]];
    titleLabImage.frame = CGRectMake(1, 1, 32, 32);
    titleLabImage.backgroundColor = [UIColor whiteColor];
    titleLabImage.layer.cornerRadius=3;
   // self.navigationItem.titleView.frame=CGRectMake(0, 0, 35, 35);
   // titleLabImage.frame = CGRectMake(0, 0, 35, 35);
     [vi addSubview: titleLabImage ];
    
    //chuangjian 滑动表单
    self.momentTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-44-44) style:UITableViewStylePlain];
    self.momentTabelView.delegate = self;
    self.momentTabelView.dataSource = self;
    self.momentTabelView.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    [self.view addSubview:self.momentTabelView];
    
    FaceToolBar* bar=[[FaceToolBar alloc]initWithFrame:CGRectMake(0.0f,self.view.frame.size.height - toolBarHeight-45-4509,self.view.frame.size.width,toolBarHeight) superView:self.view];
    bar.delegate=self;
    [self.view addSubview:bar];
}

-(void)sendTextAction:(NSString *)inputText{
    NSLog(@"sendTextAction%@",inputText);
    
    }
-(void)change
{


}
-(void)dismissKeyBoard
{

 [self.detail_texfold resignFirstResponder ];

}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.shareView.hidden=YES;
   

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
    
    
    if (indexPath.row==0) {
        static NSString *C = @"Cell";
        MomentHeaderCell  * cell = [tableView dequeueReusableCellWithIdentifier:C];
        
        if (cell==nil)
        {
            
            cell = [[MomentHeaderCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:C] ;
            
        }
        
        
        
        cell.contentView.backgroundColor=[UIColor clearColor];
        
        return cell;
        
        

    }
    
    
    else
    
    
    {
    static NSString *CellIdentifier = @"Cell1";
    Cell  * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil)
    {
        
        cell = [[Cell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
        
    }
    
        cell.contentView.backgroundColor=[UIColor clearColor];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__FUNCTION__);
    //自定义高度 调用响应内容
    
    if (indexPath.row==0) {
        MomentHeaderCell *cells = (MomentHeaderCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return [cells setCellHeight];

    }
    else{
       Cell *cells = (Cell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
      return [cells setCellHeightdetail];
    
    }
        
          }


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */
/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
