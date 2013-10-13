//
//  MergePicViewController.m
//  Dori2
//
//  Created by pencho－01 on 13-7-30.
//  Copyright (c) 2013年 pencho－01. All rights reserved.
//

#import "MergePicViewController.h"


@interface MergePicViewController ()

@end

@implementation MergePicViewController
@synthesize firstAsset, secondAsset, audioAsset,threeAsset,fourthAsset;
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
    self.navigationItem.hidesBackButton = YES;
}

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
    [btn_right addTarget:self action:@selector(mergeAndSave:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
    self.navigationItem.rightBarButtonItem = rightBar;
    // 标题
    self.navigationItem.title = @"Merge";
}


-(void) initView
{
    [self setNavgationBar];
    _arr_items = [[NSMutableArray alloc] initWithCapacity:0];
    // 背景图
    UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    [self.view addSubview:imageViewBackGround];
    //
    UIView  *bgWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kContent_Width, kContent_Height-114)];
    bgWhiteView.backgroundColor = RGBAlpha(255., 255., 255., 0.4);
    [self.view addSubview:bgWhiteView];
    // button
    UIButton *btn_addaudio = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_addaudio setBackgroundImage:[UIImage imageNamed:@"mergevideo_loadaudio"] forState:UIControlStateNormal];
   
    [btn_addaudio addTarget:self action:@selector(loadAudio:) forControlEvents:UIControlEventTouchUpInside];
    btn_addaudio.frame = CGRectMake(0, kContent_Height-44-69 , 69, 64);
    [self.view addSubview:btn_addaudio];
    // line
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(75, kContent_Height-44-69, 2, 64)];
    lineImageView.image = [UIImage imageNamed:@"mergevideo_line"];
    [self.view addSubview:lineImageView];
    //load video button
    for (int i=0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(14*(i+1)+44*i+75, kContent_Height-44-69, 44, 64);
        [btn setBackgroundImage:[UIImage imageNamed:@"mergevideo_loadvideo"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(ChooseVideo:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    // playview bg
    UIImageView *playBGImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 320, 405)];
    playBGImageView.image = [UIImage imageNamed:@"mergevideo_playbg"];
    [bgWhiteView addSubview:playBGImageView];
    // play btn
    UIButton *btn_playVideo = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_playVideo setBackgroundImage:[UIImage imageNamed:@"mergevideo_playbtn"] forState:UIControlStateNormal];
    
    [btn_playVideo addTarget:self action:@selector(playAvssetItems) forControlEvents:UIControlEventTouchUpInside];
    btn_playVideo.frame = CGRectMake(0, 10 , 320, 405);
    [bgWhiteView addSubview:btn_playVideo];
}

- (void)playAvssetItems
{
    
}

-(void)navBtnClick:(UIButton *)sender
{
    if (sender.tag==1) {
         [self.navigationController popViewControllerAnimated:YES];
    }
   
   
}

- (void)btnProcessOK
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isSelectingAssetOne = YES;
    [self initView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - merge video
- (void)loadAudio:(id)sender
{
    
    //    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    //    //MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] init];
    //    mediaPicker.delegate = self;
    //    mediaPicker.allowsPickingMultipleItems=NO;
    //    mediaPicker.prompt = @"Select Audio";
    //    [self presentModalViewController:mediaPicker animated:YES];
    //    //[self presentViewController:mediaPicker animated:YES completion:^{
    //       // ;
    //   //}];
    //
    
    MPMediaPickerController *mpc = [[MPMediaPickerController alloc]initWithMediaTypes:MPMediaTypeAny];
    mpc.delegate = self;//委托
    mpc.prompt =@"Please select a music";//提示文字
    mpc.allowsPickingMultipleItems=NO;//是否允许一次选择多个
    
    
    [self presentViewController:mpc animated:YES completion:nil];
    
}

- (void)mergeAndSave:(id)sender
{
    NSLog(@"prepare start merge");
    if (!firstAsset) {
        NSLog(@"firstasset not nil");
    }
    if (!secondAsset) {
        NSLog(@"secondasset not nil");
    }
    if (firstAsset !=nil && secondAsset!=nil) {
        NSLog(@"run merge video");
        
        AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
        
        AVMutableCompositionTrack *firstTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                            preferredTrackID:kCMPersistentTrackID_Invalid];
        [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, firstAsset.duration)
                            ofTrack:[[firstAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:kCMTimeZero error:nil];
        [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, secondAsset.duration)
                            ofTrack:[[secondAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:firstAsset.duration error:nil];
        [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, threeAsset.duration) ofTrack:[[threeAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:CMTimeAdd(firstAsset.duration, secondAsset.duration) error:nil];
        
        CMTime ontwo = CMTimeAdd(firstAsset.duration, secondAsset.duration);
        [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, fourthAsset.duration) ofTrack:[[fourthAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:CMTimeAdd(ontwo, threeAsset.duration) error:nil];
        
        if (audioAsset!=nil){
            AVMutableCompositionTrack *AudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                                preferredTrackID:kCMPersistentTrackID_Invalid];
            [AudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, CMTimeAdd(firstAsset.duration, secondAsset.duration))
                                ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];
        }
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
                                 [NSString stringWithFormat:@"mergeVideo-%d.mov",arc4random() % 1000]];
        NSURL *url = [NSURL fileURLWithPath:myPathDocs];
        
        AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                          presetName:AVAssetExportPresetHighestQuality];
        exporter.outputURL=url;
        exporter.outputFileType = AVFileTypeQuickTimeMovie;
        exporter.shouldOptimizeForNetworkUse = YES;
        [exporter exportAsynchronouslyWithCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self exportDidFinish:exporter];
            });
        }];
    }
    
}


-(void)ChooseVideo:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Saved Album Found"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        
        [self startMediaBrowserFromViewController:self usingDelegate:self];
    }
}


-(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id)delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil)) {
        return NO;
    }
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    
    mediaUI.allowsEditing = YES;
    mediaUI.delegate = delegate;
    
    [controller presentModalViewController: mediaUI animated: YES];
    return YES;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    [self dismissModalViewControllerAnimated:NO];
    
    if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        if (isSelectingAssetOne){
            NSLog(@"Video One  Loaded");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Asset Loaded" message:@"Video One Loaded"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            firstAsset = [AVAsset assetWithURL:[info objectForKey:UIImagePickerControllerMediaURL]];
            [_arr_items addObject:firstAsset];
            isSelectingAssetOne = NO;
            isSelectingAssetTwo = YES;
            return;
        }
        if (isSelectingAssetTwo) {
            NSLog(@"Video two Loaded");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Asset Loaded" message:@"Video Two Loaded"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            secondAsset = [AVAsset assetWithURL:[info objectForKey:UIImagePickerControllerMediaURL]];
            isSelectingAssetTwo= NO;
            isSelectingAssetThree = YES;
            [_arr_items addObject:secondAsset];
            return;
            
        }
        if (isSelectingAssetThree) {
            NSLog(@"Video Three  Loaded");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Asset Loaded" message:@"Video three Loaded"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            threeAsset = [AVAsset assetWithURL:[info objectForKey:UIImagePickerControllerMediaURL]];
            [_arr_items addObject:threeAsset];
            isSelectingAssetThree = NO;
            isSelectingAssetFour = YES;
            return;
        }
        if (isSelectingAssetFour) {
            NSLog(@"Video fourth  Loaded");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Asset Loaded" message:@"Video three Loaded"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            fourthAsset = [AVAsset assetWithURL:[info objectForKey:UIImagePickerControllerMediaURL]];
            [_arr_items addObject:fourthAsset];
            isSelectingAssetFour = NO;
        }
    }
}





-(void)exportDidFinish:(AVAssetExportSession*)session {
    if (session.status == AVAssetExportSessionStatusCompleted) {
        NSURL *outputURL = session.outputURL;
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:outputURL]) {
            [library writeVideoAtPathToSavedPhotosAlbum:outputURL completionBlock:^(NSURL *assetURL, NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"
                                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    } else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:@"Saved To Photo Album"
                                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    }
                });
            }];
        }
    }
    audioAsset = nil;
    firstAsset = nil;
    secondAsset = nil;
    //[activityView stopAnimating];
}

//可以处理所选取的内rong
-(void) mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    NSArray *selectedSong = [mediaItemCollection items];
    if ([selectedSong count] > 0) {
        MPMediaItem *songItem = [selectedSong objectAtIndex:0];
        NSURL *songURL = [songItem valueForProperty:MPMediaItemPropertyAssetURL];
        audioAsset = [AVAsset assetWithURL:songURL];
        NSLog(@"Audio Loaded");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Asset Loaded" message:@"Audio Loaded"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    [self dismissModalViewControllerAnimated:YES];
}
//负责处理选中后取消的动作
-(void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    [self dismissModalViewControllerAnimated: YES];
}

@end
