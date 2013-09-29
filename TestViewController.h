//
//  TestViewController.h
//  DWin1.0
//
//  Created by zang qilong on 13-9-15.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface TestViewController : UIViewController<UINavigationControllerDelegate,AVAudioPlayerDelegate>
{
    NSURL *recordFile;
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
    BOOL isRecording;
}

@end
