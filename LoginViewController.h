//
//  LoginViewController.h
//  DWin1.0
//
//  Created by zang qilong on 13-9-24.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertAnimation.h"
#import "HttpHelper.h"
#import "JSON.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    AlertAnimation*alert;
    HttpHelper*_httpHelperMovieImage;
    LoginViewController*login;
    UIControl *holecontrol;
}
@property(nonatomic,strong)UITextField*login_txt,*login_secret;
@end
