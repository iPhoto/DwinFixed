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

#import <UIKit/UIKit.h>
#import "PICircularProgressView.h"
#import "ZXMacro.h"
#import <MediaPlayer/MediaPlayer.h>
@interface RecordingViewController : UIViewController
{
   PICircularProgressView *picProgressView;
}

@property (strong, nonatomic)  UIView *videoPreviewView;

@property (strong, nonatomic) UIProgressView *videoRecrodingProgress;

@property (strong, nonatomic)  UIView *busyView;

@property (strong, nonatomic)  UIButton *saveButton;
@property (strong, nonatomic) UIButton *recordButton;
@property (strong, nonatomic)  UIButton *cancelButton;
@property (strong,nonatomic) UIView *controlView;
@property (strong,nonatomic) UIButton *saveAndPlayBtn;
@property (nonatomic, retain) MPMoviePlayerController* player;
@property (nonatomic,retain) NSURL *finalOutputFileURL;
@property (nonatomic,retain) NSURL *finalOutputFileURL2;


- (void)recordTouchDown:(id)sender;
- (void)recordTouchCancel:(id)sender;
- (void)recordTouchUp:(id)sender;
- (void)saveRecording:(id)sender;
- (void)cancelAction:(id)sender;

@end