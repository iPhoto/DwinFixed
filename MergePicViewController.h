//
//  MergePicViewController.h
//  Dori2
//
//  Created by pencho－01 on 13-7-30.
//  Copyright (c) 2013年 pencho－01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
@interface MergePicViewController : UIViewController<MPMediaPickerControllerDelegate>
{
    BOOL isSelectingAssetOne;
    BOOL isSelectingAssetThree;
    BOOL isSelectingAssetTwo;
    BOOL isSelectingAssetFour;
    MPMusicPlayerController*mp;
    
}
@property(nonatomic, strong) AVAsset *firstAsset;
@property(nonatomic, strong) AVAsset *secondAsset;
@property(nonatomic, strong) AVAsset *threeAsset;
@property(nonatomic, strong) AVAsset *fourthAsset;
@property(nonatomic, strong) AVAsset *audioAsset;
@property (nonatomic,retain) NSMutableArray *arr_items;

@end
