//
//  Singel.h
//  merror
//
//  Created by Mac on 13-8-1.
//  Copyright (c) 2013年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Singel : NSObject

@property(nonatomic)float ft;
@property(nonatomic)float ft1;
@property(nonatomic)int flag;
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)NSArray *fivepicArr,*fourpicArr,*threepicArr;
+(Singel *)danli;

@end
