//
//  TextEditViewController.h
//  DWin1.0
//
//  Created by zang qilong on 13-9-16.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PICircularProgressView.h"
#import <AVFoundation/AVFoundation.h>
#import "ShootViewController.h"
#import "AGViewController.h"
@interface TextEditViewController : UIViewController<AVAudioPlayerDelegate,UITextViewDelegate,ShootViewControllerDelegate,AGImagePickerControllerDelegate>
{
    NSTimer *recorderTimer;
    PICircularProgressView *picProgressView;
    PICircularProgressView *picProgressView2;
     double timecount;
    NSURL *recordFile;
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
    BOOL isRecording;
    UIButton *btn_control_recorder;
    UIButton *btn_control_recorder2;
    UILabel *labelTimes;
    UILabel *labelRealTime;
    UILabel *labelTimes2;
    UILabel *labelRealTime2;
    UIView *controlView;
   // int controlImageType;
    UIButton *btn_takephoto;
    UIButton *btn_takevideo;
    UIButton *btn_takeaudio;
    UIButton *btn_takephiz;
    UITextView *mtextView;
    // 
    UIView *mergeView1;
    UIView *mergeView2;
    UIView *mergeView3;
    UIView *mergeView4;
    //
    UIImageView *placeholdImage;
    //
    NSMutableArray *getAudioArrayFromMerge;
    NSMutableArray *getPictureFromMerge;
     NSMutableArray *getTextFromMerge;
    //
    UIView *secondAudioview;
    UIView *secondTextView;
        UIImage*im,*im1,*im2,*im4,*im3;
    //
    BOOL isGifPress;
    
}
@property (nonatomic,assign) int controlImageType;
@property (nonatomic,retain) UIView *controPhotoPanel;
@property (nonatomic,retain) UIView *controVideoPanel;
@property (nonatomic,retain)  UIView *controlAudioPanel;
@property (nonatomic,retain)  UIView *MergePartPanel;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property(nonatomic ,strong)NSMutableArray *arr_push,*arr_push3,*arr_push4,*gifarr;
@end
