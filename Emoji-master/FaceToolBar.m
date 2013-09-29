//
//  FaceToolBar.m
//  TestKeyboard
//
//  Created by wangjianle on 13-2-26.
//  Copyright (c) 2013年 wangjianle. All rights reserved.
//

#import "FaceToolBar.h"

@implementation FaceToolBar
@synthesize theSuperView,delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      
        
    }
    return self;
}

-(void)fenxiang
{
    NSLog(@"fenxiang");
}
-(void)zan
{

    NSLog(@"zan");
}
-(id)initWithFrame:(CGRect)frame superView:(UIView *)superView{
    self = [super initWithFrame:frame];
    if (self) {
        
        superView.frame=superView.frame;
        // Initialization code
        //初始化为NO
        keyboardIsShow=NO;
        self.theSuperView=superView;
        //默认toolBar在视图最下方
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f,superView.bounds.size.height - toolBarHeight,superView.bounds.size.width,toolBarHeight)];
        toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        UIEdgeInsets insets = UIEdgeInsetsMake(40, 0, 40, 0);
        [toolBar setBackgroundImage:[[UIImage imageNamed:@"keyBoardBack"] resizableImageWithCapInsets:insets] forToolbarPosition:0 barMetrics:0];
        [toolBar setBarStyle:UIBarStyleBlack];
       
        
        UIImage *toolbarBkg = [[UIImage imageNamed: @"44_white"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
       
            if ([toolBar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)])
               [toolBar setBackgroundImage:toolbarBkg forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
            else {
                UIImageView *background = [[UIImageView alloc] initWithImage:toolbarBkg];
               background.frame = toolBar.frame;
                [toolBar insertSubview:background atIndex:0];
            }

        //可以自适应高度的文本输入框
        textView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(10, 5, 430/2, 58/2)];
        textView.tag=1001;
        textView.placeholder=@"Comment";
                
        textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(4.0f, 0.0f, 10.0f, 0.0f);
        [textView.internalTextView setReturnKeyType:UIReturnKeySend];
        textView.delegate = self;
        textView.maximumNumberOfLines=5;
        [toolBar addSubview:textView];
        [textView release];
        
        
        //转发按钮
        faceButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        faceButton1.tag=1002;
        faceButton1.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
        [faceButton1 setBackgroundImage:[UIImage imageNamed:@"pinglun.png"] forState:UIControlStateNormal];
        [faceButton1 addTarget:self action:@selector(fenxiang) forControlEvents:UIControlEventTouchUpInside];
        faceButton1.frame = CGRectMake(490/2,0,23,44);
        [toolBar addSubview:faceButton1];
        
        //攒按钮
        sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
             sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
        sendButton.enabled=YES;
        [sendButton setBackgroundImage:[UIImage imageNamed:@"xingxing.png"] forState:UIControlStateNormal];
        [sendButton addTarget:self action:@selector(zan) forControlEvents:UIControlEventTouchUpInside];
        sendButton.frame = CGRectMake(576/2,0,23,44);
        [toolBar addSubview:sendButton];
        
        //给键盘注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(inputKeyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(inputKeyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        //创建表情键盘
        if (scrollView==nil) {
            scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, superView.frame.size.height, superView.frame.size.width, keyboardHeight)];
            [scrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"facesBack.png"]]];
            for (int i=0; i<9; i++) {
                FacialView *fview=[[FacialView alloc] initWithFrame:CGRectMake(12+320*i, 15, facialViewWidth, facialViewHeight)];
                [fview setBackgroundColor:[UIColor clearColor]];
                [fview loadFacialView:i size:CGSizeMake(33, 43)];
                fview.delegate=self;
                [scrollView addSubview:fview];
                [fview release];
            }
        }
        [scrollView setShowsVerticalScrollIndicator:NO];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        scrollView.contentSize=CGSizeMake(320*9, keyboardHeight);
        scrollView.pagingEnabled=YES;
        scrollView.delegate=self;
        [superView addSubview:scrollView];
        [scrollView release];
        pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(98, superView.frame.size.height-120, 150, 30)];
        [pageControl setCurrentPage:0];
        pageControl.pageIndicatorTintColor=RGBACOLOR(195, 179, 163, 1);
        pageControl.currentPageIndicatorTintColor=RGBACOLOR(132, 104, 77, 1);
        pageControl.numberOfPages = 9;//指定页面个数
        [pageControl setBackgroundColor:[UIColor clearColor]];
        pageControl.hidden=YES;
        [pageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
        [superView addSubview:pageControl];
        [pageControl release];
        
        [superView addSubview:toolBar];
        [toolBar release];
        // Do any additional setup after loading the view, typically from a nib.
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    int page = scrollView.contentOffset.x / 320;//通过滚动的偏移量来判断目前页面所对应的小白点
    pageControl.currentPage = page;//pagecontroll响应值的变化
}
//pagecontroll的委托方法

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;//获取当前pagecontroll的值
    [scrollView setContentOffset:CGPointMake(320 * page, 0)];//根据pagecontroll的值来改变scrollview的滚动位置，以此切换到指定的页面
}


#pragma mark -
#pragma mark UIExpandingTextView delegate
//改变键盘高度
-(void)expandingTextView:(UIExpandingTextView *)expandingTextView willChangeHeight:(float)height
{
    /* Adjust the height of the toolbar when the input component expands */
    float diff = (textView.frame.size.height - height);
    CGRect r = toolBar.frame;
    r.origin.y += diff;
    r.size.height -= diff;
    toolBar.frame = r;
    if (expandingTextView.text.length>2&&[[Emoji allEmoji] containsObject:[expandingTextView.text substringFromIndex:expandingTextView.text.length-2]]) {
        NSLog(@"最后输入的是表情%@",[textView.text substringFromIndex:textView.text.length-2]);
        textView.internalTextView.contentOffset=CGPointMake(0,textView.internalTextView.contentSize.height-textView.internalTextView.frame.size.height );
    }
    
}
//return方法
- (BOOL)expandingTextViewShouldReturn:(UIExpandingTextView *)expandingTextView{
    [self sendAction];
    return YES;
}
- (BOOL)expandingTextViewShouldBeginEditing:(UIExpandingTextView *)expandingTextView
{
    faceButton1.hidden = YES;
    sendButton.hidden = YES;
    biaoqing_btn.hidden=NO;
    sent_btn.hidden=NO;
    if (face_flag==NO) {
        //表情按钮
        biaoqing_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        biaoqing_btn.tag=1002;
        biaoqing_btn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
        [biaoqing_btn setBackgroundImage:[UIImage imageNamed:@"face_btn"] forState:UIControlStateNormal];
        [biaoqing_btn addTarget:self action:@selector(disFaceKeyboard) forControlEvents:UIControlEventTouchUpInside];
        biaoqing_btn.frame = CGRectMake(468/2,0,26,44);
        [toolBar addSubview:biaoqing_btn];
        
        //xingxing 按钮
        sent_btn  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        sent_btn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
        sent_btn.enabled=YES;
        [sent_btn setBackgroundImage:[UIImage imageNamed:@"sent_btn123.png"] forState:UIControlStateNormal];
        [sent_btn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
        sent_btn.frame = CGRectMake(538/2,0,42,44);
        [toolBar addSubview:sent_btn];
        face_flag=YES;

    }
    
    
    return YES;
}
//文本是否改变
-(void)expandingTextViewDidChange:(UIExpandingTextView *)expandingTextView
{
    NSLog(@"文本的长度%d",textView.text.length);
    /* Enable/Disable the button */
    if ([expandingTextView.text length] > 0)
        sendButton.enabled = YES;
    else
        sendButton.enabled = NO;
}
#pragma mark -
#pragma mark ActionMethods  发送sendAction 音频 voiceChange  显示表情 disFaceKeyboard
-(void)sendAction{
    
    biaoqing_btn.hidden=YES;
    sent_btn.hidden=YES;
    sendButton.hidden=NO;
    faceButton1.hidden=NO;
    if (textView.text.length>0) {
        NSLog(@"点击发送");
        if ([delegate respondsToSelector:@selector(sendTextAction:)])
        {
            [delegate sendTextAction:textView.text];
        }
        [textView clearText];
    }
    
    [textView resignFirstResponder];
    [UIView animateWithDuration:2 animations:^{
        scrollView.frame=CGRectMake(0, 568, 320, keyboardHeight);
           }];
    [UIView animateWithDuration:1.55 animations:^{
        toolBar.frame=CGRectMake(0, 568-88-20, 320, 44);

    }];

}
-(void)voiceChange{
    [self dismissKeyBoard];
}
static int a=0;
-(void)disFaceKeyboard{
    
    if (a%2==0) {
        [biaoqing_btn setBackgroundImage:[UIImage imageNamed:@"detail_txt"] forState:UIControlStateNormal];
        a++;
    }
    else
    {
    
    [biaoqing_btn setBackgroundImage:[UIImage imageNamed:@"face_btn"] forState:UIControlStateNormal];
        a--;
    }
    //如果直接点击表情，通过toolbar的位置来判断
    if (toolBar.frame.origin.y== self.theSuperView.bounds.size.height - toolBarHeight&&toolBar.frame.size.height==toolBarHeight) {
        [UIView animateWithDuration:Time animations:^{
            toolBar.frame = CGRectMake(0, self.theSuperView.frame.size.height-keyboardHeight-toolBarHeight,  self.theSuperView.bounds.size.width,toolBarHeight);
        }];
        [UIView animateWithDuration:Time animations:^{
            [scrollView setFrame:CGRectMake(0, self.theSuperView.frame.size.height-keyboardHeight,self.theSuperView.frame.size.width, keyboardHeight)];
        }];
        [pageControl setHidden:NO];
        [faceButton1 setBackgroundImage:[UIImage imageNamed:@"detail_txt"] forState:UIControlStateNormal];
        return;
    }
    //如果键盘没有显示，点击表情了，隐藏表情，显示键盘
    if (!keyboardIsShow) {
        [UIView animateWithDuration:Time animations:^{
            [scrollView setFrame:CGRectMake(0, self.theSuperView.frame.size.height, self.theSuperView.frame.size.width, keyboardHeight)];
        }];
        [textView becomeFirstResponder];
        [pageControl setHidden:YES];
        
    }else{
        
        //键盘显示的时候，toolbar需要还原到正常位置，并显示表情
        [UIView animateWithDuration:Time animations:^{
            toolBar.frame = CGRectMake(0, self.theSuperView.frame.size.height-keyboardHeight-toolBar.frame.size.height,  self.theSuperView.bounds.size.width,toolBar.frame.size.height);
        }];
        
        [UIView animateWithDuration:Time animations:^{
            [scrollView setFrame:CGRectMake(0, self.theSuperView.frame.size.height-keyboardHeight,self.theSuperView.frame.size.width, keyboardHeight)];
        }];
        [pageControl setHidden:NO];
        [textView resignFirstResponder];
    }
    
}
#pragma mark 隐藏键盘
-(void)dismissKeyBoard{
    //键盘显示的时候，toolbar需要还原到正常位置，并显示表情
    [UIView animateWithDuration:Time animations:^{
        toolBar.frame = CGRectMake(0, self.theSuperView.frame.size.height-toolBar.frame.size.height,  self.theSuperView.bounds.size.width,toolBar.frame.size.height);
    }];
    
    [UIView animateWithDuration:Time animations:^{
        [scrollView setFrame:CGRectMake(0, self.theSuperView.frame.size.height,self.theSuperView.frame.size.width, keyboardHeight)];
    }];
    [pageControl setHidden:YES];
    [textView resignFirstResponder];
    //[faceButton1 setBackgroundImage:[UIImage imageNamed:@"detail_face.png"] forState:UIControlStateNormal];
}
#pragma mark 监听键盘的显示与隐藏
-(void)inputKeyboardWillShow:(NSNotification *)notification{
    //键盘显示，设置toolbar的frame跟随键盘的frame
    CGFloat animationTime = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animationTime animations:^{
        CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        NSLog(@"键盘即将出现：%@", NSStringFromCGRect(keyBoardFrame));
        if (toolBar.frame.size.height>45) {
            toolBar.frame = CGRectMake(0, keyBoardFrame.origin.y-20-toolBar.frame.size.height-44,  self.theSuperView.bounds.size.width,toolBar.frame.size.height);
        }else{
            toolBar.frame = CGRectMake(0, keyBoardFrame.origin.y-65-44,  self.theSuperView.bounds.size.width,toolBarHeight);
        }
    }];
   // [faceButton1 setBackgroundImage:[UIImage imageNamed:@"detail_face.png"] forState:UIControlStateNormal];
    keyboardIsShow=YES;
    [pageControl setHidden:YES];
}
-(void)inputKeyboardWillHide:(NSNotification *)notification{
  //  [faceButton1 setBackgroundImage:[UIImage imageNamed:@"detail_txt"] forState:UIControlStateNormal];
    keyboardIsShow=NO;
}

#pragma mark -
#pragma mark facialView delegate 点击表情键盘上的文字
-(void)selectedFacialView:(NSString*)str
{
    NSLog(@"进代理了");
    NSString *newStr;
    if ([str isEqualToString:@"删除"]) {
        if (textView.text.length>0) {
            if ([[Emoji allEmoji] containsObject:[textView.text substringFromIndex:textView.text.length-2]]) {
                NSLog(@"删除emoji %@",[textView.text substringFromIndex:textView.text.length-2]);
                newStr=[textView.text substringToIndex:textView.text.length-2];
            }else{
                NSLog(@"删除文字%@",[textView.text substringFromIndex:textView.text.length-1]);
                newStr=[textView.text substringToIndex:textView.text.length-1];
            }
            textView.text=newStr;
        }
        NSLog(@"删除后更新%@",textView.text);
    }else{
        NSString *newStr=[NSString stringWithFormat:@"%@%@",textView.text,str];
        [textView setText:newStr];
        NSLog(@"点击其他后更新%d,%@",str.length,textView.text);
    }
    NSLog(@"出代理了");
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    [super dealloc];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
