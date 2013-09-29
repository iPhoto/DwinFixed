//
//  NSObject_Global.h
//  ScenicGuide
//
//  Created by xf.lai on 13-7-31.
//  Copyright (c) 2013年 xf.lai. All rights reserved.
//

#if	1
#define DLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define DLog(format, ...)
#endif

/**
 * AppDelegate
 */
#define MyAppDelegate	 ((AppDelegate *)([UIApplication sharedApplication].delegate))
#define kTabBarHeight     45.0f//tabbar高度


/*
 * 标记首次启动应用
 */
#define kEverLanched    @"everLaunched"
#define kFirstLanched    @"firstLaunched"