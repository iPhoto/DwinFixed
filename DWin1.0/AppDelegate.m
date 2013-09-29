//
//  AppDelegate.m
//  DWin1.0
//
//  Created by zang qilong on 13-9-12.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "AppDelegate.h"
#import "FriendListViewController.h"
#import "TestViewController.h"
#import "ZXMacro.h"
#import "TextEditViewController.h"
#import "GetStaticImage.h"
#import "LeftSideViewController.h"
#import "IIViewDeckController.h"
#import "RecordingViewController.h"
#import "TheFirstViewController.h"
#import "TestViewController.h"
#import "TVShowViewController.h"
#import "MapViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[MapViewController alloc] init]];
  // self.window.rootViewController = [[TestViewController alloc] init] ;
    //self.window.rootViewController = nav;
     IIViewDeckController* deckController = [self generateControllerStack];
  self.window.rootViewController = deckController;
    [self setNavigationBar];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark -setNavigationBar
- (void)setNavigationBar
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:kScreen_Frame];
    imageview.image = [UIImage imageNamed:@"friendlistbg1"];
    GetStaticImage *getview = [[GetStaticImage alloc] initWithFatherView:imageview withRect:CGRectMake(0, 0, 320, 44) withBlurRadius:0.3];
    UIImage *imageNew = getview.imageSteal;
    [[UINavigationBar appearance] setBackgroundImage:imageNew forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes: @{UITextAttributeTextColor: [UIColor whiteColor],
                                     UITextAttributeFont: [UIFont fontWithName:HELVETICANUEU size:25]}];
}

- (IIViewDeckController*)generateControllerStack {
    LeftSideViewController* leftController = [[LeftSideViewController alloc] init];
        
    UIViewController *centerController = [[FriendListViewController alloc] init];
    centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:centerController leftViewController:leftController];
    //deckController.rightSize = 100;
    deckController.leftSize = 160;
    [deckController disablePanOverViewsOfClass:NSClassFromString(@"_UITableViewHeaderFooterContentView")];
    return deckController;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
