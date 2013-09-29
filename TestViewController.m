//
//  TestViewController.m
//  DWin1.0
//
//  Created by zang qilong on 13-9-15.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "TestViewController.h"
#import "GetStaticImage.h"
#import "DRNRealTimeBlurView.h"
#import "GoogleMaps.h"
#import "ZXMacro.h"
#import "ImageUtil.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

# pragma mark -NavgationCotroller Delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"hello");
    
//        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1.000];
//        // 透明度设置为0.3
//        self.navigationController.navigationBar.alpha = 0.30;
//        // 设置为半透明
//        self.navigationController.navigationBar.translucent = YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    // tabbar
    UIView *userTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, 82, 320, 50)];
    userTabBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:userTabBar];
    // 用户选项
    UIButton *btn_comment = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_comment.frame = CGRectMake(10, 9, 100, 30);
    [btn_comment setTitle:@"Moment" forState:UIControlStateNormal];
    [btn_comment addTarget:self action:@selector(moveWhiteBlock:) forControlEvents:UIControlEventTouchUpInside];
    [btn_comment setBackgroundImage:[UIImage imageNamed:@"friendlist_moment"] forState:UIControlStateNormal];
    [userTabBar addSubview:btn_comment];
    
    UIButton *btn_activity = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_activity.frame = CGRectMake(110, 9, 100, 30);
    [btn_activity addTarget:self action:@selector(moveWhiteBlock:) forControlEvents:UIControlEventTouchUpInside];
    [btn_activity setBackgroundImage:[UIImage imageNamed:@"friendlist_activity"] forState:UIControlStateNormal];
    [userTabBar addSubview:btn_activity];
    
    UIButton *btn_map = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_map addTarget:self action:@selector(moveWhiteBlock:) forControlEvents:UIControlEventTouchUpInside];
    btn_map.frame = CGRectMake(210, 9, 100, 30);
    [btn_map setTitle:@"Map" forState:UIControlStateNormal];
    [btn_map setBackgroundImage:[UIImage imageNamed:@"friendlist_map"] forState:UIControlStateNormal];
    [userTabBar addSubview:btn_map];
    // 上拉下拉标志
    UIImageView *imageArrowUpDown = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width/2, 0, 10, 5)];
    imageArrowUpDown.image = [UIImage imageNamed:@"friendlist_uparrow"];
    [userTabBar addSubview:imageArrowUpDown];
        
       
}

- (void)moveWhiteBlock:(UIButton *)sender
{
    
}


- (void)btn_play
{
    NSError *playerError;
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:recordFile error:&playerError];
    
    if (player == nil)
    {
        NSLog(@"ERror creating player: %@", [playerError description]);
    }
    player.delegate = self;
    [player play];
}

- (UIImage *)createBlurImage:(UIImage *)image
{
    CGImageRef cgimg = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, 320, 240));
    UIImage *imageNew = [UIImage imageWithCGImage:cgimg];
    return imageNew;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
