//
//  QTMyButton.h
//  MoveButton
//
//  Created by 杨 宏强 on 12-12-30.
//  Copyright (c) 2012年 yanghongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singel.h"






@interface QTMyButton : UIButton
    {
        CGFloat xDistance; //触摸点和中心点x方向移动的距离
        CGFloat yDistance; //触摸点和中心点y方向移动的距离
        UIViewController*vi;
       CIContext  *context;
        CIImage *beginimage;
            CIFilter* filter; CIFilter* filter2; CIFilter* filter3;
        Singel*sg;
        CGPoint c1;
        CGPoint c2;
    
   }
@end
