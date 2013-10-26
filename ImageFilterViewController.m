//
//  ImageFilterViewController.m
//  DWin1.0
//
//  Created by zang qilong on 13-10-18.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import "ImageFilterViewController.h"

@interface ImageFilterViewController ()
@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,retain) UIImageView *moveImageView;
@end

@implementation ImageFilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setupView
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kContent_Width, 426.6)];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
