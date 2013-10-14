//
//  MySkillViewController.h
//  DWin1.0
//
//  Created by Mac on 13-9-29.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySkillViewController : UIViewController<UITextFieldDelegate>
{
    UIImageView *imageViewBackGround;
    
    UIImageView *imageViewBackGround2;
    UIView *tiview;
    UIView *title_view;
    UIView *lastView;
    UIView *laview1;
    
    
    UIView *choose_colorview;
    
    NSArray*clicarr;
    NSArray*uncilcarr;
    UITextField *more_texet1,*more_texet2,*more_texet3,*more_texet4,*more_texet5;
    int flag;
}
@end
