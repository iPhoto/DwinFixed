//
//  ShootViewController.m
//  DWin1.0
//
//  Created by zang qilong on 13-9-20.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//
enum
{
    kNotRecording = 0,
    kRecording,
    kPauseRecording,
    kStopRecording
};

#import "RecordingViewController.h"
#import "CameraEngine.h"
#import "PlayViewController.h"

static const float maxSeconds = 7.5;



@implementation RecordingViewController
{
    
    
    NSTimer *progressUpdateTimer;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitFullScreen:) name: MPMoviePlayerDidExitFullscreenNotification object:nil];
}
-(void)exitFullScreen:(NSNotification *)notification{

    
}

- (void)setupView
{
    self.recordingStatus = kNotRecording;
    self.currentSeconds = 0.;
    [self startPreview];
    
        // controlview
    self.controlView = [[UIView alloc] initWithFrame:CGRectMake(0, kContent_Height-68, 320, 68)];
    self.controlView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.controlView];
    // 取消按钮
    UIButton *btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_cancel setBackgroundImage:[UIImage imageNamed:@"takephoto_cancel"] forState:UIControlStateNormal];
    btn_cancel.frame = CGRectMake(5, 5, 44, 44);
    [btn_cancel addTarget:self action:@selector(popView:) forControlEvents:UIControlEventTouchUpInside];
    [_controlView addSubview:btn_cancel];
    picProgressView = [[PICircularProgressView alloc] initWithFrame:CGRectMake(kGetViewWidth(_controlView)/2, 40, 60, 60)];
    picProgressView.center = CGPointMake(kGetViewWidth(_controlView)/2, kGetViewHeight(_controlView)/2);
    picProgressView.backgroundColor = [UIColor clearColor];
    [picProgressView setProgressFillColor:[UIColor redColor]];
    [picProgressView setOuterBackgroundColor:[UIColor whiteColor]];
    [picProgressView setThicknessRatio:0.09];
    [picProgressView setShowText:0];
    [_controlView addSubview:picProgressView];
    // 拍摄按钮
    UIButton *btn_shoot = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_shoot setBackgroundImage:[UIImage imageNamed:@"takevideo_shoot"] forState:UIControlStateNormal];
    btn_shoot.frame = CGRectMake(0, 0, 50, 50);
    btn_shoot.center = CGPointMake(kGetViewWidth(picProgressView)/2, kGetViewHeight(picProgressView)/2);

    [btn_shoot addTarget:self action:@selector(startRecording:) forControlEvents:UIControlEventTouchUpInside];
    
    [picProgressView addSubview:btn_shoot];
    // 小图片
    self.saveAndPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveAndPlayBtn.frame = CGRectMake(270, 4, 44, 44);
    [self.controlView addSubview:self.saveAndPlayBtn ];
    [self.saveAndPlayBtn  setBackgroundImage:[UIImage imageNamed:@"takevideo_play"] forState:UIControlStateNormal];
    [self.saveAndPlayBtn addTarget:self action:@selector(playMp4:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)playMp4:(id)sender
{
    PlayViewController* vc = [[PlayViewController alloc] init];
    NSString *path = [NSTemporaryDirectory() stringByAppendingString:@"capture.mp4"];
    vc.fileURL = [NSURL fileURLWithPath:path];
    [self presentViewController:vc animated:YES completion:^{
        ;
    }];

}

- (void) startPreview
{
    [[CameraEngine engine] startup];
    self.cameraView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 426)];
    [self.view addSubview:self.cameraView];
    AVCaptureVideoPreviewLayer* preview = [[CameraEngine engine] getPreviewLayer];
    [preview removeFromSuperlayer];
    preview.frame = self.cameraView.bounds;
    //[[preview connection] setVideoOrientation:UIInterfaceOrientationPortrait];
    
    [self.cameraView.layer addSublayer:preview];
}

- (void)startRecording:(id)sender
{
    switch (_recordingStatus) {
        case kNotRecording:
        {
            progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateProgress:) userInfo:Nil repeats:YES];
            [[CameraEngine engine] startCapture];
            _recordingStatus = kRecording;
        }
            
            break;
        case kRecording:
        {
            [[CameraEngine engine] pauseCapture];
            [progressUpdateTimer invalidate];
            _recordingStatus = kPauseRecording;
        }
            
            break;
        case kPauseRecording:
        {
            
            [[CameraEngine engine] resumeCapture];
            progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateProgress:) userInfo:Nil repeats:YES];
            _recordingStatus = kRecording;
        }
            
            break;
        case kStopRecording:
        {
            _recordingStatus = kNotRecording;
            self.currentSeconds = 0.;
            [[CameraEngine engine] stopCapture];
        }
            
            break;
        default:
            break;
    }
    
    
}

- (void)updateProgress:(id)sender
{
    if (self.currentSeconds<=maxSeconds) {
        self.currentSeconds+=0.05;
        picProgressView.progress = self.currentSeconds/maxSeconds;
    }else
    {
        NSLog(@"stop ed");
        _recordingStatus = kNotRecording;
        self.currentSeconds = 0.;
        [[CameraEngine engine] stopCapture];
        [progressUpdateTimer invalidate];
    }
    
}

- (void)pauseRecording:(id)sender
{
    [[CameraEngine engine] pauseCapture];
}

- (void)stopRecording:(id)sender
{
    [[CameraEngine engine] stopCapture];
}
- (void)resumeRecording:(id)sender
{
    [[CameraEngine engine] resumeCapture];
}

- (void)popView:(id)sender
{
 
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
   
    [self setupView];
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
