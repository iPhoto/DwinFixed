//
//  TextEditViewController.m
//  DWin1.0
//
//  Created by zang qilong on 13-9-16.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//
enum
{
    kLoveTag = 1000,
    kInspirationTag,
    kHappyTag,
    kNatureTag,
    kNormalTag,
    kSadTag
};
enum
{
    kTakePhoto = 10000,
    kTakeVideo,
    kTakeAudio,
    kTakePhiz
};
static int timelabeltext = 1;
static int whicViewAudioButton = 0;
static double timeLive = 1./30;
#import "TextEditViewController.h"
#import "ZXMacro.h"
#import "DWinUtils.h"
#import <QuartzCore/QuartzCore.h>
#import "RecordingViewController.h"
#import "Singel.h"
#import "AGViewController.h"
#import "AddFivePicViewController.h"
#import "AddFourViewController.h"
#import "AddPicViewController.h"
#import "GifMakerViewController.h"
#import "MergePicViewController.h"
//#import "AudioListViewController.h"
// 录影按钮次序
static int kindOfBtnImage = 2;
@interface TextEditViewController ()
{
    UIButton *btn_love ;
    UIButton *btn_inspiration ;
    UIButton *btn_happy ;
    UIButton *btn_nature ;
    UIButton *btn_normal ;
    UIButton *btn_sad ;
    NSInteger finalTag;
    int pic_flag;
    AGImagePickerController *ipc;

}
@end


@implementation TextEditViewController
@synthesize controlImageType;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
           self.selectedPhotos = [NSMutableArray array];
        
       ///////////////////5 3 4 张图片的arr////////////////
        self.arr_push =[[NSMutableArray alloc]init];
        self.arr_push3=[[NSMutableArray alloc]init];
        self.arr_push4=[[NSMutableArray alloc]init];
        self.gifarr = [[NSMutableArray alloc] init];
        ////////////////////选择照片的flag////////////////////////////////
        
        pic_flag = 0;

    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleImageGet:) name:@"GalleryImage" object:nil];
   
    
    
    
    

}
///////////////////////将获得的照片地址转化为图片方法//////////////////////
-(UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset
{
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullResolutionImage];
    UIImage *img123 = [UIImage imageWithCGImage:imgRef
                                          scale:assetRep.scale
                                    orientation:(UIImageOrientation)assetRep.orientation];
    return img123;
}




#pragma mark -create NavigationBar
- (void)setNavgationBar
{
   
    // 导航条左按钮
    UIButton *btn_left = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_left.frame = CGRectMake(0, 0, 56, 18);
    // [btn_left setBackgroundImage:[UIImage imageNamed:@"friendlist_nav_leftbar"] forState:UIControlStateNormal];
   
  UIImage * image = [UIImage imageNamed:@"textedit_leftnavbar"];
    [btn_left setBackgroundImage:image forState:UIControlStateNormal];
    btn_left.tag=1;
    [btn_left addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:btn_left];
    self.navigationItem.leftBarButtonItem = leftBar;
    // 导航条右按钮
    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_right.frame = CGRectMake(0,8 , 45, 17);
    [btn_right setBackgroundImage:[UIImage imageNamed:@"textedit_rightnavbar"] forState:UIControlStateNormal];
    btn_right.tag=2;
    [btn_right addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
    self.navigationItem.rightBarButtonItem = rightBar;
    // 标题
    self.navigationItem.title = @"Moment";
}

- (void)navBtnClick:(UIButton *)sender
{
    if (sender.tag==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setupView
{
    // 初始化数组
    getPictureFromMerge = [[NSMutableArray alloc] initWithCapacity:0];
    getAudioArrayFromMerge = [[NSMutableArray alloc] initWithCapacity:0];
    getTextFromMerge = [[NSMutableArray alloc] initWithCapacity:0];
    //
    self.controPhotoPanel = self.controVideoPanel = self.controlAudioPanel = nil;
    NSLog(@"%d",self.controlImageType);
    // 设置timecount
    timecount = 1./300;
    //设置 navigationbar
    [self setNavgationBar];
   
    // 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    [self.view addSubview:imageViewBackGround];
    // textview
    UIView *TagAndtextView = [[UIView alloc] initWithFrame:CGRectMake(10, 8, 300, 228)];
    TagAndtextView.layer.cornerRadius = 8.;
    TagAndtextView.layer.masksToBounds = YES;
    TagAndtextView.backgroundColor = RGBAlpha(1, 1, 1, 0.3);
    [self.view addSubview:TagAndtextView];
    UIImageView *imageViewBackGround2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    NSLog(@"%f",kScreen_Height);
    imageViewBackGround2.image = [UIImage imageNamed:@"friendlistbg1"];
    
   
    UIImage *textTagInfobg = [DWinUtils getBlurImage:imageViewBackGround2 withRect:CGRectMake(10, 64+8, 300, 228) WithRadius:0.3];
    imageViewBackGround2.image = textTagInfobg;
    imageViewBackGround2.frame = CGRectMake(0, 0, 300, 228);
  
    [TagAndtextView addSubview:imageViewBackGround2];
    // tag button view
    UIView *tagButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,300, 44)];
    tagButtonView.backgroundColor = RGBAlpha(0, 0, 0, 0.3);
    [TagAndtextView addSubview:tagButtonView];
    // 添加标签按钮
    // love tag
    btn_love = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_love.frame = CGRectMake(9, 5, 24 , 34);
    btn_love.tag = kLoveTag;
    [btn_love addTarget:self action:@selector(btnChooseTag:) forControlEvents:UIControlEventTouchUpInside];
    [btn_love setBackgroundImage:[UIImage imageNamed:@"textedit_love"] forState:UIControlStateNormal];
    [tagButtonView addSubview:btn_love];
    // inspiration tag
    btn_inspiration = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_inspiration.frame = CGRectMake(50, 5, 52 , 36);
    [btn_inspiration setBackgroundImage:[UIImage imageNamed:@"textedit_inpiration"] forState:UIControlStateNormal];
    btn_inspiration.tag = kInspirationTag;
    [btn_inspiration addTarget:self action:@selector(btnChooseTag:) forControlEvents:UIControlEventTouchUpInside];
    [tagButtonView addSubview:btn_inspiration];
    // happy
    btn_happy = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_happy.frame = CGRectMake(112, 5, 32 , 36);
    [btn_happy setBackgroundImage:[UIImage imageNamed:@"textedit_happy"] forState:UIControlStateNormal];
    btn_happy.tag = kHappyTag;
    [btn_happy addTarget:self action:@selector(btnChooseTag:) forControlEvents:UIControlEventTouchUpInside];
    [tagButtonView addSubview:btn_happy];
    // nature
    btn_nature = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_nature.frame = CGRectMake(160, 5, 34 , 34);
    [btn_nature setBackgroundImage:[UIImage imageNamed:@"textedit_nature"] forState:UIControlStateNormal];
    btn_nature.tag = kNatureTag;
    [btn_nature addTarget:self action:@selector(btnChooseTag:) forControlEvents:UIControlEventTouchUpInside];
    [tagButtonView addSubview:btn_nature];
    // normal
    btn_normal = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_normal.frame = CGRectMake(211, 5, 36 , 34);
    [btn_normal setBackgroundImage:[UIImage imageNamed:@"textedit_normal"] forState:UIControlStateNormal];
    btn_normal.tag = kNormalTag;
    [btn_normal addTarget:self action:@selector(btnChooseTag:) forControlEvents:UIControlEventTouchUpInside];
    [tagButtonView addSubview:btn_normal];
    // sad
    btn_sad = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_sad.frame = CGRectMake(268, 5, 23 , 34);
    [btn_sad setBackgroundImage:[UIImage imageNamed:@"textedit_sad"] forState:UIControlStateNormal];
    btn_sad.tag = kSadTag;
    [btn_sad addTarget:self action:@selector(btnChooseTag:) forControlEvents:UIControlEventTouchUpInside];

    [tagButtonView addSubview:btn_sad];
   
    // textView
    mtextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, 280, 180)];
    
    mtextView.backgroundColor = [UIColor clearColor];
    mtextView.returnKeyType = UIReturnKeyDone;
    mtextView.delegate = self;
    [TagAndtextView addSubview:mtextView];
    // 初始化控制界面
    [self createControlView];
    switch (controlImageType) {
        case 1:
        {
            [self createPhotoView];
            break;
        }
        case 2:
        {
            [self createVideoView];
            break;
        }
        case 3:
        {
            [self createAudioView];
            break;
        }
        case 6:
        {
            [self createAudioView];
            [mtextView becomeFirstResponder];
            break;
        }
            
        default:
            break;
    }
    //[self createAudioView];
    //[self createPhotoView];
    //[self createVideoView];
}

#pragma mark - 创建控制图
- (void)createControlView
{
    controlView = [[UIView alloc] initWithFrame:CGRectMake(0, kContent_Height-302, 320, kContent_Height-292)];
    NSLog(@"content height = %f",kContent_Height);
    controlView.backgroundColor = RGBAlpha(1, 1, 1, 0.3);
    [self.view addSubview:controlView];
    UIImageView *imageViewBackGround3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    NSLog(@"%f",kScreen_Height);
    imageViewBackGround3.image = [UIImage imageNamed:@"friendlistbg1"];
    
    
    UIImage *controlImage = [DWinUtils getBlurImage:imageViewBackGround3 withRect:CGRectMake(0, kContent_Height-302, 320, kContent_Height-302) WithRadius:0.3];
    imageViewBackGround3.image = controlImage;
    imageViewBackGround3.frame = CGRectMake(0, 0, 320, kContent_Height-292);
    
    [controlView addSubview:imageViewBackGround3];
    // switch Function
    UIImageView *imageWhiteBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    imageWhiteBg.image = [UIImage imageNamed:@"textedit_whitebg"];
    imageWhiteBg.userInteractionEnabled = YES;
    [controlView addSubview:imageWhiteBg];
    // placehold imageview
    placeholdImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 0, 44, 44)];
    placeholdImage.image = [UIImage imageNamed:@"textedit_placeholdimage"];
    [imageWhiteBg addSubview:placeholdImage];
    placeholdImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToAudioList)];
    [placeholdImage addGestureRecognizer:tapges];
    // seperateline
    UIImageView *seperateLine = [[UIImageView alloc] initWithFrame:CGRectMake(66, 4, 2, 36)];
    seperateLine.image = [UIImage imageNamed:@"textedit_seperateline"];
    [imageWhiteBg addSubview:seperateLine];
    // take photo button
    btn_takephoto = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_takephoto.frame = CGRectMake(84, 0, 31,44 );
    [btn_takephoto setBackgroundImage:[UIImage imageNamed:@"textedit_takephoto"] forState:UIControlStateNormal];
    btn_takephoto.tag = kTakePhoto;
    [btn_takephoto addTarget:self action:@selector(controlPanelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageWhiteBg addSubview:btn_takephoto];
    // take video button
    btn_takevideo = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_takevideo.frame = CGRectMake(151, 0, 32,44);
    [btn_takevideo setBackgroundImage:[UIImage imageNamed:@"textedit_takevideo"] forState:UIControlStateNormal];
    btn_takevideo.tag = kTakeVideo;
    [btn_takevideo addTarget:self action:@selector(controlPanelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageWhiteBg addSubview:btn_takevideo];
    // take audio button
    btn_takeaudio= [UIButton buttonWithType:UIButtonTypeCustom];
    btn_takeaudio.frame = CGRectMake(219, 0, 25,44);
    [btn_takeaudio setBackgroundImage:[UIImage imageNamed:@"textedit_takeaudio"] forState:UIControlStateNormal];
    btn_takeaudio.tag = kTakeAudio;
    [btn_takeaudio addTarget:self action:@selector(controlPanelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageWhiteBg addSubview:btn_takeaudio];
    // take phiz button
    btn_takephiz= [UIButton buttonWithType:UIButtonTypeCustom];
    btn_takephiz.frame = CGRectMake(275, 0, 26,44);
    [btn_takephiz setBackgroundImage:[UIImage imageNamed:@"textedit_takephiz"] forState:UIControlStateNormal];
    btn_takephiz.tag = kTakePhiz;
    [btn_takephiz addTarget:self action:@selector(controlPanelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageWhiteBg addSubview:btn_takephiz];
    switch (controlImageType) {
        case 1:
        {
           
            [btn_takephoto setBackgroundImage:[UIImage imageNamed:@"textedit_takephotoselected"] forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
           
            [btn_takevideo setBackgroundImage:[UIImage imageNamed:@"textedit_takevideoselected"] forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
           
            [btn_takeaudio setBackgroundImage:[UIImage imageNamed:@"textedit_takeaudioselected"] forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
           
            [btn_takephiz setBackgroundImage:[UIImage imageNamed:@"textedit_takephizselected"] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

- (void)tapToAudioList
{
    NSLog(@"tap");
    [mtextView resignFirstResponder];
    [self.controlAudioPanel removeFromSuperview];
    [self.controPhotoPanel removeFromSuperview];
    [self.controVideoPanel removeFromSuperview];
    if (self.MergePartPanel!=nil) {
        for (int i=0; i<[getPictureFromMerge count]; i++) {
            if (i==0) {
                for (UIButton *btn in mergeView1.subviews) {
                    if (btn.tag==10000) {
                        [btn setBackgroundImage:[getPictureFromMerge objectAtIndex:i] forState:UIControlStateNormal];
                    }
                }
            }
            if (i==1) {
                for (UIButton *btn in mergeView2.subviews) {
                    if (btn.tag==10000) {
                        [btn setBackgroundImage:[getPictureFromMerge objectAtIndex:i] forState:UIControlStateNormal];
                    }
                }
            }
            if (i==2) {
                for (UIButton *btn in mergeView3.subviews) {
                    if (btn.tag==10000) {
                        [btn setBackgroundImage:[getPictureFromMerge objectAtIndex:i] forState:UIControlStateNormal];
                    }
                }
            }
            if (i==3) {
                for (UIButton *btn in mergeView4.subviews) {
                    if (btn.tag==10000) {
                        [btn setBackgroundImage:[getPictureFromMerge objectAtIndex:i] forState:UIControlStateNormal];
                    }
                }
            }
        }
        [controlView addSubview:self.MergePartPanel];
    }else
    {
        [self createeMergePart];
    }
    
    [self setupBtnBackgroundImage:0];
    //[self.navigationController pushViewController:[[AudioListViewController alloc] init] animated:YES];
}

- (void)controlPanelBtnClick:(UIButton *)sender
{
    NSLog(@"control panel btn tag%d",sender.tag);
    switch (sender.tag) {
        case kTakePhoto:
        {
            [mtextView resignFirstResponder];
            NSLog(@"set up photo view");
            [self.controlAudioPanel removeFromSuperview];
            [self.controPhotoPanel removeFromSuperview];
            [self.controVideoPanel removeFromSuperview];
            [self.MergePartPanel removeFromSuperview];
            if (self.controPhotoPanel !=nil) {
                [controlView addSubview:self.controPhotoPanel];
            }else
            {
                [self createPhotoView];
            }
            
            [self setupBtnBackgroundImage:1];
        }
            break;
            
        case kTakeVideo:
        {
            [mtextView resignFirstResponder];
            [self.controlAudioPanel removeFromSuperview];
            [self.controPhotoPanel removeFromSuperview];
            [self.controVideoPanel removeFromSuperview];
            [self.MergePartPanel removeFromSuperview];
            if (self.controVideoPanel !=nil) {
                [controlView addSubview:self.controVideoPanel];
            }else
            {
                [self createVideoView];
            }
            [self setupBtnBackgroundImage:2];
        }
            break;
        case kTakeAudio:
        {
            [mtextView resignFirstResponder];
            [self.controlAudioPanel removeFromSuperview];
            [self.controPhotoPanel removeFromSuperview];
            [self.controVideoPanel removeFromSuperview];
            [self.MergePartPanel removeFromSuperview];
            if (self.controlAudioPanel !=nil) {
                [controlView addSubview:self.controlAudioPanel];
            }else
            {
                [self createAudioView];
            }
            [self setupBtnBackgroundImage:3];
            
        }
            break;
        case kTakePhiz:
        {
            [mtextView resignFirstResponder];
            [self.controlAudioPanel removeFromSuperview];
            [self.controPhotoPanel removeFromSuperview];
            [self.controVideoPanel removeFromSuperview];
            [self.MergePartPanel removeFromSuperview];
            [self setupBtnBackgroundImage:4];
        }
            break;
        default:
            break;
    }
    
}

- (void)setupBtnBackgroundImage:(int)number
{
    switch (number) {
        case 0:
        {
            [btn_takephoto setBackgroundImage:[UIImage imageNamed:@"textedit_takephoto"] forState:UIControlStateNormal];
            [btn_takevideo setBackgroundImage:[UIImage imageNamed:@"textedit_takevideo"] forState:UIControlStateNormal];
            [btn_takeaudio setBackgroundImage:[UIImage imageNamed:@"textedit_takeaudio"] forState:UIControlStateNormal];
            [btn_takephiz setBackgroundImage:[UIImage imageNamed:@"textedit_takephiz"] forState:UIControlStateNormal];
        }
            break;
        case 1:
        {
            [btn_takephoto setBackgroundImage:[UIImage imageNamed:@"textedit_takephotoselected"] forState:UIControlStateNormal];
            [btn_takevideo setBackgroundImage:[UIImage imageNamed:@"textedit_takevideo"] forState:UIControlStateNormal];
             [btn_takeaudio setBackgroundImage:[UIImage imageNamed:@"textedit_takeaudio"] forState:UIControlStateNormal];
             [btn_takephiz setBackgroundImage:[UIImage imageNamed:@"textedit_takephiz"] forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [btn_takephoto setBackgroundImage:[UIImage imageNamed:@"textedit_takephoto"] forState:UIControlStateNormal];
            [btn_takevideo setBackgroundImage:[UIImage imageNamed:@"textedit_takevideoselected"] forState:UIControlStateNormal];
            [btn_takeaudio setBackgroundImage:[UIImage imageNamed:@"textedit_takeaudio"] forState:UIControlStateNormal];
            [btn_takephiz setBackgroundImage:[UIImage imageNamed:@"textedit_takephiz"] forState:UIControlStateNormal];        }
            break;
        case 3:
        {
            [btn_takephoto setBackgroundImage:[UIImage imageNamed:@"textedit_takephoto"] forState:UIControlStateNormal];
            [btn_takevideo setBackgroundImage:[UIImage imageNamed:@"textedit_takevideo"] forState:UIControlStateNormal];
            [btn_takeaudio setBackgroundImage:[UIImage imageNamed:@"textedit_takeaudioselected"] forState:UIControlStateNormal];
            [btn_takephiz setBackgroundImage:[UIImage imageNamed:@"textedit_takephiz"] forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            [btn_takephoto setBackgroundImage:[UIImage imageNamed:@"textedit_takephoto"] forState:UIControlStateNormal];
            [btn_takevideo setBackgroundImage:[UIImage imageNamed:@"textedit_takevideo"] forState:UIControlStateNormal];
            [btn_takeaudio setBackgroundImage:[UIImage imageNamed:@"textedit_takeaudio"] forState:UIControlStateNormal];
            [btn_takephiz setBackgroundImage:[UIImage imageNamed:@"textedit_takephizselected"] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }

}

#pragma mark -create merge part
 - (void)createeMergePart
{
    if (_MergePartPanel !=nil) {
        [controlView addSubview:_MergePartPanel];
    }else
    {
        _MergePartPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, kContent_Height-336)];
        _MergePartPanel.backgroundColor = [UIColor clearColor];
        [controlView addSubview:_MergePartPanel];
        // 创建合并视图
        for (int i = 0; i<4; i++)
        {
            UIView *viewMix = [[UIView alloc] initWithFrame:CGRectMake(16*(i+1)+60*i, 40, 60, 89)];
            viewMix.backgroundColor = [UIColor clearColor];
             viewMix.tag = i;
            //viewMix.layer.cornerRadius = 26;
            viewMix.layer.masksToBounds = YES;
            UIImageView *viewMixBG  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 89)];
            viewMixBG.image = [UIImage imageNamed:@"textedit_mergebg"];
            [viewMix addSubview:viewMixBG];
            // 添加图片
            UIButton *btn_Addimage = [UIButton buttonWithType:UIButtonTypeCustom];
            btn_Addimage.frame = CGRectMake(2, 2, 56, 52);
            btn_Addimage.layer.cornerRadius = 8;
            btn_Addimage.layer.masksToBounds = YES;
            [btn_Addimage setBackgroundImage:[UIImage imageNamed:@"textedit_addimage"] forState:UIControlStateNormal];
            [btn_Addimage addTarget:self action:@selector(addTextAndPIc:) forControlEvents:UIControlEventTouchUpInside];
            btn_Addimage.tag = 10000;
            [viewMix addSubview:btn_Addimage];
            // 判断数组
           
            // 添加text
            UIButton *btn_Addtext = [UIButton buttonWithType:UIButtonTypeCustom];
            btn_Addtext.frame = CGRectMake(0, 54, 29, 32);
            [btn_Addtext setBackgroundImage:[UIImage imageNamed:@"textedit_addtext"] forState:UIControlStateNormal];
            [btn_Addtext addTarget:self action:@selector(addTextAndPIc:) forControlEvents:UIControlEventTouchUpInside];
            btn_Addtext.tag = btn_Addimage.tag+1;
            [viewMix addSubview:btn_Addtext];
            // 添加音频
            UIButton *btn_addAudio = [UIButton buttonWithType:UIButtonTypeCustom];
            btn_addAudio.frame = CGRectMake(32, 54, 29, 32);
            [btn_addAudio setBackgroundImage:[UIImage imageNamed:@"textedit_addaudio"] forState:UIControlStateNormal];
            [btn_addAudio addTarget:self action:@selector(addTextAndPIc:) forControlEvents:UIControlEventTouchUpInside];
            btn_addAudio.tag = btn_Addtext.tag+1;
            [viewMix addSubview:btn_addAudio];
           
            switch (i) {
                case 0:
                    mergeView1 = viewMix;
                    break;
                case 1:
                    mergeView2 = viewMix;
                    break;
                case 2:
                    mergeView3 = viewMix;
                    break;
                case 3:
                    mergeView4 = viewMix;
                    break;
                default:
                    break;
            }
            if ([getPictureFromMerge count]>=i+1) {
                [btn_Addimage setBackgroundImage:[getPictureFromMerge objectAtIndex:i] forState:UIControlStateNormal];
            }
            [_MergePartPanel addSubview:viewMix];
        }
    }
    
    
}

- (void)addTextAndPIc:(UIButton *)sender
{
    UIView *view = [sender superview];
    switch (view.tag) {
        case 0:
        {
            if (sender.tag==10000) {
                
            }
            if (sender.tag==10001) {
                
            }
            if (sender.tag==10002) {
                [self cancelAudioFile];
                whicViewAudioButton = view.tag;
                [self createMergeViewAudio:sender];
            }
            break;
        }
           
        case 1:
        {
            if (sender.tag==10000) {
                
            }
            if (sender.tag==10001) {
                
            }
            if (sender.tag==10002) {
                [self cancelAudioFile];
                whicViewAudioButton = view.tag;
                [self createMergeViewAudio:sender];
            }
            break;
        }

        case 2:
        {
            if (sender.tag==10000) {
                
            }
            if (sender.tag==10001) {
                
            }
            if (sender.tag==10002) {
                [self cancelAudioFile];
                whicViewAudioButton = view.tag;
                [self createMergeViewAudio:sender];
            }
            break;
        }
        case 3:
        {
            if (sender.tag==10000) {
                
            }
            if (sender.tag==10001) {
                
            }
            if (sender.tag==10002) {
                [self cancelAudioFile];
                whicViewAudioButton = view.tag;
                [self createMergeViewAudio:sender];
            }
            break;
        }
        default:
            break;
    }
}



#pragma mark - audio view and action
- (void)createAudioView
{
    _controlAudioPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, kContent_Height-336)];
    _controlAudioPanel.backgroundColor = [UIColor clearColor];
    // recorder background
    UIImageView *recorderBG = [[UIImageView alloc] initWithFrame:CGRectMake(41, 76-44, 240, 60)];
    recorderBG.image = [UIImage imageNamed:@"textedit_recorderbg"];
    [_controlAudioPanel addSubview:recorderBG];
    // recorder logo
    UIImageView *recorderLogo= [[UIImageView alloc] initWithFrame:CGRectMake(12, 16, 20, 28)];
    recorderLogo.image = [UIImage imageNamed:@"textedit_recorderlogo"];
    [recorderBG addSubview:recorderLogo];
    recorderBG.userInteractionEnabled = YES;
    // 取消按钮
    UIButton *btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_cancel.frame = CGRectMake(240-20, -1, 24, 60);
    [btn_cancel setBackgroundImage:[UIImage imageNamed:@"textedit_cancelaudio"] forState:UIControlStateNormal];
    [btn_cancel addTarget:self action:@selector(cancelAudioFile) forControlEvents:UIControlEventTouchUpInside];
    [recorderBG addSubview:btn_cancel];
    // recorder times
    labelTimes = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, 70, 30)];
    labelTimes.textColor = [UIColor whiteColor];
    labelTimes.backgroundColor = [UIColor clearColor];
    labelTimes.text = @"";
    [recorderBG addSubview:labelTimes];
    // progress and button
    picProgressView = [[PICircularProgressView alloc] initWithFrame:CGRectMake(130, 166-44, 55, 55)];
    
    picProgressView.backgroundColor = [UIColor clearColor];
    [picProgressView setProgressFillColor:[UIColor redColor]];
    [picProgressView setOuterBackgroundColor:[UIColor whiteColor]];
    [picProgressView setThicknessRatio:0.09];
    [picProgressView setShowText:0];
    [_controlAudioPanel addSubview:picProgressView];
    // control recorder button
    btn_control_recorder = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_control_recorder.frame = CGRectMake(4, 2, 50, 50);
    btn_control_recorder.center = CGPointMake(kGetViewWidth(picProgressView)/2, kGetViewHeight(picProgressView)/2);
    [btn_control_recorder setBackgroundImage:[UIImage imageNamed:@"textedit_start"] forState:UIControlStateNormal];
    //[btn_control_recorder setImage:[UIImage imageNamed:@"textedit_start"] forState:UIControlStateNormal];
    [btn_control_recorder addTarget:self action:@selector(controlRecorderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [picProgressView addSubview:btn_control_recorder];
    //
    labelRealTime = [[UILabel alloc] initWithFrame:CGRectMake(265, 224-44, 60, 30)];
    labelRealTime.text = @"0/30S";
    labelRealTime.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:16];
    labelRealTime.backgroundColor = [UIColor clearColor];
    labelRealTime.textColor = [UIColor blackColor];
    [_controlAudioPanel addSubview:labelRealTime];
    [controlView addSubview:_controlAudioPanel];
    
}
- (void)controlRecorderBtnClick:(UIButton *)sender
{
    
    switch (kindOfBtnImage) {
        case 1:
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"textedit_start"] forState:UIControlStateNormal];
            kindOfBtnImage++;
            
            break;
        }
        case 2:
        {
            NSLog(@"hello audio");
            [sender setBackgroundImage:[UIImage imageNamed:@"textedit_stop"] forState:UIControlStateNormal];
            {
                NSString *path = [self stringFromDate:[NSDate date]];
                recordFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:path]];
                
                recorder = [[AVAudioRecorder alloc] initWithURL:recordFile settings:nil error:nil];
                [recorder prepareToRecord];
                [recorder record];
            }
            recorderTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeProcessValue) userInfo:nil repeats:YES];
            kindOfBtnImage++;
            
            break;
        }
        case 3:
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"textedit_play"] forState:UIControlStateNormal];
            [recorderTimer invalidate];
            if (recorder!=nil) {
                isRecording = NO;
                [recorder stop];
                recorder = nil;
            }
            else
            {
                [player stop];
            }
            kindOfBtnImage++;
            break;
        }
        case 4:
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"textedit_pause"] forState:UIControlStateNormal];
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
            kindOfBtnImage=3;
            
            break;
        }
        default:
            break;
    }
}

#pragma mark -audio control timer
- (void)changeProcessValue
{
    NSLog(@"hello timer");
    
    
    picProgressView.progress=timecount;
    timecount+=1./300;
    if (timecount>timeLive) {
        labelRealTime.text = [NSString stringWithFormat:@"%d/30S",timelabeltext];
        timeLive+=1./30;
        timelabeltext++;
    }
    if (timelabeltext>=31) {
        [btn_control_recorder setBackgroundImage:[UIImage imageNamed:@"textedit_play"] forState:UIControlStateNormal];
        [recorderTimer invalidate];
        if (recorder!=nil) {
            isRecording = NO;
            [recorder stop];
            recorder = nil;
        }
        else
        {
            [player stop];
            timeLive=1./30;
        }
        kindOfBtnImage++;
        
        
    }
    NSLog(@"%lf",timecount);
}

- (void)cancelAudioFile
{
    NSLog(@"%d",kindOfBtnImage);
    if (kindOfBtnImage==3) {
        [recorderTimer invalidate];
        isRecording = NO;
        [recorder stop];
    }
    NSLog(@"cancel work");
    picProgressView.progress = 0;
    timecount = 1./300;
    kindOfBtnImage = 2;
    [btn_control_recorder setBackgroundImage:[UIImage imageNamed:@"textedit_start"] forState:UIControlStateNormal];
     labelRealTime.text = @"0/30S";
    timelabeltext = 1;
    timeLive = 1./30;
    if ([player isPlaying]) {
        [player stop];
    }
    
}


#pragma mark - set avaudio session
- (void)setAvAudioSession
{
    isRecording = NO;
    NSDate *dateNow = [NSDate date];
    NSString *audioName = [self stringFromDate:dateNow];
    recordFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:audioName]];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];
    
}

#pragma mark - avaudio player delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [btn_control_recorder setBackgroundImage:[UIImage imageNamed:@"textedit_play"] forState:UIControlStateNormal];
}


#pragma mark - create PhotoView and photo action

- (void)createPhotoView
{
    _controPhotoPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, kContent_Height-336)];
    _controPhotoPanel.backgroundColor = [UIColor clearColor];
    // 拍照
    for (int i=0; i<4; i++) {
        if (i==1) {
            continue;
        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
         btn.frame = CGRectMake(16*(i+1)+60*i, 40, 60, 60);
        if (i==2) {
            btn.center = CGPointMake(160, 70);
        }
       
        [btn addTarget:self action:@selector(controlPhotoPanelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000+i;
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"controlphoto%d",i+1]];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        [_controPhotoPanel addSubview:btn];
    }
    [controlView addSubview:_controPhotoPanel];

}

- (void)controlPhotoPanelBtnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 1000:
        {
            ShootViewController *shoot = [[ShootViewController alloc] init];
            shoot.delegate = self;
            [self.navigationController pushViewController:shoot animated:YES];
        }
            break;
        case 1001:
        {
            [self.navigationController pushViewController:[[AGViewController alloc] init] animated:YES];
        }
            break;
        case 1002:
        { // Show saved photos on top
            ipc.shouldShowSavedPhotosOnTop = NO;
            ipc.shouldChangeStatusBarStyle = YES;
            ipc.selection = self.selectedPhotos;
            isGifPress = NO;
            //    ipc.maximumNumberOfPhotosToBeSelected = 1;
            [self presentViewController:ipc animated:YES completion:nil];
            
         

        }
            break;
        case 1003:
        { // Show saved photos on top
            NSLog(@"gif go");
            ipc.shouldShowSavedPhotosOnTop = NO;
            ipc.shouldChangeStatusBarStyle = YES;
            ipc.selection = self.selectedPhotos;
            isGifPress = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"gif1" object:nil];
            [[NSUserDefaults standardUserDefaults] setObject:@"GIF" forKey:@"GIF"];
            [self presentViewController:ipc animated:YES completion:nil];
            
            
            
        }
            break;
        default:
            break;
    }
}

#pragma mark shootviewcontroller delegate
- (void)shootViewController:(UIImage *)image
{
    
    placeholdImage.image = image;
    if ([getPictureFromMerge count]<4) {
        [getPictureFromMerge addObject:image];
    }
}

#pragma mark create Video and action

- (void)createVideoView
{
    _controVideoPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, kContent_Height-336)];
    _controVideoPanel.backgroundColor = [UIColor clearColor];
    // 拍照
    for (int i=0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(16*(i+1)+60*i, 40, 60, 60);
        [btn addTarget:self action:@selector(controlVideoPanelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000+i;
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"controlvideo%d",i+1]];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        [_controVideoPanel addSubview:btn];
    }
    [controlView addSubview:_controVideoPanel];
    
}

- (void)controlVideoPanelBtnClick:(UIButton *)sender
{
    if (sender.tag==1000) {
        [self.navigationController pushViewController:[[RecordingViewController alloc] init] animated:YES];
    }
    if (sender.tag==1001)
    {
         [self.navigationController pushViewController:[[MergePicViewController alloc] init] animated:YES];
    }
}


/*
kInspirationTag,
kHappyTag,
kNatureTag,
kNormalTag,
kSadTag
*/



- (void)btnChooseTag:(UIButton *)btn
{
    switch (btn.tag) {
        case kLoveTag:
        {
            [btn_love setBackgroundImage:[UIImage imageNamed:@"textedit_love"] forState:UIControlStateNormal];
            [btn_inspiration setBackgroundImage:[UIImage imageNamed:@"textedit_inpiration"] forState:UIControlStateNormal];
            [btn_happy setBackgroundImage:[UIImage imageNamed:@"textedit_happy"] forState:UIControlStateNormal];
            [btn_nature setBackgroundImage:[UIImage imageNamed:@"textedit_nature"] forState:UIControlStateNormal];
            [btn_normal setBackgroundImage:[UIImage imageNamed:@"textedit_normal"] forState:UIControlStateNormal];
            [btn_sad setBackgroundImage:[UIImage imageNamed:@"textedit_sad"] forState:UIControlStateNormal];

            
            [btn_love setBackgroundImage:[UIImage imageNamed:@"textedit_loveselected"] forState:UIControlStateNormal];
            finalTag = kLoveTag;
            
        }
            break;
        case kHappyTag:
        {
            [btn_love setBackgroundImage:[UIImage imageNamed:@"textedit_love"] forState:UIControlStateNormal];
            [btn_inspiration setBackgroundImage:[UIImage imageNamed:@"textedit_inpiration"] forState:UIControlStateNormal];
            [btn_happy setBackgroundImage:[UIImage imageNamed:@"textedit_happy"] forState:UIControlStateNormal];
            [btn_nature setBackgroundImage:[UIImage imageNamed:@"textedit_nature"] forState:UIControlStateNormal];
            [btn_normal setBackgroundImage:[UIImage imageNamed:@"textedit_normal"] forState:UIControlStateNormal];
            [btn_sad setBackgroundImage:[UIImage imageNamed:@"textedit_sad"] forState:UIControlStateNormal];
            
            
            [btn_happy setBackgroundImage:[UIImage imageNamed:@"textedit_happyselected"] forState:UIControlStateNormal];
            finalTag = kHappyTag;
        }
            break;
        case kNatureTag:
        {
            [btn_love setBackgroundImage:[UIImage imageNamed:@"textedit_love"] forState:UIControlStateNormal];
            [btn_inspiration setBackgroundImage:[UIImage imageNamed:@"textedit_inpiration"] forState:UIControlStateNormal];
            [btn_happy setBackgroundImage:[UIImage imageNamed:@"textedit_happy"] forState:UIControlStateNormal];
            [btn_nature setBackgroundImage:[UIImage imageNamed:@"textedit_nature"] forState:UIControlStateNormal];
            [btn_normal setBackgroundImage:[UIImage imageNamed:@"textedit_normal"] forState:UIControlStateNormal];
            [btn_sad setBackgroundImage:[UIImage imageNamed:@"textedit_sad"] forState:UIControlStateNormal];
            
            
             [btn_nature setBackgroundImage:[UIImage imageNamed:@"textedit_natureselected"] forState:UIControlStateNormal];
            finalTag = kNatureTag;
        }
            break;
        case kNormalTag:
        {
            [btn_love setBackgroundImage:[UIImage imageNamed:@"textedit_love"] forState:UIControlStateNormal];
            [btn_inspiration setBackgroundImage:[UIImage imageNamed:@"textedit_inpiration"] forState:UIControlStateNormal];
            [btn_happy setBackgroundImage:[UIImage imageNamed:@"textedit_happy"] forState:UIControlStateNormal];
            [btn_nature setBackgroundImage:[UIImage imageNamed:@"textedit_nature"] forState:UIControlStateNormal];
            [btn_normal setBackgroundImage:[UIImage imageNamed:@"textedit_normal"] forState:UIControlStateNormal];
            [btn_sad setBackgroundImage:[UIImage imageNamed:@"textedit_sad"] forState:UIControlStateNormal];
            
            
            [btn_normal setBackgroundImage:[UIImage imageNamed:@"textedit_normalselected"] forState:UIControlStateNormal];
            finalTag = kNormalTag;
        }
            break;
        case kSadTag:
        {
            [btn_love setBackgroundImage:[UIImage imageNamed:@"textedit_love"] forState:UIControlStateNormal];
            [btn_inspiration setBackgroundImage:[UIImage imageNamed:@"textedit_inpiration"] forState:UIControlStateNormal];
            [btn_happy setBackgroundImage:[UIImage imageNamed:@"textedit_happy"] forState:UIControlStateNormal];
            [btn_nature setBackgroundImage:[UIImage imageNamed:@"textedit_nature"] forState:UIControlStateNormal];
            [btn_normal setBackgroundImage:[UIImage imageNamed:@"textedit_normal"] forState:UIControlStateNormal];
            [btn_sad setBackgroundImage:[UIImage imageNamed:@"textedit_sad"] forState:UIControlStateNormal];
            
            
            [btn_sad setBackgroundImage:[UIImage imageNamed:@"textedit_sadselected"] forState:UIControlStateNormal];
            finalTag = kSadTag;
        }
            break;
        case kInspirationTag:
        {
            [btn_love setBackgroundImage:[UIImage imageNamed:@"textedit_love"] forState:UIControlStateNormal];
            [btn_inspiration setBackgroundImage:[UIImage imageNamed:@"textedit_inpiration"] forState:UIControlStateNormal];
            [btn_happy setBackgroundImage:[UIImage imageNamed:@"textedit_happy"] forState:UIControlStateNormal];
            [btn_nature setBackgroundImage:[UIImage imageNamed:@"textedit_nature"] forState:UIControlStateNormal];
            [btn_normal setBackgroundImage:[UIImage imageNamed:@"textedit_normal"] forState:UIControlStateNormal];
            [btn_sad setBackgroundImage:[UIImage imageNamed:@"textedit_sad"] forState:UIControlStateNormal];
            
            
            [btn_inspiration setBackgroundImage:[UIImage imageNamed:@"textedit_inspirationselected"] forState:UIControlStateNormal];
            finalTag = kInspirationTag;
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mark - date to string
- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    
    return destDateString;
    
}

#pragma mark - vidwdid load
- (void)viewDidLoad
{
    [super viewDidLoad];
    {
          ipc = [[AGImagePickerController alloc] initWithDelegate:self];
        __block AGImagePickerController *blockIpc = ipc;
        __block TextEditViewController *blockSelf = self;
        __block NSMutableArray *arr = _gifarr;
        
        ipc.didFailBlock = ^(NSError *error) {
            NSLog(@"Fail. Error: %@", error);
            
            if (error == nil) {
                //[blockSelf.selectedPhotos removeAllObjects];
                NSLog(@"User has cancelled.");
                NSLog(@"dismiss2");
                double delayInSeconds = 7;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [blockIpc dismissViewControllerAnimated:YES completion:nil];
                    NSLog(@"dismiss");
                });
                
            } else {
                
                // We need to wait for the view controller to appear first.
                double delayInSeconds = 7;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [blockIpc dismissViewControllerAnimated:YES completion:nil];
                    NSLog(@"dismiss");
                });
            }
            
        };
        ipc.didFinishBlock = ^(NSArray *info) {
            // [blockSelf.selectedPhotos setArray:info];
            
            
            NSLog(@"%@",info);
            ////////////////////////3 4 5 张照片走的方法/////////////////////////
            for (int i=0; i<[info count]; i++) {
                UIImage *img = [blockSelf fullResolutionImageFromALAsset:[info objectAtIndex:i]];
                [arr addObject:img];
            }
            if ([info count]==3)
            {
                pic_flag=3;
                UIImage *img  = [self fullResolutionImageFromALAsset:[info objectAtIndex:0]];
                UIImage *img1 = [self fullResolutionImageFromALAsset:[info objectAtIndex:1]];
                UIImage *img2 = [self fullResolutionImageFromALAsset:[info objectAtIndex:2]];
                [_arr_push3 addObject: img];
                [_arr_push3 addObject:img1];
                [_arr_push3 addObject:img2];
            }
            if ([info count]==4)
            {
                pic_flag=4;
                UIImage *img=[self fullResolutionImageFromALAsset:[info objectAtIndex:0]];
                UIImage *img1=[self fullResolutionImageFromALAsset:[info objectAtIndex:1]];
                UIImage *img2=[self fullResolutionImageFromALAsset:[info objectAtIndex:2]];
                UIImage *img3=[self fullResolutionImageFromALAsset:[info objectAtIndex:3]];
                
                [_arr_push4 addObject: img];
                [_arr_push4 addObject:img1];
                [_arr_push4 addObject:img2];
                [_arr_push4 addObject:img3];
                
            }
            if ([info count]==5)
                
            {
                pic_flag=5;
                
                im=[self fullResolutionImageFromALAsset:[info objectAtIndex:0]];
                im1 = [self fullResolutionImageFromALAsset:[info objectAtIndex:1] ];
                im2 = [self fullResolutionImageFromALAsset:[info objectAtIndex:2] ];
                im3 = [self fullResolutionImageFromALAsset:[info objectAtIndex:3] ];
                im4 = [self fullResolutionImageFromALAsset:[info objectAtIndex:4] ];
                [_arr_push addObject: im];
                [_arr_push addObject:im1];
                [_arr_push addObject:im4];
                [_arr_push addObject:im2];
                [_arr_push addObject:im3];
                
            }
            
            [blockIpc dismissViewControllerAnimated:YES completion:nil];
            
        };
        
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push) name:@"fanhui" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gifMaker) name:@"makegifpost" object:nil];
    [self setupView];
	// Do any additional setup after loading the view.
}

- (void)gifMaker
{
    NSLog(@"gifmaker");
    [self performSelector:@selector(makergo) withObject:self afterDelay:2];
}

- (void)makergo
{
     Singel * da=[Singel danli];
    da.fourpicArr=[[NSArray alloc]init];
    GifMakerViewController*add4=[[GifMakerViewController alloc]init];
    da.fourpicArr=_gifarr;
    
    [self.navigationController pushViewController:add4 animated:YES];

}

-(void)push
{
    [self performSelector:@selector(del) withObject:self afterDelay:2];
    
    
}
-(void)del
{
    if (isGifPress) {
        GifMakerViewController *gifmaker = [[GifMakerViewController alloc] init];
        gifmaker.imageArray = [NSArray arrayWithArray:_gifarr];
        [self.navigationController pushViewController:gifmaker animated:YES];
    }else
    {
        
        Singel * da=[Singel danli];
        if (pic_flag==4)
        {
            da.fourpicArr=[[NSArray alloc]init];
            AddFourViewController*add4=[[AddFourViewController alloc]init];
            da.fourpicArr=_arr_push4;
            
            [self.navigationController pushViewController:add4 animated:YES];
        }
        
        if (pic_flag==3)
        {
            da.threepicArr=[[NSArray alloc]init];
            
            
            AddPicViewController*add=[[AddPicViewController alloc]init];
            
            da.threepicArr=_arr_push3;
            [self.navigationController pushViewController:add animated:YES];
            
        }
        
        if (pic_flag == 5) {
            
            
            
            da.fivepicArr=[[NSArray alloc]init];
            
            AddFivePicViewController*add5=[[AddFivePicViewController alloc]init];;
            da.fivepicArr=_arr_push;
            
            [self.navigationController pushViewController:add5 animated:YES];
            
        }
    }
   
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - create Merge Audio View

- (void)createMergeViewAudio:(UIButton *)btn
{
    secondAudioview  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    secondAudioview.backgroundColor = RGBAlpha(0, 0, 0, 0.3);
    [self.view addSubview:secondAudioview];

    UIImageView *imageViewBackGround2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    NSLog(@"%f",kScreen_Height);
    imageViewBackGround2.image = [UIImage imageNamed:@"friendlistbg1"];
    UIImage *imageUserInfobg = [DWinUtils getBlurImage:imageViewBackGround2 withRect:CGRectMake(0, 0, kScreen_Width, kContent_Height-346+44) WithRadius:0.3];
    imageViewBackGround2.frame = CGRectMake(0, 0, kScreen_Width, kContent_Height-302);
    imageViewBackGround2.image = imageUserInfobg;
    [secondAudioview addSubview:imageViewBackGround2];
    if (self.controlAudioPanel!=nil) {
        [self.controlAudioPanel removeFromSuperview];
        self.controlAudioPanel.frame = CGRectMake(0, 44, 320,kContent_Height-346);
        self.controlAudioPanel.backgroundColor = RGBAlpha(255, 255, 255, 0.3);
        [secondAudioview addSubview:self.controlAudioPanel];
    }else
    {
        [self createAudioView];
        [self.controlAudioPanel removeFromSuperview];
        self.controlAudioPanel.frame = CGRectMake(0, 44, 320, kContent_Height-346);
         self.controlAudioPanel.backgroundColor = RGBAlpha(255, 255, 255, 0.3);
        [secondAudioview addSubview:self.controlAudioPanel];

    }
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    titleView.backgroundColor =RGBAlpha(0, 0, 0, 0.3);
    [secondAudioview addSubview:titleView];
    // 取消按钮
    UIButton *btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_cancel addTarget:self action:@selector(confirmOCancelRecording:) forControlEvents:UIControlEventTouchUpInside];
    btn_cancel.tag = 1;
    [btn_cancel setBackgroundImage:[UIImage imageNamed:@"takephoto_cancel"] forState:UIControlStateNormal];
    btn_cancel.frame = CGRectMake(0, 5, 30, 30);
    [titleView addSubview:btn_cancel];
    // 确定按钮
    UIButton *btn_confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_confirm addTarget:self action:@selector(confirmOCancelRecording:) forControlEvents:UIControlEventTouchUpInside];
    btn_confirm.tag = 2;
    [btn_confirm setBackgroundImage:[UIImage imageNamed:@"takephoto_sure"] forState:UIControlStateNormal];
    btn_confirm.frame = CGRectMake(280, 5,30 , 30);
    [titleView addSubview:btn_confirm];
    
   
    
}

- (void)confirmOCancelRecording:(UIButton *)sender
{
    [self cancelAudioFile];
    _controlAudioPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, kContent_Height-336)];
    _controlAudioPanel.backgroundColor = [UIColor clearColor];
    [_controlAudioPanel removeFromSuperview];
    self.controlAudioPanel = nil;
    
    [secondAudioview removeFromSuperview];
    if (sender.tag==2) {
        if (recordFile==nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:@"empty" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            return;
        }
        if ([getAudioArrayFromMerge count]<4) {
            [getAudioArrayFromMerge addObject:recordFile];
            
            switch (whicViewAudioButton) {
                case 0:
                {
                    for (UIButton *btn in mergeView1.subviews) {
                        if (btn.tag==10002) {
                            [btn setBackgroundImage:[UIImage imageNamed:@"textedit_addaudioselected"] forState:UIControlStateNormal];
                        }
                    }
                }
                    break;
                case 1:
                {
                    for (UIButton *btn in mergeView2.subviews) {
                        if (btn.tag==10002) {
                            [btn setBackgroundImage:[UIImage imageNamed:@"textedit_addaudioselected"] forState:UIControlStateNormal];
                        }
                    }
                }
                    break;
                case 2:
                {
                    for (UIButton *btn in mergeView3.subviews) {
                        if (btn.tag==10002) {
                            [btn setBackgroundImage:[UIImage imageNamed:@"textedit_addaudioselected"] forState:UIControlStateNormal];
                        }
                    }
                }
                    break;
                case 3:
                {
                    for (UIButton *btn in mergeView4.subviews) {
                        if (btn.tag==10002) {
                            [btn setBackgroundImage:[UIImage imageNamed:@"textedit_addaudioselected"] forState:UIControlStateNormal];
                        }
                    }
                }
                    break;
                default:
                    break;
            }
        }
    }
}

#pragma mark - create Merge Text View

- (void)createSecondTextView:(UIButton *)btn
{
    secondTextView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    secondTextView.backgroundColor = RGBAlpha(0, 0, 0, 0.3);
    [self.view addSubview:secondTextView];
    
    UIImageView *imageViewBackGround2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    NSLog(@"%f",kScreen_Height);
    imageViewBackGround2.image = [UIImage imageNamed:@"friendlistbg1"];
    UIImage *imageUserInfobg = [DWinUtils getBlurImage:imageViewBackGround2 withRect:CGRectMake(0, 0, kScreen_Width, kContent_Height-346+44) WithRadius:0.3];
    imageViewBackGround2.frame = CGRectMake(0, 0, kScreen_Width, kContent_Height-302);
    imageViewBackGround2.image = imageUserInfobg;
    [secondTextView addSubview:imageViewBackGround2];
    // titleView
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    titleView.backgroundColor =RGBAlpha(0, 0, 0, 0.3);
    [secondTextView addSubview:titleView];
    // 取消按钮
    UIButton *btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_cancel addTarget:self action:@selector(confirmOCancelRecording:) forControlEvents:UIControlEventTouchUpInside];
    btn_cancel.tag = 1;
    [btn_cancel setBackgroundImage:[UIImage imageNamed:@"takephoto_cancel"] forState:UIControlStateNormal];
    btn_cancel.frame = CGRectMake(0, 5, 30, 30);
    [titleView addSubview:btn_cancel];
    // 确定按钮
    UIButton *btn_confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_confirm addTarget:self action:@selector(confirmOCancelRecording:) forControlEvents:UIControlEventTouchUpInside];
    btn_confirm.tag = 2;
    [btn_confirm setBackgroundImage:[UIImage imageNamed:@"takephoto_sure"] forState:UIControlStateNormal];
    btn_confirm.frame = CGRectMake(280, 5,30 , 30);
    [titleView addSubview:btn_confirm];
    // textview
    //UITextView *textView = [UITextView alloc] initWithFrame:CGRectMake(CGFloat x, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    
}

@end
