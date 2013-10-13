//
//  FriendListViewController.m
//  DWin1.0
//
//  Created by zang qilong on 13-9-12.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//
#import "MomentDetailViewController.h"
#import "MySpaceViewController.h"
#import "FriendListViewController.h"
#import "FriendInfoCell.h"
#import "TextEditViewController.h"
#import "GBPathImageView.h"
#import "IIViewDeckController.h"
#import "LoginViewController.h"
#import "TheFirstViewController.h"
#import "DetailsView.h"
#import "PinAnnotation.h"
#import "PinAnnotationView.h"
#import "DetailsAnnotation.h"
#import "DetailsAnnotationView.h"
#import "MKMapView+MapViewUtil.h"
#define kTabAlreadyDownUserViewY 0
#define kTabAlreadyUpUserViewY -80
#define kScrollAlreadyUp 50
#define kScrollAlreadyDown 130


#define  spaceFNum  0.003
#define  oriZoomLevel 12.
#define oriSpan   MKCoordinateSpanMake(0.00494, 0.00538)
#define oriCenterCoordinate  CLLocationCoordinate2DMake(30.658273, 104.067864)
@interface FriendListViewController ()
{
    PinAnnotation       *_pinAnnotation;
    DetailsAnnotation   *_detailsAnnotation;
    NSMutableArray      *_detailsAnnoArray;
}
@end

@implementation FriendListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

# pragma mark -NavgationCotroller Delegate
-(void)initData
{
    self.dataArray = [NSMutableArray array];//弹出气泡的数据Array
    // [self.dataArray addObject:@"12345"];
    //child item
    NSMutableArray *childAry = [NSMutableArray array];
    for (int i=0; i<8; i++) {
        MapItemInfoVO *child = [[MapItemInfoVO alloc]init];
        child.strId = [NSString stringWithFormat:@"%d",i];
        child.strTitle = [NSString stringWithFormat:@"child%d",i];
        [childAry addObject:child];
    }
    
    //item
    for (int j=0; j<8; j++) {
        MapItemInfoVO *item = [[MapItemInfoVO alloc]init];
        item.strId = [NSString stringWithFormat:@"%d",j];
        item.strTitle = [NSString stringWithFormat:@"Item%d",j];
        item.strDetails = @"hi";
        NSMutableArray *ary = [NSMutableArray array];
        
        int childCount = 3;
        for (int n=0; n<childCount; n++) {
            if (n<[childAry count]) {
                [ary addObject:[childAry objectAtIndex:n]];
            }
        }
        item.aryChild = ary; //小泡泡数据Array，决定了小泡泡个数及显示内容等
        [self.dataArray addObject:item];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    _detailsAnnoArray = [[NSMutableArray alloc]init];
    newLocCoordinate = oriCenterCoordinate;
    [self setupView];
  
    NSLog(@"screen %lf",kScreen_Height);
    NSLog(@"application screen %lf",kContent_Height);
	// Do any additional setup after loading the view.
    
    
    //jieshoutongzhi 
     [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (mytest1) name:@"xiangzuo" object:nil];
}

//进入个人信息详细界面
-(void)mytest1
{
    MySpaceViewController *soace = [[MySpaceViewController alloc]init];
    [self.navigationController pushViewController:soace animated:YES];



}
#pragma mark -create NavigationBar
- (void)setNavgationBar
{
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
    // 导航条右按钮
    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_right.frame = CGRectMake(0, 0, 27, 27);
    [btn_right setBackgroundImage:[UIImage imageNamed:@"friendlist_nav_rightbar"] forState:UIControlStateNormal];
    btn_right.tag=2;
    [btn_right addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
    self.navigationItem.rightBarButtonItem = rightBar;
}

#pragma mark -Setup View

- (void)setupView
{
    //设置 navigationbar
    self.view.userInteractionEnabled = YES;
    [self setNavgationBar];
    self.navigationItem.title = @"DWin";
    // 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    [self.view addSubview:imageViewBackGround];
    // 设置高度
    getViewHeight = 0;
    
    // 用户信息
    UIImageView *imageViewBackGround2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    NSLog(@"%f",kScreen_Height);
    imageViewBackGround2.image = [UIImage imageNamed:@"friendlistbg1"];

   userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, kTabAlreadyUpUserViewY, kScreen_Width, 130)];
    UIImage *imageUserInfobg = [DWinUtils getBlurImage:imageViewBackGround2 withRect:CGRectMake(0, 64, kScreen_Width, 130) WithRadius:0.3];
    imageViewBackGround2.frame = CGRectMake(0, 0, kScreen_Width, 130);
    imageViewBackGround2.image = imageUserInfobg;
    [userInfoView addSubview:imageViewBackGround2];
    userInfoView.userInteractionEnabled = YES;
    [self.view addSubview:userInfoView];
    // 添加手势
    UITapGestureRecognizer *swipeGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    //[swipeGes setDirection:UISwipeGestureRecognizerDirectionDown];
    swipeGes.numberOfTapsRequired = 1;
    [userInfoView addGestureRecognizer:swipeGes];
    // 用户头像
    UIImage *roundImage = [self makeRoundedImage:[UIImage imageNamed:@"user_headpic"] radius:55/2];
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 12, 55, 55)];
    headImageView.image = roundImage;
    headImageView.layer.cornerRadius = 55/2;
    headImageView.layer.masksToBounds = YES;
    headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [userInfoView addSubview:headImageView];
    // 用户姓名
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(75, 20, 100, 20)];
    userName.backgroundColor = [UIColor clearColor];
    userName.font = [UIFont fontWithName:HELVETICANUEU size:14];
    userName.textColor = [UIColor whiteColor];
    userName.text = @"Mike Jordon";
    [userInfoView addSubview:userName];
    // 用户性别
    UIImageView *imageView_sex = [[UIImageView alloc] initWithFrame:CGRectMake(75, 42,5, 8)];
    imageView_sex.image = [UIImage imageNamed:@"friendlist_male"];
    [userInfoView addSubview:imageView_sex];
    UILabel *label_sex = [DWinUtils createLabelForAutoSize:CGPointMake(84, 41) WithContent:@"Female" WithFontSize:10 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor blackColor]];
    label_sex.backgroundColor = [UIColor clearColor];
    [userInfoView addSubview:label_sex];
    // 用户职业
    UILabel *label_Job = [[UILabel alloc] initWithFrame:CGRectMake(120, 42, 100, 10)];
    label_Job.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:10];
    label_Job.backgroundColor = [UIColor clearColor];
    label_Job.textColor = [UIColor whiteColor];
    label_Job.text = [NSString stringWithFormat:@"Job:%@",@"student"];
    [userInfoView addSubview:label_Job];
    // tabbar
    userTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, 82, 320, 50)];
    userTabBar.backgroundColor = [UIColor clearColor];
    [userInfoView addSubview:userTabBar];
    // 白色方块
    whiteBlock = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 100, 30)];
    whiteBlock.image = [UIImage imageNamed:@"friendlist_whiteblock"];
    [userTabBar addSubview:whiteBlock];
    // 用户选项
    btn_comment = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_comment.frame = CGRectMake(10, 9, 100, 30);
    //[btn_comment setTitle:@"Moment" forState:UIControlStateNormal];
    btn_comment.tag=1;
    [btn_comment addTarget:self action:@selector(moveWhiteBlock:) forControlEvents:UIControlEventTouchUpInside];
    [btn_comment setBackgroundImage:[UIImage imageNamed:@"friendlist_momentselected"] forState:UIControlStateNormal];
    [userTabBar addSubview:btn_comment];
    
    //
    btn_activity = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_activity.frame = CGRectMake(110, 9, 100, 30);
    btn_activity.tag=2;
    [btn_activity addTarget:self action:@selector(moveWhiteBlock:) forControlEvents:UIControlEventTouchUpInside];
    [btn_activity setBackgroundImage:[UIImage imageNamed:@"friendlist_activity"] forState:UIControlStateNormal];
    [userTabBar addSubview:btn_activity];
    
    btn_map = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_map.frame = CGRectMake(210, 9, 100, 30);
    btn_map.tag=3;
    [btn_map addTarget:self action:@selector(moveWhiteBlock:) forControlEvents:UIControlEventTouchUpInside];
    //[btn_map setTitle:@"Map" forState:UIControlStateNormal];
    [btn_map setBackgroundImage:[UIImage imageNamed:@"friendlist_map"] forState:UIControlStateNormal];
    [userTabBar addSubview:btn_map];
    // 上拉下拉标志
    UIImageView *imageArrowUpDown = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width/2, 0, 10, 5)];
    imageArrowUpDown.image = [UIImage imageNamed:@"friendlist_uparrow"];
    [userTabBar addSubview:imageArrowUpDown];
    // 设置tableview
    getViewHeight = getViewHeight+userInfoView.frame.size.height;
    [self setTableView];
    // 设置转盘
    [self createControlPanel];
  
   
}

- (void)moveWhiteBlock:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            [UIView animateWithDuration:0.2 animations:^{
                whiteBlock.frame = CGRectMake(10, 9, 100, 30);
            }];
            [btn_comment setBackgroundImage:[UIImage imageNamed:@"friendlist_momentselected"] forState:UIControlStateNormal];
            [btn_activity setBackgroundImage:[UIImage imageNamed:@"friendlist_activity"] forState:UIControlStateNormal];
            [btn_map setBackgroundImage:[UIImage imageNamed:@"friendlist_map"] forState:UIControlStateNormal];
            [userTabBar sendSubviewToBack:whiteBlock];
            if (_mTableView ==nil) {
                [self setTableView];
                _mTableView.frame = CGRectMake(0, _mTableView.frame.origin.y,kScreen_Width ,kScreen_Height) ;
                [_mapView removeFromSuperview];
               
            }else
            {
                _mTableView.frame = CGRectMake(0, _mTableView.frame.origin.y, kScreen_Width, kScreen_Height);
                [_mapView removeFromSuperview];
                [self.view addSubview:_mTableView];
            }
        }
            [controlView removeFromSuperview];
            break;
        case 2:
        {
            [UIView animateWithDuration:0.2 animations:^{
                whiteBlock.frame = CGRectMake(110, 9, 100, 30);
            }];
            [btn_comment setBackgroundImage:[UIImage imageNamed:@"friendlist_moment"] forState:UIControlStateNormal];
            [btn_activity setBackgroundImage:[UIImage imageNamed:@"friendlist_activityselected"] forState:UIControlStateNormal];
            [btn_map setBackgroundImage:[UIImage imageNamed:@"friendlist_map"] forState:UIControlStateNormal];
            [controlView removeFromSuperview];
        }
            break;
        case 3:
        {
            [UIView animateWithDuration:0.2 animations:^{
                whiteBlock.frame = CGRectMake(210, 9, 100, 30);
            }];
            [btn_comment setBackgroundImage:[UIImage imageNamed:@"friendlist_moment"] forState:UIControlStateNormal];
            [btn_activity setBackgroundImage:[UIImage imageNamed:@"friendlist_activity"] forState:UIControlStateNormal];
            [btn_map setBackgroundImage:[UIImage imageNamed:@"friendlist_mapselected"] forState:UIControlStateNormal];
            if (_mapView ==nil) {
                _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(10, _mTableView.frame.origin.y, 300, kGetViewHeight(_mTableView))];
                _mapView.showsUserLocation = YES;
                _mapView.delegate = self;
               
                [_mTableView removeFromSuperview];
                [self.view addSubview:_mapView];
            }else
            {
                _mapView.frame = CGRectMake(10, _mTableView.frame.origin.y, 300, kGetViewHeight(_mTableView));
                [_mTableView removeFromSuperview];
                [self.view addSubview:_mapView];
            }
        }
            [controlView removeFromSuperview];
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = (CLLocation *)[locations lastObject];
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"gestures work");
    [UIView animateWithDuration:0.5 animations:^{
        userInfoView.frame = CGRectMake(0, kTabAlreadyUpUserViewY, kScreen_Width, 130);
        _mTableView.frame = CGRectMake(0, kScrollAlreadyUp, kScreen_Width, kScreen_Height);
        
    }];
}

#pragma mark -init TableView
- (void)setTableView
{
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScrollAlreadyUp, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    
    _mTableView.backgroundColor = [UIColor clearColor];
    _mTableView.dataSource = self;
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mTableView];
}

#pragma mark - tableview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f,%f",_mTableView.contentOffset.x,_mTableView.contentOffset.y);
    if (_mTableView.contentOffset.y<-100) {
        [UIView animateWithDuration:0.5 animations:^{
            userInfoView.frame = CGRectMake(0, kTabAlreadyDownUserViewY, kScreen_Width, 130);
            _mTableView.frame = CGRectMake(0, kScrollAlreadyDown, kScreen_Width, kScreen_Height);

        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"FriendInfoCell";
    FriendInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell = [[FriendInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
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
    MomentDetailViewController *moment=[[MomentDetailViewController alloc]init];
    
    [self.navigationController pushViewController:moment animated:YES];

    
}

#pragma mark -GetRoundImage
-(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) radius;
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

#pragma mark - createControlPanel
- (void)createControlPanel
{
    controlView = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x, 194, 0, 0)];
    //controlView.center = CGPointMake(self.view.center.x, 194);
    controlView.layer.cornerRadius = 0;
    controlView.layer.masksToBounds = YES;
    controlView.backgroundColor =[UIColor colorWithWhite:0.9 alpha:0.5];
    [self.view addSubview:controlView];
    // 添加按钮
    UIButton *btn_text = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_text.frame = CGRectMake(88, 0, 48, 48);
    [btn_text setBackgroundImage:[UIImage imageNamed:@"friendlist_textdial"] forState:UIControlStateNormal];
    btn_text.tag = 1000;
    [btn_text addTarget:self action:@selector(dialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:btn_text];
    // 走路
    UIButton *btn_walk = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_walk.frame = CGRectMake(12, 44, 48, 48);
    [btn_walk setBackgroundImage:[UIImage imageNamed:@"friendlist_walkdial"] forState:UIControlStateNormal];
    btn_walk.tag = 1001;
    [btn_walk addTarget:self action:@selector(dialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:btn_walk];
    // 分割线
    UIButton *btn_line = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_line.frame = CGRectMake(12, 132, 48, 48);
    [btn_line setBackgroundImage:[UIImage imageNamed:@"friendlist_linedial"] forState:UIControlStateNormal];
    btn_line.tag = 1002;
    [btn_line addTarget:self action:@selector(dialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:btn_line];
    // voice
    UIButton *btn_voice = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_voice.frame = CGRectMake(88, 177, 48, 48);
    [btn_voice setBackgroundImage:[UIImage imageNamed:@"friendlist_audiodial"] forState:UIControlStateNormal];
    btn_voice.tag = 1003;
    [btn_voice addTarget:self action:@selector(dialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:btn_voice];
    // video
    UIButton *btn_video = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_video.frame = CGRectMake(165, 132, 48, 48);
    [btn_video setBackgroundImage:[UIImage imageNamed:@"friendlist_videodial"] forState:UIControlStateNormal];
    btn_video.tag = 1004;
    [btn_video addTarget:self action:@selector(dialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:btn_video];
    // photo
    UIButton *btn_photo = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_photo.frame = CGRectMake(165, 44, 48, 48);
    [btn_photo setBackgroundImage:[UIImage imageNamed:@"friendlist_photodial"] forState:UIControlStateNormal];
    btn_photo.tag = 1005;
    [btn_photo addTarget:self action:@selector(dialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:btn_photo];
    // cancel
    UIButton *btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_cancel.frame = CGRectMake(0, 0, 48, 48);
    btn_cancel.center = CGPointMake(113, 113);
    [btn_cancel setBackgroundImage:[UIImage imageNamed:@"friendlist_canceldial"] forState:UIControlStateNormal];
    btn_cancel.tag = 1006;
    //btn_cancel.alpha = 0.7;
    [btn_cancel addTarget:self action:@selector(dialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:btn_cancel];
}
-(void)obseve
{



}

- (void)dialBtnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 1000:
        {
            TextEditViewController *text = [[TextEditViewController alloc] init];
            text.controlImageType = 6;
            [self.navigationController pushViewController:text animated:YES];
            break;
        }
        case 1001:
            
            break;
        case 1002:
            
            break;
        case 1003:
        {
            TextEditViewController *text = [[TextEditViewController alloc] init];
            text.controlImageType = 3;
            [self.navigationController pushViewController:text animated:YES];
            break;
        }
        
        case 1004:
        {
            TextEditViewController *text = [[TextEditViewController alloc] init];
            text.controlImageType = 2;
            [self.navigationController pushViewController:text animated:YES];
            break;
        }
        case 1005:
        {
            TextEditViewController *text = [[TextEditViewController alloc] init];
            text.controlImageType = 1;
            [self.navigationController pushViewController:text animated:YES];
            break;
        }
        case 1006:
        {
            [UIView animateWithDuration:0.5 animations:^{
                controlView.frame = CGRectMake(47, 130, 0, 0);
                [controlView removeFromSuperview];
            }];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Methods
-(void)segmentValueChanged
{
    if (_pinAnnotation && [_detailsAnnoArray count]>0) {
        
        if ([_detailsAnnoArray count]>0) {
            
            DetailsAnnotation *last = [_detailsAnnoArray lastObject];
            
            PinAnnotationView *pV = (PinAnnotationView *)[_mapView viewForAnnotation:_pinAnnotation];
            DetailsAnnotationView *dV = (DetailsAnnotationView *)[_mapView viewForAnnotation:last];
            [dV.superview bringSubviewToFront:dV];
            [pV.superview bringSubviewToFront:pV];
            
            
            DetailsAnnotationView *annoView = (DetailsAnnotationView *)[_mapView viewForAnnotation:last];
            [annoView.cell disappearItems:^{
                [_mapView removeAnnotation:last];
                [_detailsAnnoArray removeLastObject];
                
                if ([_detailsAnnoArray count]>0) {
                    _detailsAnnotation = [_detailsAnnoArray objectAtIndex:0];
                }
                else
                {
                    _detailsAnnotation = nil;
                }
                
                [self mapView:self.mapView didSelectAnnotationView:[self.mapView viewForAnnotation:_pinAnnotation]];
                
            }];
            
        }
        
        
    }
    
    
}
-(void)clickItemButton:(ItemView *)btn
{
    
    DLog(@"Click item button _ %d--------------------------------------------",btn.tag);
    
}

-(void)removeAllAnnotations
{
    id userAnnotation = _mapView.userLocation;
    
    NSMutableArray *annotations = [NSMutableArray arrayWithArray:_mapView.annotations];
    [annotations removeObject:userAnnotation];
    
    [_mapView removeAnnotations:annotations];
}

//随意放几个测试数据
-(void)placeTempPins
{
    if (_pinAnnotation) {
        [_mapView deselectAnnotation:_pinAnnotation animated:NO];
    }
    [self removeAllAnnotations];
    
    PinAnnotation *pinAnno = [[PinAnnotation alloc]initWithLatitude: newLocCoordinate.latitude andLongitude:newLocCoordinate.longitude];
    
    [_mapView addAnnotation:pinAnno];
    PinAnnotation *pinAnno1 = [[PinAnnotation alloc]initWithLatitude: newLocCoordinate.latitude-0.1 andLongitude:newLocCoordinate.longitude];
    [_mapView addAnnotation:pinAnno1];
    PinAnnotation *pinAnno2 = [[PinAnnotation alloc]initWithLatitude: newLocCoordinate.latitude-0.2 andLongitude:newLocCoordinate.longitude];
    [_mapView addAnnotation:pinAnno2];
    PinAnnotation *pinAnno3 = [[PinAnnotation alloc]initWithLatitude: newLocCoordinate.latitude-0.3 andLongitude:newLocCoordinate.longitude];
    [_mapView addAnnotation:pinAnno3];
    PinAnnotation *pinAnno4 = [[PinAnnotation alloc]initWithLatitude: newLocCoordinate.latitude-0.4 andLongitude:newLocCoordinate.longitude];
    [_mapView addAnnotation:pinAnno4];
    PinAnnotation *pinAnno5 = [[PinAnnotation alloc]initWithLatitude: newLocCoordinate.latitude-0.5 andLongitude:newLocCoordinate.longitude];
    [_mapView addAnnotation:pinAnno5];
   
    
}
-(void)setMapRegin:(CLLocationCoordinate2D)coordinate
{
    newLocCoordinate = coordinate;
    double level = [_mapView getZoomLevel];
    if (level<oriZoomLevel) {
        level = oriZoomLevel;
    }
    
    [_mapView setCenterCoordinate:newLocCoordinate zoomLevel:level animated:YES];
    
    [self placeTempPins];
    
}

#pragma mark LOCATION
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    newLocCoordinate = userLocation.coordinate;
    
    [self setMapRegin:newLocCoordinate];
    
    self.mapView.showsUserLocation = NO;
	
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
	if (error != nil)
		DLog(@"locate failed: %@", [error localizedDescription]);
	else {
		DLog(@"locate failed");
	}
	
}

- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView
{
	DLog(@"start locate");
}

#pragma mark  Range
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    if ([_detailsAnnoArray count]>0) {
        DetailsAnnotation *first = [_detailsAnnoArray objectAtIndex:0];
        PinAnnotationView *pV = (PinAnnotationView *)[mapView viewForAnnotation:_pinAnnotation];
        DetailsAnnotationView *dV = (DetailsAnnotationView *)[mapView viewForAnnotation:first];
        [dV.superview bringSubviewToFront:dV];
        [pV.superview bringSubviewToFront:pV];
    }
    
    DLog(@"【移动哦ing】");
    
    if (!_detailsAnnotation) {
        return;
    }
    
    CGPoint pinPoint = [mapView convertCoordinate:_detailsAnnotation.coordinate toPointToView:self.view];
    BOOL bContains  = CGRectContainsPoint(self.view.bounds, pinPoint);
    
    if (bContains) {
        DetailsAnnotationView *annoView = (DetailsAnnotationView *)[mapView viewForAnnotation:_detailsAnnotation];
        CGPoint center = self.view.center;//[mapView convertCoordinate:_mapView.centerCoordinate toPointToView:self.view];
        CGFloat angle = [Utils getAngleByPoint:pinPoint center:center];
        [annoView.cell rotationViews:angle];
    }
    else{
        [_mapView deselectAnnotation:_pinAnnotation animated:NO];
    }
    
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    
    if ([_detailsAnnoArray count]>0) {
        DetailsAnnotation *first = [_detailsAnnoArray objectAtIndex:0];
        PinAnnotationView *pV = (PinAnnotationView *)[mapView viewForAnnotation:_pinAnnotation];
        DetailsAnnotationView *dV = (DetailsAnnotationView *)[mapView viewForAnnotation:first];
        [dV.superview bringSubviewToFront:dV];
        [pV.superview bringSubviewToFront:pV];
    }
    
    DLog(@"【将开始移动哦】");
    if (_detailsAnnotation) {
        
        
        CGPoint pinPoint = [mapView convertCoordinate:_detailsAnnotation.coordinate toPointToView:self.view];
        BOOL bContains  = CGRectContainsPoint(self.view.bounds, pinPoint);
        if (!bContains) {
            [_mapView deselectAnnotation:_pinAnnotation animated:NO];
        }
        
    }
    
    
    
}
#pragma mark Annotation
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
{
    DLog(@"【didChangeDragState】");
}
//选中MKAnnotationView
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
	if ([view.annotation isKindOfClass:[PinAnnotation class]]) {
        
        if (_detailsAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _detailsAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            return;
        }
        
        _pinAnnotation = (PinAnnotation *)view.annotation;
        
        DetailsAnnotation *detailsAnno = [[DetailsAnnotation alloc]
                                          initWithLatitude:view.annotation.coordinate.latitude
                                          andLongitude:view.annotation.coordinate.longitude];
        
        [mapView addAnnotation:detailsAnno];
        
        
        
        
        [_detailsAnnoArray insertObject:detailsAnno atIndex:0];
        
        if (!_detailsAnnotation) {
            _detailsAnnotation = detailsAnno;
        }
        
    }
    
    
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
    if ([_detailsAnnoArray count]>0) {
        
        DetailsAnnotation *last = [_detailsAnnoArray lastObject];
        
        PinAnnotationView *pV = (PinAnnotationView *)[mapView viewForAnnotation:_pinAnnotation];
        DetailsAnnotationView *dV = (DetailsAnnotationView *)[mapView viewForAnnotation:last];
        [dV.superview bringSubviewToFront:dV];
        [pV.superview bringSubviewToFront:pV];
        
        
        DetailsAnnotationView *annoView = (DetailsAnnotationView *)[mapView viewForAnnotation:last];
        [annoView.cell disappearItems:^{
            [mapView removeAnnotation:last];
            [_detailsAnnoArray removeLastObject];
            
            if ([_detailsAnnoArray count]>0) {
                _detailsAnnotation = [_detailsAnnoArray objectAtIndex:0];
            }
            else
            {
                _detailsAnnotation = nil;
            }
            
        }];
        
    }
    NSLog(@"de selecte");
    
}
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    //层次次序
    PinAnnotationView *pV = (PinAnnotationView *)[mapView viewForAnnotation:_pinAnnotation];
    DetailsAnnotationView *dV = (DetailsAnnotationView *)[mapView viewForAnnotation:_detailsAnnotation];
    [dV.superview bringSubviewToFront:dV];
    [pV.superview bringSubviewToFront:pV];
}

//设置MKAnnotation上的annotationView
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	
    if ([annotation isKindOfClass:[DetailsAnnotation class]]) {
        
        DetailsAnnotation *anno = (DetailsAnnotation *)annotation;
        _detailsAnnotation = anno;
        NSUInteger num = anno.tag;
        DetailsAnnotationView *annotationView =(DetailsAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"DetailsAnnotationView"];
        if (!annotationView) {
            
            annotationView = [[DetailsAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"DetailsAnnotationView"];
        }
        annotationView.tag = num;
        MapItemInfoVO *vo = [self.dataArray objectAtIndex:num];
        [annotationView setCellUI:vo];
        
        CGPoint selectCenter =[mapView convertCoordinate:annotation.coordinate toPointToView:self.view];
        CGPoint center =self.view.center;//[mapView convertCoordinate:_mapView.centerCoordinate toPointToView:self.view];
        CGFloat angle = [Utils getAngleByPoint:selectCenter center:center];
        CGPoint newCenter = CGPointMake(annotationView.cell.center.x - (annotationView.cell.bounds.size.width/2 * sin(angle)), annotationView.cell.center.y - (annotationView.cell.bounds.size.width/2 * cos(angle)));
        
        
        [annotationView.cell toAppearItemsView:newCenter angle:angle];
        [annotationView.cell setDetailsViewBlock:^(ItemView *btn) {
            [self clickItemButton:btn];
        }];
        
        return annotationView;
        
	}
    else if ([annotation isKindOfClass:[PinAnnotation class]]) {
       
        PinAnnotation *anno = (PinAnnotation *)annotation;
        NSUInteger num = anno.tag;
        static int countnum = 0;
        NSLog(@"anno tag is %d",countnum);
        PinAnnotationView *annotationView =(PinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PinAnnotationView"];
        if (!annotationView) {
            
            annotationView = [[PinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PinAnnotationView"];
            switch (countnum) {
                case 0:
                    annotationView.imgView.image = [UIImage imageNamed:@"mapview_tagshopping"];
                    break;
                case 1:
                    annotationView.imgView.image = [UIImage imageNamed:@"mapview_tagclassifieds"];
                    break;
                case 2:
                    annotationView.imgView.image = [UIImage imageNamed:@"mapview_tagjob"];
                    break;
                case 3:
                    annotationView.imgView.image = [UIImage imageNamed:@"mapview_tagmoment"];
                    break;
                case 4:
                    annotationView.imgView.image = [UIImage imageNamed:@"mapview_taglight"];
                    break;
                case 5:
                    annotationView.imgView.image = [UIImage imageNamed:@"mapview_tagwardrobe"];
                    break;
                default:
                    break;
            }
            
            countnum++;
        }
        annotationView.tag = num;
        return annotationView;
        
    }
	return nil;
}


#pragma mark -Button Action

- (void)navBtnClick:(UIButton *)sender
{
    if (sender.tag==2) {
        if (controlView) {
            [self.view bringSubviewToFront:controlView];
            [self.view addSubview:controlView];
            [UIView animateWithDuration:0.5 animations:^{
                controlView.frame = CGRectMake(47, 130, 226, 226);
                controlView.layer.cornerRadius = 113;
            }];
        }else
        {
            [self createControlPanel];
            [UIView animateWithDuration:0.5 animations:^{
                controlView.frame = CGRectMake(47, 130, 226, 226);
                controlView.layer.cornerRadius = 113;
            }];
        }
        
    }
    
}

                                                                                            
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
