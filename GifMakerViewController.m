//
//  GifMakerViewController.m
//  DWin1.0
//
//  Created by zang qilong on 13-9-20.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

// 缓存图片路径
#define FD_IMAGE_PATH(file) [NSString stringWithFormat:@"%@/Documents/image/%@",NSHomeDirectory(),file]
#import "GifMakerViewController.h"
#import "AppDelegate.h"
//#import "ViewController.h"
#import "FreeGifMaker.h"
#import "ANGifBitmap.h"
#import "ANGifEncoder.h"
#import "ANImageBitmapRep.h"
#import "Singel.h"
@interface GifMakerViewController ()

@end

@implementation GifMakerViewController
@synthesize imageArray, delayArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _imageNewArray = [[NSMutableArray alloc] init];
     delayArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor redColor];
    UIImageView *bgimageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgimageView.image = [UIImage imageNamed:@"friendlistbg1"];
    [self.view addSubview:bgimageView];
    NSLog(@"%d",[imageArray count]);
    for (int i=0; i<[imageArray count]; i++) {
        UIImage *faceImage = [imageArray objectAtIndex:i];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        //imageview.image = faceImage;
        //[self.view addSubview:imageview];
        CGSize size1 = CGSizeMake(320, 320);
        UIImage *imagescale = [self scaleFromImage:faceImage //调节图片尺寸的函数
                                          toSize:size1];
        
        
        NSString *gifSaveString = [NSString stringWithFormat:@"%d.png",i];
        NSString *path = [NSTemporaryDirectory() stringByAppendingString:gifSaveString];
        //得到想要保存的图片
        NSData  *imageData1 = UIImagePNGRepresentation(imagescale);
       // NSLog(@"%@",imageData1);
        //保存到缓存文件夹
        [imageData1 writeToFile:path
                     atomically:YES];
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];//从指定索引插入元素
        if (image==nil) {
            NSLog(@"image is nil");
        }
        imageview.image = image;
        [_imageNewArray insertObject:image atIndex:i];//是插入到指定的索引的前
        //[_imageNewArray addObject:image];
        
        NSNumber *number = [NSNumber numberWithFloat:0.5f];//数字转换成浮点数(必须转换成浮点数才能加到数组里)
        [delayArray insertObject:number
                         atIndex:i];

    }
    [self saveGif];
    [self showGif];
	// Do any additional setup after loading the view.
}

- (UIImage *) scaleFromImage: (UIImage *) image
                      toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void) saveGif
{
    NSString *gifName = [NSString stringWithFormat:@"temp.gif"];
    NSString *path = [NSTemporaryDirectory() stringByAppendingString:gifName];
    
#define USE_GIF_MAKER
#ifdef USE_GIF_MAKER
    FreeGifMaker *maker = [FreeGifMaker new];
    [maker setGifFrame:(NSArray *)_imageNewArray
                 delay:(NSArray *)delayArray];
    [maker setGifFileName:gifName];// 设置gif文件名称
    [maker setGifFileDirectory:NSTemporaryDirectory()];// 设置保存位置文件夹
    [maker saveAnimatedGif];// 保存gif文件
    //[maker release];
#endif
}

- (void) showGif
{
    NSString *gifName = [NSString stringWithFormat:@"temp.gif"];
    NSString *path = [NSTemporaryDirectory() stringByAppendingString:gifName];

    
    NSString *gifString = [NSString stringWithFormat:@"%@/Documents/image/temp.gif",NSHomeDirectory()];
    NSData *gif  = [NSData dataWithContentsOfFile:path];
    UIWebView *gifWebView;
    gifWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 40, 320, 320)];
    gifWebView.backgroundColor = [UIColor clearColor];
    [gifWebView loadData:gif
                MIMEType:@"image/gif"
        textEncodingName:nil
                 baseURL:nil];
    gifWebView.scalesPageToFit = NO;
    gifWebView.opaque = 0;
    [self.view addSubview:gifWebView];
   // [gifWebView release];
    
    [_imageNewArray removeAllObjects];
    [delayArray removeAllObjects];//移除数组所有元素
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
