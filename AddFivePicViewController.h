//
//  AddFivePicViewController.h
//  DWin1.0
//
//  Created by Mac on 13-9-28.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singel.h"
@interface AddFivePicViewController : UIViewController
{
    NSArray*click_arr;
    UIButton*pic_btn;
    NSArray*unclick_arr;
    NSArray*titile_picArr;
    NSArray*titile_unPicArr;
    //横向拼图
    UIScrollView*toltle_scroll,*toltle_scoroll1;
    //pic demo
    NSArray*pic_arr;
    UIView * back_view1;
    BOOL qqqo;
    BOOL qqqo1;
    float beginx,beginy;
    float beginoriginx,beginoriginy;
    
    NSArray*four_arr,*unfour_arr;
    
    NSArray*five_arr,*unfive_arr;
    
    
    
    
  
    
    NSArray *imageArray;
    
    NSMutableArray *mutableArray;
    
    
    
    Singel*d;
    
    int cutnum_h;
    int cutnum_w;
    
    int cutFlag;
        UIView *title_view;
}

@property(nonatomic,strong) UIImageView*img,*img2,*img1,*img3,*img4;
@property(nonatomic,assign)int flag_num;
@property(nonatomic,strong)NSArray *picarr;///传过来图片的数组
-(void)allPhotosCollected:(NSArray*)imgArray;
@end
