//
//  HttpHelper.m
//  SnsDemo
//
//  Created by DuHaiFeng on 13-5-23.
//  Copyright (c) 2013年 dhf. All rights reserved.
//

#import "HttpHelper.h"
#import "ASIFormDataRequest.h"

@implementation HttpHelper

@synthesize downloadData,delegate,method,type,mUrl;

- (void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

-(id)init
{
    if (self=[super init]) {
        downloadData=[[NSMutableData alloc] init];
        
    }
    return self;
}
-(void)downloadFromUrl:(NSString *)url
{
    self.mUrl=url;
    
    NSURL *newUrl=[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    httpConnection=[[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:newUrl] delegate:self];
}

//收到服务器的回应
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [downloadData setLength:0];
}

//收到服务器发送的数据(多次调用)
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [downloadData appendData:data];
}

//数据下载(请求)完成
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if ([self.delegate respondsToSelector:self.method]) {
        [self.delegate performSelector:self.method withObject:self];
    }
    else{
        //NSStringFromSelector将指定的方法转换成字符串
        NSLog(@"回调方法%@没实现", NSStringFromSelector(self.method));
    }
}

//下载失败
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //清空下载结果
    [downloadData setLength:0];
    
    //检查delegate对象是否实现了方法method
    if ([self.delegate respondsToSelector:self.method]) {
        //调用对象delegate的方法method，参数为self
        [self.delegate performSelector:self.method withObject:self];
    }
}

//ASI下载方法
-(void)downloadFromUrlWithASI:(NSString *)url{
    
    //方法stringByAddingPercentEscapesUsingEncoding是字符串的类别方法
    //作用是将网址中的非法字符及中文編码
    NSURL *newUrl=[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:newUrl];
    request.delegate=self;
    //启动异步下载
    [request startAsynchronous];
    //[request startSynchronous];
}
//第三方http请求完成的协议方法
-(void)requestFinished:(ASIHTTPRequest *)request
{
    //清除旧数据
    [downloadData setLength:0];
    //保存新数据
    [downloadData appendData:[request responseData]];
    
    if ([self.delegate respondsToSelector:self.method]) {
        [self.delegate performSelector:self.method withObject:self];
    }
    else{
        
        //NSStringFromSelector将指定的方法转换成字符串
        NSLog(@"回调方法%@没实现", NSStringFromSelector(self.method));
    }
}

//ASI的下载失败
-(void)requestFailed:(ASIHTTPRequest *)request
{
    //清除旧数据
    [downloadData setLength:0];
    
    if ([self.delegate respondsToSelector:self.method]) {
        [self.delegate performSelector:self.method withObject:self];
    }
    else{
        //NSStringFromSelector将指定的方法转换成字符串
        NSLog(@"回调方法%@没实现", NSStringFromSelector(self.method));
    }
}

-(void)downloadFromUrlWithASIByPost:(NSString *)url dict:(NSDictionary *)dict file:(NSString*)name
{
    //方法stringByAddingPercentEscapesUsingEncoding是字符串的类别方法
    //作用是将网址中的非法字符及中文編码
    NSURL *newUrl=[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:newUrl];
   
    //新浪微博头
    //[request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    
    request.delegate=self;
    
    for (NSString *key in [dict allKeys]) {
        id object=[dict objectForKey:key];
        //如果是二进制数据(在我们程序中是上传文件)
        if ([object isKindOfClass:[NSData class]]) {
            //上传文件
            //第一个参数为上传的文件的二进制数据
            //第二个参数为上传的文件名
            //第三个参数为上传的文件类型
            //第四个参数为这个参数名
            [request setData:object withFileName:name   andContentType:nil forKey:key];
            
            //[request setFile:<#(NSString *)#> forKey:<#(NSString *)#>]
        }
        else{//普通参数值
            //[request setd]
            [request setPostValue:object forKey:key];
        }
    }
    
    [request startAsynchronous];
    
}

@end
