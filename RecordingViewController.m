//
// Copyright (c) 2013 Carson McDonald
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
// documentation files (the "Software"), to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
// and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions
// of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
// TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//

#import "RecordingViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import "VideoCameraInputManager.h"

#import "PlayViewController.h"

@interface RecordingViewController (Private)

- (void)updateProgress:(NSTimer *)timer;

- (void)saveOutputToAssetLibrary:(NSURL *)outputFileURL completionBlock:(void (^)(NSError *error))completed;

@end

// Maximum and minumum length to record in seconds
#define MAX_RECORDING_LENGTH 7.0
#define MIN_RECORDING_LENGTH 2.0

// Set the recording preset to use
#define CAPTURE_SESSION_PRESET AVCaptureSessionPreset640x480

// Set the input device to use when first starting
#define INITIAL_CAPTURE_DEVICE_POSITION AVCaptureDevicePositionBack

// Set the initial torch mode
#define INITIAL_TORCH_MODE AVCaptureTorchModeOff

@implementation RecordingViewController
{
    VideoCameraInputManager *videoCameraInputManager;
    
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
    
    NSTimer *progressUpdateTimer;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitFullScreen:) name: MPMoviePlayerDidExitFullscreenNotification object:nil];
}
-(void)exitFullScreen:(NSNotification *)notification{
    [self.player.view removeFromSuperview];
    
}

- (void)setupView
{
    
    _videoPreviewView = [[UIView alloc] init];
    _videoPreviewView.frame = CGRectMake(0, 0, kContent_Width, kContent_Height-68);
    
    [self.view addSubview:_videoPreviewView];
    //captureVideoPreviewLayer.frame = self.videoPreviewView.bounds;
    videoCameraInputManager = [[VideoCameraInputManager alloc] init];
    
    videoCameraInputManager.maxDuration = MAX_RECORDING_LENGTH;
    videoCameraInputManager.asyncErrorHandler = ^(NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.domain delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    };
    
    NSError *error;
    [videoCameraInputManager setupSessionWithPreset:CAPTURE_SESSION_PRESET
                                  withCaptureDevice:INITIAL_CAPTURE_DEVICE_POSITION
                                      withTorchMode:INITIAL_TORCH_MODE
                                          withError:&error];
    
    
    if(error)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.domain delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:videoCameraInputManager.captureSession];
        
        self.videoPreviewView.layer.masksToBounds = YES;
        captureVideoPreviewLayer.frame = self.videoPreviewView.bounds;
        
        captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        [self.videoPreviewView.layer insertSublayer:captureVideoPreviewLayer below:self.videoPreviewView.layer.sublayers[0]];
        
        // Start the session. This is done asychronously because startRunning doesn't return until the session is running.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [videoCameraInputManager.captureSession startRunning];
            
        });
        
        self.busyView.frame = CGRectMake(self.busyView.frame.origin.x, -self.busyView.frame.size.height, self.busyView.frame.size.width, self.busyView.frame.size.height);
        self.saveButton.hidden = YES;
    }
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
    [btn_shoot addTarget:self action:@selector(recordTouchDown:) forControlEvents:UIControlEventTouchDown];
    [btn_shoot addTarget:self action:@selector(recordTouchCancel:) forControlEvents:UIControlEventTouchCancel];
    [btn_shoot addTarget:self action:@selector(recordTouchCancel:) forControlEvents:UIControlEventTouchUpInside];
    [btn_shoot addTarget:self action:@selector(recordTouchCancel:) forControlEvents:UIControlEventTouchUpOutside];
    [picProgressView addSubview:btn_shoot];
    // 小图片
    self.saveAndPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveAndPlayBtn.frame = CGRectMake(270, 4, 44, 44);
    [self.controlView addSubview:self.saveAndPlayBtn ];
    [self.saveAndPlayBtn  setBackgroundImage:[UIImage imageNamed:@"takevideo_play"] forState:UIControlStateNormal];
    [self.saveAndPlayBtn addTarget:self action:@selector(saveRecording:) forControlEvents:UIControlEventTouchUpInside];
    // progress
    self.videoRecrodingProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    [self.view addSubview:self.videoRecrodingProgress];
}

- (void)popView:(id)sender
{
    [videoCameraInputManager.captureSession stopRunning];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self setupView];
}

- (void)updateProgress:(NSTimer *)timer
{
    CMTime duration = [videoCameraInputManager totalRecordingDuration];
    
    self.videoRecrodingProgress.progress = CMTimeGetSeconds(duration) / MAX_RECORDING_LENGTH;
    
    if(CMTimeGetSeconds(duration) >= MIN_RECORDING_LENGTH)
    {
        self.saveButton.hidden = NO;
    }
    
    if(CMTimeGetSeconds(duration) >= MAX_RECORDING_LENGTH)
    {
        self.recordButton.enabled = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    captureVideoPreviewLayer.frame = self.videoPreviewView.bounds;
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Record button

- (void)cancelAction:(id)sender
{
    self.saveButton.hidden = YES;
    
    self.videoRecrodingProgress.progress = 0.0;

    [videoCameraInputManager reset];
}

- (void)recordTouchDown:(id)sender
{
    progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                           target:self
                                                         selector:@selector(updateProgress:)
                                                         userInfo:nil
                                                          repeats:YES];
    
    if(videoCameraInputManager.isPaused)
    {
        [videoCameraInputManager resumeRecording];
    }
    else
    {
        [videoCameraInputManager startRecording];
    }
}

- (void)recordTouchCancel:(id)sender
{
    [progressUpdateTimer invalidate];
    [videoCameraInputManager pauseRecording];
}

- (void)recordTouchUp:(id)sender
{
    [progressUpdateTimer invalidate];
    [videoCameraInputManager pauseRecording];
}

- (void)saveRecording:(id)sender
{
    self.saveButton.hidden = YES;
    
    self.busyView.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.busyView.frame = CGRectMake(self.busyView.frame.origin.x, 0, self.busyView.frame.size.width, self.busyView.frame.size.height);
    }];
    
    _finalOutputFileURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@-%ld.mp4", NSTemporaryDirectory(), @"final", (long)[[NSDate date] timeIntervalSince1970]]];
//    NSString *path = [NSTemporaryDirectory() stringByAppendingString:@"v.mp4"];
//    _finalOutputFileURL = [NSURL fileURLWithPath:path];
    
    [videoCameraInputManager finalizeRecordingToFile:_finalOutputFileURL
                                       withVideoSize:self.videoPreviewView.frame.size
                                          withPreset:AVAssetExportPreset640x480
                               withCompletionHandler:^(NSError *error) {
        
        if(error)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.domain delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
        else
        {
            
            [self saveOutputToAssetLibrary:_finalOutputFileURL completionBlock:^(NSError *saveError) {
                
                [UIView animateWithDuration:0.25 animations:^{
                    self.busyView.frame = CGRectMake(self.busyView.frame.origin.x, -self.busyView.frame.size.height, self.busyView.frame.size.width, self.busyView.frame.size.height);
                } completion:^(BOOL finished) {
                    self.busyView.hidden = YES;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Done" message:@"The video has been saved to your camera roll." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alertView show];
                    });
                }];
             
                [[NSFileManager defaultManager] removeItemAtURL:_finalOutputFileURL error:nil];
                
                self.videoRecrodingProgress.progress = 0.0;
                self.recordButton.enabled = YES;
                
            }];
        }
        
    }];
}

- (void)playVideo
{
    [videoCameraInputManager.captureSession stopRunning];
    NSLog(@"%@",_finalOutputFileURL);
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:_finalOutputFileURL];
    
    //    self.player.scalingMode = MPMovieScalingModeAspectFit;
    self.player.controlStyle = MPMovieControlStyleDefault;
    [self.player prepareToPlay];
    [self.player.view setFrame:self.view.bounds];
    [self.view addSubview:self.player.view];
    self.player.shouldAutoplay = YES;
}

- (void)saveOutputToAssetLibrary:(NSURL *)outputFileURL completionBlock:(void (^)(NSError *error))completed
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library writeVideoAtPathToSavedPhotosAlbum:outputFileURL completionBlock:^(NSURL *assetURL, NSError *error) {
        
        completed(error);
        
    }];
}

@end
