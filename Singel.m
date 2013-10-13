//
//  Singel.m
//  merror
//
//  Created by Mac on 13-8-1.
//  Copyright (c) 2013年 Mac. All rights reserved.
//

#import "Singel.h"

@implementation Singel
static Singel *zl_login;
+(Singel *)danli
{
    
    @synchronized(self)
    {
        if (zl_login==nil)
        {
            zl_login=[[Singel alloc] init];
        }
    }
    return zl_login;

}
-(void)pic
{


}
@end
