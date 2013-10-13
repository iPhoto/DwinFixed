//
//  LookUpAllPicViewController.m
//  DWin1.0
//
//  Created by Mac on 13-9-28.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "LookUpAllPicViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
@interface LookUpAllPicViewController ()

@end

@implementation LookUpAllPicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

static int count=0;
-(void)getAllPictures

{
    
    _imageArray=[[NSArray alloc] init];
    
    mutableArray =[[NSMutableArray alloc]init];
    
    NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
    
    
    
    library = [[ALAssetsLibrary alloc] init];
    
    
    
    void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if(result != nil) {
            
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                
                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                
                
                
                NSURL *url= (NSURL*) [[result defaultRepresentation]url];
                
                
                
                [library assetForURL:url
                 
                         resultBlock:^(ALAsset *asset) {
                             
                             [mutableArray addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
                             
                             
                             
                             if ([mutableArray count]==count)
                                 
                             {
                                 
                                 _imageArray=[[NSArray alloc] initWithArray:mutableArray];
                                 
                                 [self allPhotosCollected:_imageArray];
                                 
                             }
                             
                         }
                 
                        failureBlock:^(NSError *error){ NSLog(@"operation was not successfull!"); } ];
                
                
                
            }
            
        }
        
    };
    
    
    
    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
    
    
    
    void (^ assetGroupEnumerator) ( ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
        
        if(group != nil) {
            
            [group enumerateAssetsUsingBlock:assetEnumerator];
            
            [assetGroups addObject:group];
            
            count=[group numberOfAssets];
            
        }
        
    };
    
    
    
    assetGroups = [[NSMutableArray alloc] init];
    
    
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
     
                           usingBlock:assetGroupEnumerator
     
                         failureBlock:^(NSError *error) {NSLog(@"There is an error");}];
    
    [pictabView reloadData];
    
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
{  //显示全部图片的flag
    a=-1;
    
    //选取图片的flag
    flag=-1;
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)navBtnClick
{
    NSLog(@"Next");
    
    if ([arr count]==3) {
       // AddPicViewController*add=[[AddPicViewController alloc]init];
       // add.flag_num=self.fag_number;
        
       // add.picarr=arr;
        
      //  [self.navigationController pushViewController:add animated:YES];
    }
    if ([arr count]==4) {
      //  AddFourViewController *four = [[AddFourViewController alloc]init];
        
        //four.flag_num=self.fag_number;
        
        //four.picarr=arr;
       // [self.navigationController pushViewController:four animated:YES];
    }
    
    if ([arr count]==5) {
        //AddFivePicViewController *four = [[AddFivePicViewController alloc]init];
        
       // four.flag_num=self.fag_number;
        
       // four.picarr=arr;
       // [self.navigationController pushViewController:four animated:YES];
    }
    
}

-(void)allPhotosCollected:(NSArray*)imgArray

{
    
    //write your code here after getting all the photos from library...
    
    NSLog(@"all pictures are %@",imgArray);
    
    //    for (int  a=0; a<[imgArray count]; a++)
    //    {
    //
    //        UIImageView*img1=[[UIImageView alloc]initWithFrame:CGRectMake(a*110,0,100, 100)];
    //        img1.image=[imageArray objectAtIndex:a];
    //        [self.view addSubview:img1];
    //
    //    }
    
    [pictabView reloadData];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavgationBar];
    [self getAllPictures];
    
    // 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    imageViewBackGround.userInteractionEnabled = YES;
    [self.view addSubview:imageViewBackGround];
    UIView *mm_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-64-20-44-10)];
    mm_view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    [imageViewBackGround addSubview:mm_view];
    
    
    pictabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 24, 320, self.view.frame.size.height-64-20-44-10)];
    pictabView.backgroundColor = [UIColor clearColor];
    pictabView.delegate = self;
    pictabView.separatorStyle = NO;
    pictabView.dataSource = self;
    
    [mm_view addSubview:pictabView];
    
    self.scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-64-20-22.5, 320, 75)] ;
    self.scrolView.delegate = self;
    self.scrolView.contentSize = CGSizeMake(500+100, 75);
    self.scrolView.backgroundColor = [UIColor clearColor];
    [imageViewBackGround addSubview:self.scrolView];
	// Do any additional setup after loading the view.
}
#pragma mark - Table view data source

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
    
    if ([_imageArray count]%4==0) {
        return [_imageArray count]%4;
    }
    else
        return [_imageArray count]/4+1;
}
static int a=-1;
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


static int flag=-1;

-(void)pic:(UIButton*)sender
{
    flag++;
    if (flag<5)
    {
        [arr addObject:[_imageArray objectAtIndex:sender.tag-1000]];
        self.fag_number=flag+1;
        UIImageView * img3 = [[UIImageView alloc]initWithFrame:CGRectMake(10+flag*85, 0, 75, 75)];
        //img3.image=[imageArray objectAtIndex:[sender.tag-1000]];
        img3.image = [_imageArray objectAtIndex:sender.tag-1000];
        [self.scrolView addSubview:img3];
    }
    else
    {
        
        UIAlertView *view =[[UIAlertView alloc]initWithTitle:@"提示" message:@"最多可选取5张图片" delegate:self cancelButtonTitle:@"yes" otherButtonTitles:@"确定", nil];
        [view show];
        
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    for (int i = 0; i<4; i++)
        
    {
        a++;
        
        NSLog(@"============%d",a);
        if (a<=[_imageArray count]-1) {
            
            
            
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            btn.frame = CGRectMake(2+i*79, 4, 75, 75);
            
            [btn setBackgroundImage:[_imageArray objectAtIndex:a] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(pic:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 1000+a;
            NSLog(@"---------------%d",btn.tag);
            [cell.contentView addSubview:btn];}
    }
    
    return cell;
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
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
