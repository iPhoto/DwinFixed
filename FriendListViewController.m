//
//  FriendListViewController.m
//  DWin1.0
//
//  Created by zang qilong on 13-9-12.
//  Copyright (c) 2013年 zang qilong. All rights reserved.
//
#import "MomentDetailViewController.h"
#import "MySpaceViewController.h"
#import "FriendListViewController.h"
#import "FriendInfoCell.h"
#import "TextEditViewController.h"
#import "GBPathImageView.h"
#import "IIViewDeckController.h"
#import "LoginViewController.h"
#import "TheFirstViewController.h"
#import "DetailsView.h"
#import "PinAnnotation.h"
#import "PinAnnotationView.h"
#import "DetailsAnnotation.h"
#import "DetailsAnnotationView.h"
#import "MKMapView+MapViewUtil.h"
#import "ActivityViewController.h"
#import "ActivityIdeaViewController.h"
#import "ActivityProjectfirstViewController.h"
#import "ActivityJobViewController.h"
#import "ActivityClassifiedViewController.h"
#define kTabAlreadyDownUserViewY 0
#define kTabAlreadyUpUserViewY -80
#define kScrollAlreadyUp 50
#define kScrollAlreadyDown 130


#define  spaceFNum  0.003
#define  oriZoomLevel 12.
#define oriSpan   MKCoordinateSpanMake(0.00494, 0.00538)
#define oriCenterCoordinate  CLLocationCoordinate2DMake(30.658273, 104.067864)
@interface FriendListViewController ()
{
    PinAnnotation       *_pinAnnotation;
    DetailsAnnotation   *_detailsAnnotation;
    NSMutableArray      *_detailsAnnoArray;
}
@end

@implementation FriendListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)setactivity
{
    
    
    scr = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 60, 300, 500)];
    scr.backgroundColor = [UIColor whiteColor];
    scr.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    scr.backgroundColor = [UIColor clearColor];
    scr.contentSize = CGSizeMake(300, 1444);
    scr.delegate = self;
    [self.view addSubview:scr];
    
    ///////////////////////////first  view //////////////////////////////
    
    back_View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 252)];
    
    back_View.backgroundColor = RGBAlpha(1, 1, 1, 0.3);
    
    back_View.layer.cornerRadius = 5;
    
    [scr addSubview:back_View];
    
    UIImageView *bacView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    UIImageView *linview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50+69, 300, 1)];
    bacView.userInteractionEnabled = YES;
    bacView .image = [UIImage imageNamed:@"activity_main_nav"];
    linview .image = [UIImage imageNamed:@"activity_line"];
    
    [back_View addSubview: bacView];
    //[back_View addSubview: linview];
    
    //    /////////////////acccess pic ////////////////
    UIImageView *access_imgv = [[UIImageView alloc]initWithFrame:CGRectMake(558/2, 17, 9, 16)];
    access_imgv.image = [UIImage imageWithContentsOfFile:FileS(@"activity_right_arrow", @"png")];
    [bacView addSubview:access_imgv];
    //
    
    UILabel*lab_title=[[UILabel alloc]initWithFrame:CGRectMake(50, 0, 200, 50)];
    lab_title.backgroundColor = [UIColor clearColor];
    lab_title.text = @"Idea";
    lab_title.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:18];
    lab_title.textColor = [UIColor whiteColor];
    [back_View addSubview:lab_title];
    
    UIButton *btn_title = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_title.frame = CGRectMake(0, 0, 300, 44);
    [btn_title addTarget:self action:@selector(changetxt) forControlEvents:UIControlEventTouchUpInside];
    [bacView addSubview:btn_title];
    
    UIButton *btn_headtitle = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_headtitle.frame = CGRectMake(8, 8, 34, 34);
    
    [btn_headtitle setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_idea_pic", @"png")] forState:UIControlStateNormal];
    [bacView addSubview:btn_headtitle];
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 200, 64/2)];
    
    lab.text = @"Most Popular";
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = [UIColor whiteColor];
    [back_View addSubview:lab];
    
    
    /////////////////最热的人的头像image,逗号img////////
    UIImageView *imgView      = [[UIImageView alloc]initWithFrame:CGRectMake(10, 82, 34, 34)];
    UIImageView *yinhao_imgv  = [[UIImageView alloc]initWithFrame:CGRectMake(64, 82, 10, 11)];
    UIImageView *fist_line    = [[UIImageView alloc]initWithFrame:CGRectMake(1, 50+314/2, 298, 1)];
    UIImageView *yinhao_imgv2 = [[UIImageView alloc]initWithFrame:CGRectMake(560/2, 186, 10, 11)];
    
    imgView.image      = [UIImage imageWithContentsOfFile:FileS(@"acti_small", @"png")];
    yinhao_imgv.image  = [UIImage imageWithContentsOfFile:FileS(@"activit_idea_yinhao1", @"png")];
    fist_line.image    = [UIImage imageWithContentsOfFile:FileS(@"activity_line", @"png")];
    yinhao_imgv2.image = [UIImage imageWithContentsOfFile:FileS(@"activit_idea_yinhao2", @"png")];
    
    [back_View addSubview:yinhao_imgv2];
    [back_View addSubview:imgView];
    [back_View addSubview:yinhao_imgv];
    [back_View addSubview:fist_line];
    
    ///////横线下面的两个按钮////////////
    
    for (int a = 0; a<2; a++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(211+44*a, 314/2+50, 44, 44);
        btn.tag = 10000+a;
        [btn addTarget:self action:@selector(firstBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (a==0) {
            [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"avtivity_write", @"png")] forState:UIControlStateNormal];
        }
        if (a==1) {
            [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_star", @"png")] forState:UIControlStateNormal];
        }
        [back_View addSubview:btn];
    }
    
    UILabel * txtlabel =[[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 35)];
    UILabel * detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 130, 200, 35)];
    txtlabel.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:22*0.6];
    detailLabel.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:22*0.6];
    txtlabel.text = @"Chiledhood";
    detailLabel.text = @"If one begins with the phenomenology of consciousness one must give an account ";
    txtlabel.backgroundColor = [UIColor clearColor];
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.numberOfLines = 2;
    [detailLabel sizeToFit];
    
    txtlabel.textColor = [UIColor whiteColor];
    detailLabel.textColor = [UIColor whiteColor];
    [back_View addSubview:txtlabel];
    [back_View addSubview:detailLabel];
    
    
    UILabel *contjoin = [[UILabel alloc]initWithFrame:CGRectMake(20, 50+314/2, 150, 44)];
    contjoin.text = @"100000Joins";
    contjoin.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:24*0.6];
    contjoin.backgroundColor = [UIColor clearColor];
    contjoin.textColor = [UIColor whiteColor];
    [back_View addSubview:contjoin];
    
    
    UILabel* timelabel = [[UILabel alloc]initWithFrame:CGRectMake(235, 50, 120, 32)];
    timelabel.text = @"2013-09-09";
    timelabel.backgroundColor = [UIColor clearColor];
    timelabel.textColor = [UIColor whiteColor];
    timelabel.font =[UIFont fontWithName:HELVETICANEUE_LIGHT size:18*0.6];
    [ back_View addSubview: timelabel];
    [ back_View2 addSubview: timelabel];
    [ back_View3 addSubview: timelabel];
    [ back_View4 addSubview: timelabel];
    
    
    
    
    
    
    ///////////////////////////2  view //////////////////////////////
    
    back_View2 = [[UIView alloc]initWithFrame:CGRectMake(0, 262, 300, 252)];
    
    back_View2.backgroundColor = RGBAlpha(1, 1, 1, 0.3);
    
    back_View2.layer.cornerRadius = 5;
    
    [scr addSubview:back_View2];
    
    UIImageView *bacView2  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    UIImageView *linview2  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50+69, 300, 1)];
    bacView2.userInteractionEnabled = YES;
    bacView2 .image = [UIImage imageNamed:@"activity_main_nav"];
    linview2 .image = [UIImage imageNamed:@"activity_line"];
    
    [back_View2 addSubview: bacView2];
    //[back_View addSubview: linview];
    
    //    /////////////////acccess pic ////////////////
    UIImageView *access_imgv2 = [[UIImageView alloc]initWithFrame:CGRectMake(558/2, 17, 9, 16)];
    access_imgv2.image = [UIImage imageWithContentsOfFile:FileS(@"activity_right_arrow", @"png")];
    [bacView2 addSubview:access_imgv2];
    //
    
    UILabel*lab_title2=[[UILabel alloc]initWithFrame:CGRectMake(50, 0, 200, 50)];
    lab_title2.backgroundColor = [UIColor clearColor];
    lab_title2.text = @"Project";
    lab_title2.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:18];
    lab_title2.textColor = [UIColor whiteColor];
    [back_View2 addSubview:lab_title2];
    
    
    
    UIButton *btn_headtitle2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_headtitle2.frame = CGRectMake(8, 8, 34, 34);
    
    [btn_headtitle2 setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_iproject_pic", @"png")] forState:UIControlStateNormal];
    [bacView2 addSubview:btn_headtitle2];
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 200, 64/2)];
    
    lab2.text = @"Most Popular";
    lab2.backgroundColor = [UIColor clearColor];
    lab2.textColor = [UIColor whiteColor];
    [back_View2 addSubview:lab2];
    
    
    /////////////////最热的人的头像image,逗号img////////
    UIImageView *imgView2      = [[UIImageView alloc]initWithFrame:CGRectMake(10, 82, 34, 34)];
    UIImageView *yinhao_imgv22  = [[UIImageView alloc]initWithFrame:CGRectMake(64, 82, 10, 11)];
    UIImageView *fist_line2   = [[UIImageView alloc]initWithFrame:CGRectMake(1, 50+314/2, 298, 1)];
    UIImageView *yinhao_imgv222 = [[UIImageView alloc]initWithFrame:CGRectMake(560/2, 186, 10, 11)];
    
    imgView2.image      = [UIImage imageWithContentsOfFile:FileS(@"acti_small", @"png")];
    yinhao_imgv22.image  = [UIImage imageWithContentsOfFile:FileS(@"activit_idea_greenyinhao1", @"png")];
    fist_line2.image    = [UIImage imageWithContentsOfFile:FileS(@"activity_line", @"png")];
    yinhao_imgv222.image = [UIImage imageWithContentsOfFile:FileS(@"activit_idea_greenyinhao2", @"png")];
    
    [back_View2 addSubview:yinhao_imgv222];
    [back_View2 addSubview:imgView2];
    [back_View2 addSubview:yinhao_imgv22];
    [back_View2 addSubview:fist_line2];
    
    
    UIButton *btn_title2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_title2.frame = CGRectMake(0, 0, 300, 44);
    [btn_title2 addTarget:self action:@selector(changetxt2) forControlEvents:UIControlEventTouchUpInside];
    [back_View2 addSubview:btn_title2];
    ///////横线下面的两个按钮////////////
    
    for (int a = 0; a<2; a++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(211+44*a, 314/2+50, 44, 44);
        btn.tag = 20000+a;
        [btn addTarget:self action:@selector(secondBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (a==0) {
            [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_postcv", @"png")] forState:UIControlStateNormal];
        }
        if (a==1) {
            [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_star", @"png")] forState:UIControlStateNormal];
        }
        [back_View2 addSubview:btn];
    }
    
    UILabel * txtlabel2 =[[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 35)];
    UILabel * detailLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 130, 200, 35)];
    txtlabel2.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:22*0.6];
    detailLabel2.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:22*0.6];
    txtlabel2.text = @"Make a app";
    detailLabel2.text = @"If one begins with the phenomenology of consciousness one must give an account ";
    txtlabel2.backgroundColor = [UIColor clearColor];
    detailLabel2.backgroundColor = [UIColor clearColor];
    detailLabel2.numberOfLines = 2;
    [detailLabel2 sizeToFit];
    
    txtlabel2.textColor = [UIColor whiteColor];
    detailLabel2.textColor = [UIColor whiteColor];
    [back_View2 addSubview:txtlabel2];
    [back_View2 addSubview:detailLabel2];
    
    
    UILabel *contjoin2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 50+314/2, 150, 44)];
    contjoin2.text = @"100000Post CV";
    contjoin2.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:24*0.6];
    contjoin2.backgroundColor = [UIColor clearColor];
    contjoin2.textColor = [UIColor whiteColor];
    [back_View2 addSubview:contjoin2];
    UILabel* timelabel2 = [[UILabel alloc]initWithFrame:CGRectMake(235, 50, 120, 32)];
    timelabel2.text = @"2013-09-09";
    timelabel2.backgroundColor = [UIColor clearColor];
    timelabel2.textColor = [UIColor whiteColor];
    timelabel2.font =[UIFont fontWithName:HELVETICANEUE_LIGHT size:18*0.6];
    
    [ back_View2 addSubview: timelabel2];
    ///////////////////////////3  view //////////////////////////////
    
    back_View3 = [[UIView alloc]initWithFrame:CGRectMake(0, 262+262, 300, 252)];
    
    back_View3.backgroundColor = RGBAlpha(1, 1, 1, 0.3);
    
    back_View3.layer.cornerRadius = 5;
    
    [scr addSubview:back_View3];
    
    UIImageView *bacView3  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    UIImageView *linview3  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50+69, 300, 1)];
    bacView3.userInteractionEnabled = YES;
    bacView3 .image = [UIImage imageNamed:@"activity_main_nav"];
    linview3 .image = [UIImage imageNamed:@"activity_line"];
    
    [back_View3 addSubview: bacView3];
    //[back_View addSubview: linview];
    
    //    /////////////////acccess pic ////////////////
    UIImageView *access_imgv3 = [[UIImageView alloc]initWithFrame:CGRectMake(558/2, 17, 9, 16)];
    access_imgv3.image = [UIImage imageWithContentsOfFile:FileS(@"activity_right_arrow", @"png")];
    [bacView3 addSubview:access_imgv3];
    //
    
    UILabel*lab_title3=[[UILabel alloc]initWithFrame:CGRectMake(50, 0, 200, 50)];
    lab_title3.backgroundColor = [UIColor clearColor];
    lab_title3.text = @"Job";
    lab_title3.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:18];
    lab_title3.textColor = [UIColor whiteColor];
    [back_View3 addSubview:lab_title3];
    
    UIButton *btn_title3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_title3.frame = CGRectMake(0, 0, 300, 44);
    [btn_title3 addTarget:self action:@selector(changetxt3) forControlEvents:UIControlEventTouchUpInside];
    [bacView3 addSubview:btn_title3];
    
    UIButton *btn_headtitle3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_headtitle3.frame = CGRectMake(8, 8, 34, 34);
    
    [btn_headtitle3 setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_job_pic", @"png")] forState:UIControlStateNormal];
    [bacView3 addSubview:btn_headtitle3];
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 200, 64/2)];
    
    lab3.text = @"Most Popular";
    lab3.backgroundColor = [UIColor clearColor];
    lab3.textColor = [UIColor whiteColor];
    [back_View3 addSubview:lab3];
    
    
    /////////////////最热的人的头像image,逗号img////////
    UIImageView *imgView3      = [[UIImageView alloc]initWithFrame:CGRectMake(10, 82, 34, 34)];
    UIImageView *yinhao_imgv33  = [[UIImageView alloc]initWithFrame:CGRectMake(64, 82, 10, 11)];
    UIImageView *fist_line3   = [[UIImageView alloc]initWithFrame:CGRectMake(1, 50+314/2, 298, 1)];
    UIImageView *yinhao_imgv333 = [[UIImageView alloc]initWithFrame:CGRectMake(560/2, 186, 10, 11)];
    
    imgView3.image      = [UIImage imageWithContentsOfFile:FileS(@"acti_small", @"png")];
    yinhao_imgv33.image  = [UIImage imageWithContentsOfFile:FileS(@"activit_idea_brownyinhao1", @"png")];
    fist_line3.image    = [UIImage imageWithContentsOfFile:FileS(@"activity_line", @"png")];
    yinhao_imgv333.image = [UIImage imageWithContentsOfFile:FileS(@"activit_idea_brownyinhao2", @"png")];
    
    [back_View3 addSubview:yinhao_imgv333];
    [back_View3 addSubview:imgView3];
    [back_View3 addSubview:yinhao_imgv33];
    [back_View3 addSubview:fist_line3];
    
    ///////横线下面的两个按钮////////////
    
    for (int a = 0; a<2; a++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(211+44*a, 314/2+50, 44, 44);
        btn.tag = 30000+a;
        [btn addTarget:self action:@selector(thirdBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (a==0) {
            [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_postcv", @"png")] forState:UIControlStateNormal];
        }
        if (a==1) {
            [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_star", @"png")] forState:UIControlStateNormal];
        }
        [back_View3 addSubview:btn];
    }
    
    UILabel * txtlabel3 =[[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 35)];
    UILabel * detailLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(100, 130, 200, 35)];
    txtlabel3.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:22*0.6];
    detailLabel3.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:22*0.6];
    txtlabel3.text = @"Chiledhood";
    detailLabel3.text = @"If one begins with the phenomenology of consciousness one must give an account ";
    txtlabel3.backgroundColor = [UIColor clearColor];
    detailLabel3.backgroundColor = [UIColor clearColor];
    detailLabel3.numberOfLines = 2;
    [detailLabel3 sizeToFit];
    
    txtlabel3.textColor = [UIColor whiteColor];
    detailLabel3.textColor = [UIColor whiteColor];
    [back_View3 addSubview:txtlabel3];
    [back_View3 addSubview:detailLabel3];
    
    
    UILabel *contjoin3 = [[UILabel alloc]initWithFrame:CGRectMake(20, 50+314/2, 150, 44)];
    contjoin3.text = @"100000Joins";
    contjoin3.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:24*0.6];
    contjoin3.backgroundColor = [UIColor clearColor];
    contjoin3.textColor = [UIColor whiteColor];
    [back_View3 addSubview:contjoin3];
    UILabel* timelabel3 = [[UILabel alloc]initWithFrame:CGRectMake(235, 50, 120, 32)];
    timelabel3.text = @"2013-09-09";
    timelabel3.backgroundColor = [UIColor clearColor];
    timelabel3.textColor = [UIColor whiteColor];
    timelabel3.font =[UIFont fontWithName:HELVETICANEUE_LIGHT size:18*0.6];
    
    [ back_View3 addSubview: timelabel3];
    
    ///////////////////////////4  view //////////////////////////////
    
    back_View4 = [[UIView alloc]initWithFrame:CGRectMake(0, 262+262*2, 300, 252)];
    
    back_View4.backgroundColor = RGBAlpha(1, 1, 1, 0.3);
    
    back_View4.layer.cornerRadius = 5;
    
    [scr addSubview:back_View4];
    
    UIImageView *bacView4  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    UIImageView *linview4  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50+69, 300, 1)];
    bacView4.userInteractionEnabled = YES;
    bacView4 .image = [UIImage imageNamed:@"activity_main_nav"];
    linview4 .image = [UIImage imageNamed:@"activity_line"];
    
    [back_View4 addSubview: bacView4];
    //[back_View addSubview: linview];
    
    //    /////////////////acccess pic ////////////////
    UIImageView *access_imgv4 = [[UIImageView alloc]initWithFrame:CGRectMake(558/2, 17, 9, 16)];
    access_imgv4.image = [UIImage imageWithContentsOfFile:FileS(@"activity_right_arrow", @"png")];
    [bacView4 addSubview:access_imgv4];
    //
    
    UILabel*lab_title4=[[UILabel alloc]initWithFrame:CGRectMake(50, 0, 200, 50)];
    lab_title4.backgroundColor = [UIColor clearColor];
    lab_title4.text = @"Classified";
    lab_title4.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:18];
    lab_title4.textColor = [UIColor whiteColor];
    [back_View4 addSubview:lab_title4];
    
    UIButton *btn_title4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_title4.frame = CGRectMake(0, 0, 300, 44);
    [btn_title4 addTarget:self action:@selector(changetxt4) forControlEvents:UIControlEventTouchUpInside];
    [bacView4 addSubview:btn_title4];
    
    UIButton *btn_headtitle4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_headtitle4.frame = CGRectMake(8, 8, 34, 34);
    
    [btn_headtitle4 setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_classified_pic", @"png")] forState:UIControlStateNormal];
    [bacView4 addSubview:btn_headtitle4];
    
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 200, 64/2)];
    
    lab4.text = @"Most Popular";
    lab4.backgroundColor = [UIColor clearColor];
    lab4.textColor = [UIColor whiteColor];
    [back_View4 addSubview:lab4];
    
    
    /////////////////最热的人的头像image,逗号img////////
    UIImageView *imgView4      = [[UIImageView alloc]initWithFrame:CGRectMake(10, 82, 34, 34)];
    UIImageView *yinhao_imgv44  = [[UIImageView alloc]initWithFrame:CGRectMake(64, 82, 10, 11)];
    UIImageView *fist_line4   = [[UIImageView alloc]initWithFrame:CGRectMake(1, 50+314/2, 298, 1)];
    UIImageView *yinhao_imgv444 = [[UIImageView alloc]initWithFrame:CGRectMake(560/2, 186, 10, 11)];
    
    imgView4.image      = [UIImage imageWithContentsOfFile:FileS(@"acti_small", @"png")];
    yinhao_imgv44.image  = [UIImage imageWithContentsOfFile:FileS(@"activit_idea_puecoloeryinhao1", @"png")];
    fist_line4.image    = [UIImage imageWithContentsOfFile:FileS(@"activity_line", @"png")];
    yinhao_imgv444.image = [UIImage imageWithContentsOfFile:FileS(@"activit_idea_puecoloeryinhao2", @"png")];
    
    [back_View4 addSubview:yinhao_imgv444];
    [back_View4 addSubview:imgView4];
    [back_View4 addSubview:yinhao_imgv44];
    [back_View4 addSubview:fist_line4];
    
    ///////横线下面的两个按钮////////////
    
    for (int a = 0; a<2; a++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(211+44*a, 314/2+50, 44, 44);
        btn.tag = 40000+a;
        [btn addTarget:self action:@selector(fouthBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (a==0) {
            [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_qipao", @"png")] forState:UIControlStateNormal];
        }
        if (a==1) {
            [btn setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_star", @"png")] forState:UIControlStateNormal];
        }
        [back_View4 addSubview:btn];
    }
    
    UILabel * txtlabel4 =[[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 35)];
    UILabel * detailLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(100, 130, 200, 35)];
    txtlabel4.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:22*0.6];
    detailLabel4.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:22*0.6];
    txtlabel4.text = @"Buy bike";
    detailLabel4.text = @"If one begins with the phenomenology of consciousness one must give an account ";
    txtlabel4.backgroundColor = [UIColor clearColor];
    detailLabel4.backgroundColor = [UIColor clearColor];
    detailLabel4.numberOfLines = 2;
    [detailLabel4 sizeToFit];
    
    txtlabel4.textColor = [UIColor whiteColor];
    detailLabel4.textColor = [UIColor whiteColor];
    [back_View4 addSubview:txtlabel4];
    [back_View4 addSubview:detailLabel4];
    
    
    UILabel *contjoin4 = [[UILabel alloc]initWithFrame:CGRectMake(20, 50+314/2, 150, 44)];
    contjoin4.text = @"100000Joins";
    contjoin4.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:24*0.6];
    contjoin4.backgroundColor = [UIColor clearColor];
    contjoin4.textColor = [UIColor whiteColor];
    [back_View4 addSubview:contjoin4];
    
    
    UILabel* timelabel4 = [[UILabel alloc]initWithFrame:CGRectMake(235, 50, 120, 32)];
    timelabel4.text = @"2013-09-09";
    timelabel4.backgroundColor = [UIColor clearColor];
    timelabel4.textColor = [UIColor whiteColor];
    timelabel4.font =[UIFont fontWithName:HELVETICANEUE_LIGHT size:18*0.6];
    
    [ back_View4 addSubview: timelabel4];
    
}
/////////横线线面的btn、、、、、、、、
-(void)firstBtn:(UIButton*)sender
{
    
    if (sender.tag-10000==0)
    {
        NSLog(@"1234567890");
    }
    if (sender.tag-10000==1) {
        [(UIButton*)[back_View viewWithTag:10001] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_yellowstar", @"png")] forState:UIControlStateNormal];
    }
    
}

-(void)secondBtn:(UIButton*)sender
{
    
    if (sender.tag-20000==0)
    {
        NSLog(@"1");
    }
    if (sender.tag-20000==1)
    {NSLog(@"2");
        [(UIButton*)[back_View2 viewWithTag:20001] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_yellowstar", @"png")] forState:UIControlStateNormal];
    }
    
}
-(void)thirdBtn:(UIButton*)sender
{
    
    if (sender.tag-30000==0)
    {
        NSLog(@"3");
    }
    if (sender.tag-30000==1)
    {NSLog(@"4");
        [(UIButton*)[back_View3 viewWithTag:30001] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_yellowstar", @"png")] forState:UIControlStateNormal];
    }
    
}
-(void)fouthBtn:(UIButton*)sender
{
    
    if (sender.tag-40000==0)
    {NSLog(@"5");
        
    }
    if (sender.tag-40000==1)
    {NSLog(@"6");
        [(UIButton*)[back_View4 viewWithTag:40001] setBackgroundImage:[UIImage imageWithContentsOfFile:FileS(@"activity_yellowstar", @"png")] forState:UIControlStateNormal];
    }
    
}

/////////////每个view的btn/////////////
-(void)changetxt
{
    ActivityIdeaViewController*ac=[[ActivityIdeaViewController alloc]init];
    [self.navigationController pushViewController:ac animated:YES];
    NSLog(@"1");
    
}
-(void)changetxt2
{
    ActivityProjectfirstViewController*ac=[[ActivityProjectfirstViewController alloc]init];
    [self.navigationController pushViewController:ac animated:YES];
    
    NSLog(@"2");
}
-(void)changetxt3
{
    
    NSLog(@"3");
    ActivityJobViewController*ac=[[ActivityJobViewController alloc]init];
    [self.navigationController pushViewController:ac animated:YES];
    
    
}
-(void)changetxt4
{
    
    NSLog(@"4");
    ActivityClassifiedViewController*ac=[[ActivityClassifiedViewController alloc]init];
    [self.navigationController pushViewController:ac animated:YES];
}

# pragma mark -NavgationCotroller Delegate
-(void)initData
{
    self.dataArray = [NSMutableArray array];//弹出气泡的数据Array
    // [self.dataArray addObject:@"12345"];
    //child item
    NSMutableArray *childAry = [NSMutableArray array];
    for (int i=0; i<8; i++) {
        MapItemInfoVO *child = [[MapItemInfoVO alloc]init];
        child.strId = [NSString stringWithFormat:@"%d",i];
        child.strTitle = [NSString stringWithFormat:@"child%d",i];
        [childAry addObject:child];
    }
    
    //item
    for (int j=0; j<8; j++) {
        MapItemInfoVO *item = [[MapItemInfoVO alloc]init];
        item.strId = [NSString stringWithFormat:@"%d",j];
        item.strTitle = [NSString stringWithFormat:@"Item%d",j];
        item.strDetails = @"hi";
        NSMutableArray *ary = [NSMutableArray array];
        
        int childCount = 3;
        for (int n=0; n<childCount; n++) {
            if (n<[childAry count]) {
                [ary addObject:[childAry objectAtIndex:n]];
            }
        }
        item.aryChild = ary; //小泡泡数据Array，决定了小泡泡个数及显示内容等
        [self.dataArray addObject:item];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    _detailsAnnoArray = [[NSMutableArray alloc]init];
    newLocCoordinate = oriCenterCoordinate;
    [self setupView];
  
    NSLog(@"screen %lf",kScreen_Height);
    NSLog(@"application screen %lf",kContent_Height);
	// Do any additional setup after loading the view.
    
    
    //jieshoutongzhi 
     [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (mytest1) name:@"xiangzuo" object:nil];
}

//进入个人信息详细界面
-(void)mytest1
{
    MySpaceViewController *soace = [[MySpaceViewController alloc]init];
    [self.navigationController pushViewController:soace animated:YES];



}
#pragma mark -create NavigationBar
- (void)setNavgationBar
{
    // 导航条左按钮
    UIButton *btn_left = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_left.frame = CGRectMake(0, 0, 27, 27);
   // [btn_left setBackgroundImage:[UIImage imageNamed:@"friendlist_nav_leftbar"] forState:UIControlStateNormal];
    UIImageView *imageviewleft = [[UIImageView alloc] initWithFrame:CGRectMake(9, 3, 19, 18)];
    imageviewleft.image = [UIImage imageNamed:@"friendlist_nav_leftbar"];
    [btn_left addSubview:imageviewleft];
    btn_left.tag=1;
    [btn_left addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:btn_left];
    self.navigationItem.leftBarButtonItem = leftBar;
    // 导航条右按钮
    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_right.frame = CGRectMake(0, 0, 27, 27);
    [btn_right setBackgroundImage:[UIImage imageNamed:@"friendlist_nav_rightbar"] forState:UIControlStateNormal];
    btn_right.tag=2;
    [btn_right addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
    self.navigationItem.rightBarButtonItem = rightBar;
}

#pragma mark -Setup View

- (void)setupView
{
    //设置 navigationbar
    self.view.userInteractionEnabled = YES;
    [self setNavgationBar];
    self.navigationItem.title = @"DWin";
    // 背景图
   imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    imageViewBackGround.image = [UIImage imageNamed:@"friendlistbg1"];
    imageViewBackGround.userInteractionEnabled = YES;
    [self.view addSubview:imageViewBackGround];
    // 设置高度
    getViewHeight = 0;
    
    // 用户信息
    UIImageView *imageViewBackGround2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    NSLog(@"%f",kScreen_Height);
    imageViewBackGround2.image = [UIImage imageNamed:@"friendlistbg1"];

   userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, kTabAlreadyUpUserViewY, kScreen_Width, 130)];
    UIImage *imageUserInfobg = [DWinUtils getBlurImage:imageViewBackGround2 withRect:CGRectMake(0, 64, kScreen_Width, 130) WithRadius:0.3];
    imageViewBackGround2.frame = CGRectMake(0, 0, kScreen_Width, 130);
    imageViewBackGround2.image = imageUserInfobg;
    [userInfoView addSubview:imageViewBackGround2];
    userInfoView.userInteractionEnabled = YES;
    [self.view addSubview:userInfoView];
    // 添加手势
    UITapGestureRecognizer *swipeGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    //[swipeGes setDirection:UISwipeGestureRecognizerDirectionDown];
    swipeGes.numberOfTapsRequired = 1;
    [userInfoView addGestureRecognizer:swipeGes];
    // 用户头像
    UIImage *roundImage = [self makeRoundedImage:[UIImage imageNamed:@"user_headpic"] radius:55/2];
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 12, 55, 55)];
    headImageView.image = roundImage;
    headImageView.layer.cornerRadius = 55/2;
    headImageView.layer.masksToBounds = YES;
    headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [userInfoView addSubview:headImageView];
    // 用户姓名
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(75, 20, 100, 20)];
    userName.backgroundColor = [UIColor clearColor];
    userName.font = [UIFont fontWithName:HELVETICANUEU size:14];
    userName.textColor = [UIColor whiteColor];
    userName.text = @"Mike Jordon";
    [userInfoView addSubview:userName];
    // 用户性别
    UIImageView *imageView_sex = [[UIImageView alloc] initWithFrame:CGRectMake(75, 42,5, 8)];
    imageView_sex.image = [UIImage imageNamed:@"friendlist_male"];
    [userInfoView addSubview:imageView_sex];
    UILabel *label_sex = [DWinUtils createLabelForAutoSize:CGPointMake(84, 41) WithContent:@"Female" WithFontSize:10 WithFontKind:HELVETICANEUE_LIGHT WithTextColor:[UIColor blackColor]];
    label_sex.backgroundColor = [UIColor clearColor];
    [userInfoView addSubview:label_sex];
    // 用户职业
    UILabel *label_Job = [[UILabel alloc] initWithFrame:CGRectMake(120, 42, 100, 10)];
    label_Job.font = [UIFont fontWithName:HELVETICANEUE_LIGHT size:10];
    label_Job.backgroundColor = [UIColor clearColor];
    label_Job.textColor = [UIColor whiteColor];
    label_Job.text = [NSString stringWithFormat:@"Job:%@",@"student"];
    [userInfoView addSubview:label_Job];
    // tabbar
    userTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, 82, 320, 50)];
    userTabBar.backgroundColor = [UIColor clearColor];
    [userInfoView addSubview:userTabBar];
    // 白色方块
    whiteBlock = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 100, 30)];
    whiteBlock.image = [UIImage imageNamed:@"friendlist_whiteblock"];
    [userTabBar addSubview:whiteBlock];
    // 用户选项
    btn_comment = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_comment.frame = CGRectMake(10, 9, 100, 30);
    //[btn_comment setTitle:@"Moment" forState:UIControlStateNormal];
    btn_comment.tag=1;
    [btn_comment addTarget:self action:@selector(moveWhiteBlock:) forControlEvents:UIControlEventTouchUpInside];
    [btn_comment setBackgroundImage:[UIImage imageNamed:@"friendlist_momentselected"] forState:UIControlStateNormal];
    [userTabBar addSubview:btn_comment];
    
    //
    btn_activity = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_activity.frame = CGRectMake(110, 9, 100, 30);
    btn_activity.tag=2;
    [btn_activity addTarget:self action:@selector(moveWhiteBlock:) forControlEvents:UIControlEventTouchUpInside];
    [btn_activity setBackgroundImage:[UIImage imageNamed:@"friendlist_activity"] forState:UIControlStateNormal];
    [userTabBar addSubview:btn_activity];
    
    btn_map = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_map.frame = CGRectMake(210, 9, 100, 30);
    btn_map.tag=3;
    [btn_map addTarget:self action:@selector(moveWhiteBlock:) forControlEvents:UIControlEventTouchUpInside];
    //[btn_map setTitle:@"Map" forState:UIControlStateNormal];
    [btn_map setBackgroundImage:[UIImage imageNamed:@"friendlist_map"] forState:UIControlStateNormal];
    [userTabBar addSubview:btn_map];
    // 上拉下拉标志
    UIImageView *imageArrowUpDown = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width/2, 0, 10, 5)];
    imageArrowUpDown.image = [UIImage imageNamed:@"friendlist_uparrow"];
    [userTabBar addSubview:imageArrowUpDown];
    // 设置tableview
    getViewHeight = getViewHeight+userInfoView.frame.size.height;
    [self setTableView];
    // 设置转盘
    [self createControlPanel];
  
   
}

- (void)moveWhiteBlock:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            //[_mTableView setHidden:NO];
            [UIView animateWithDuration:0.2 animations:^{
                whiteBlock.frame = CGRectMake(10, 9, 100, 30);
            }];
            [btn_comment setBackgroundImage:[UIImage imageNamed:@"friendlist_momentselected"] forState:UIControlStateNormal];
            [btn_activity setBackgroundImage:[UIImage imageNamed:@"friendlist_activity"] forState:UIControlStateNormal];
            [btn_map setBackgroundImage:[UIImage imageNamed:@"friendlist_map"] forState:UIControlStateNormal];
            [userTabBar sendSubviewToBack:whiteBlock];
            if (_mTableView ==nil) {
                [self setTableView];
                _mTableView.frame = CGRectMake(0, _mTableView.frame.origin.y,kScreen_Width ,kScreen_Height) ;
                [_mapView removeFromSuperview];
                [scr removeFromSuperview];
               
            }else
            {
                _mTableView.frame = CGRectMake(0, _mTableView.frame.origin.y, kScreen_Width, kScreen_Height);
                [_mapView removeFromSuperview];
                [scr removeFromSuperview];
                [self.view addSubview:_mTableView];
            }
        }
            [controlView removeFromSuperview];
            break;
        case 2:
        {
            [UIView animateWithDuration:0.2 animations:^{
                whiteBlock.frame = CGRectMake(110, 9, 100, 30);
            }];
            [btn_comment setBackgroundImage:[UIImage imageNamed:@"friendlist_moment"] forState:UIControlStateNormal];
            [btn_activity setBackgroundImage:[UIImage imageNamed:@"friendlist_activityselected"] forState:UIControlStateNormal];
            [btn_map setBackgroundImage:[UIImage imageNamed:@"friendlist_map"] forState:UIControlStateNormal];
            [controlView removeFromSuperview];
            [_mTableView removeFromSuperview];
            [_mapView removeFromSuperview];
            if (scr==nil) {
                [self setactivity];
            }
            else
            {
                [self.view addSubview:scr];
            }
            //[_mTableView setHidden:YES];
        }
            break;
        case 3:
        {
            [UIView animateWithDuration:0.2 animations:^{
                whiteBlock.frame = CGRectMake(210, 9, 100, 30);
            }];
            [btn_comment setBackgroundImage:[UIImage imageNamed:@"friendlist_moment"] forState:UIControlStateNormal];
            [btn_activity setBackgroundImage:[UIImage imageNamed:@"friendlist_activity"] forState:UIControlStateNormal];
            [btn_map setBackgroundImage:[UIImage imageNamed:@"friendlist_mapselected"] forState:UIControlStateNormal];
            if (_mapView ==nil) {
                _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(10, _mTableView.frame.origin.y, 300, kGetViewHeight(_mTableView))];
                _mapView.showsUserLocation = YES;
                _mapView.delegate = self;
               [scr removeFromSuperview];
                [_mTableView removeFromSuperview];
                [self.view addSubview:_mapView];
            }else
            {
                _mapView.frame = CGRectMake(10, _mTableView.frame.origin.y, 300, kGetViewHeight(_mTableView));
                [_mTableView removeFromSuperview];
                [scr removeFromSuperview];
                [self.view addSubview:_mapView];
            }
        }
            [controlView removeFromSuperview];
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = (CLLocation *)[locations lastObject];
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"gestures work");
    [UIView animateWithDuration:0.5 animations:^{
        userInfoView.frame = CGRectMake(0, kTabAlreadyUpUserViewY, kScreen_Width, 130);
        _mTableView.frame = CGRectMake(0, kScrollAlreadyUp, kScreen_Width, kScreen_Height);
         scr.frame=CGRectMake(10, 60, kScreen_Width, kScreen_Height);
    }];
}

#pragma mark -init TableView
- (void)setTableView
{
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScrollAlreadyUp, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    
    _mTableView.backgroundColor = [UIColor clearColor];
    _mTableView.dataSource = self;
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mTableView];
}

#pragma mark - tableview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f,%f",_mTableView.contentOffset.x,_mTableView.contentOffset.y);
    if (_mTableView.contentOffset.y<-100) {
        [UIView animateWithDuration:0.5 animations:^{
            userInfoView.frame = CGRectMake(0, kTabAlreadyDownUserViewY, kScreen_Width, 130);
            _mTableView.frame = CGRectMake(0, kScrollAlreadyDown, kScreen_Width, kScreen_Height);
scr.frame = CGRectMake(10, 40+100, kScreen_Width, kScreen_Height);
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"FriendInfoCell";
    FriendInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell = [[FriendInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  260;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MomentDetailViewController *moment=[[MomentDetailViewController alloc]init];
    
    [self.navigationController pushViewController:moment animated:YES];

    
}

#pragma mark -GetRoundImage
-(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) radius;
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

#pragma mark - createControlPanel
- (void)createControlPanel
{
    controlView = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x, 194, 0, 0)];
    //controlView.center = CGPointMake(self.view.center.x, 194);
    controlView.layer.cornerRadius = 0;
    controlView.layer.masksToBounds = YES;
    controlView.backgroundColor =[UIColor colorWithWhite:0.9 alpha:0.5];
    [self.view addSubview:controlView];
    // 添加按钮
    UIButton *btn_text = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_text.frame = CGRectMake(88, 0, 48, 48);
    [btn_text setBackgroundImage:[UIImage imageNamed:@"friendlist_textdial"] forState:UIControlStateNormal];
    btn_text.tag = 1000;
    [btn_text addTarget:self action:@selector(dialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:btn_text];
    // 走路
    UIButton *btn_walk = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_walk.frame = CGRectMake(12, 44, 48, 48);
    [btn_walk setBackgroundImage:[UIImage imageNamed:@"friendlist_walkdial"] forState:UIControlStateNormal];
    btn_walk.tag = 1001;
    [btn_walk addTarget:self action:@selector(dialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:btn_walk];
    // 分割线
    UIButton *btn_line = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_line.frame = CGRectMake(12, 132, 48, 48);
    [btn_line setBackgroundImage:[UIImage imageNamed:@"friendlist_linedial"] forState:UIControlStateNormal];
    btn_line.tag = 1002;
    [btn_line addTarget:self action:@selector(dialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:btn_line];
    // voice
    UIButton *btn_voice = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_voice.frame = CGRectMake(88, 177, 48, 48);
    [btn_voice setBackgroundImage:[UIImage imageNamed:@"friendlist_audiodial"] forState:UIControlStateNormal];
    btn_voice.tag = 1003;
    [btn_voice addTarget:self action:@selector(dialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:btn_voice];
    // video
    UIButton *btn_video = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_video.frame = CGRectMake(165, 132, 48, 48);
    [btn_video setBackgroundImage:[UIImage imageNamed:@"friendlist_videodial"] forState:UIControlStateNormal];
    btn_video.tag = 1004;
    [btn_video addTarget:self action:@selector(dialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:btn_video];
    // photo
    UIButton *btn_photo = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_photo.frame = CGRectMake(165, 44, 48, 48);
    [btn_photo setBackgroundImage:[UIImage imageNamed:@"friendlist_photodial"] forState:UIControlStateNormal];
    btn_photo.tag = 1005;
    [btn_photo addTarget:self action:@selector(dialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:btn_photo];
    // cancel
    UIButton *btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_cancel.frame = CGRectMake(0, 0, 48, 48);
    btn_cancel.center = CGPointMake(113, 113);
    [btn_cancel setBackgroundImage:[UIImage imageNamed:@"friendlist_canceldial"] forState:UIControlStateNormal];
    btn_cancel.tag = 1006;
    //btn_cancel.alpha = 0.7;
    [btn_cancel addTarget:self action:@selector(dialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:btn_cancel];
}
-(void)obseve
{



}

- (void)dialBtnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 1000:
        {
            TextEditViewController *text = [[TextEditViewController alloc] init];
            text.controlImageType = 6;
            [self.navigationController pushViewController:text animated:YES];
            break;
        }
        case 1001:
        {
            ActivityViewController *text = [[ActivityViewController alloc] init];
            //text.controlImageType = 6;
            [self.navigationController pushViewController:text animated:YES];
            break;
        }
            break;
        case 1002:
            
            break;
        case 1003:
        {
            TextEditViewController *text = [[TextEditViewController alloc] init];
            text.controlImageType = 3;
            [self.navigationController pushViewController:text animated:YES];
            break;
        }
        
        case 1004:
        {
            TextEditViewController *text = [[TextEditViewController alloc] init];
            text.controlImageType = 2;
            [self.navigationController pushViewController:text animated:YES];
            break;
        }
        case 1005:
        {
            TextEditViewController *text = [[TextEditViewController alloc] init];
            text.controlImageType = 1;
            [self.navigationController pushViewController:text animated:YES];
            break;
        }
        case 1006:
        {
            [UIView animateWithDuration:0.5 animations:^{
                controlView.frame = CGRectMake(47, 130, 0, 0);
                [controlView removeFromSuperview];
            }];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Methods
-(void)segmentValueChanged
{
    if (_pinAnnotation && [_detailsAnnoArray count]>0) {
        
        if ([_detailsAnnoArray count]>0) {
            
            DetailsAnnotation *last = [_detailsAnnoArray lastObject];
            
            PinAnnotationView *pV = (PinAnnotationView *)[_mapView viewForAnnotation:_pinAnnotation];
            DetailsAnnotationView *dV = (DetailsAnnotationView *)[_mapView viewForAnnotation:last];
            [dV.superview bringSubviewToFront:dV];
            [pV.superview bringSubviewToFront:pV];
            
            
            DetailsAnnotationView *annoView = (DetailsAnnotationView *)[_mapView viewForAnnotation:last];
            [annoView.cell disappearItems:^{
                [_mapView removeAnnotation:last];
                [_detailsAnnoArray removeLastObject];
                
                if ([_detailsAnnoArray count]>0) {
                    _detailsAnnotation = [_detailsAnnoArray objectAtIndex:0];
                }
                else
                {
                    _detailsAnnotation = nil;
                }
                
                [self mapView:self.mapView didSelectAnnotationView:[self.mapView viewForAnnotation:_pinAnnotation]];
                
            }];
            
        }
        
        
    }
    
    
}
-(void)clickItemButton:(ItemView *)btn
{
    
    DLog(@"Click item button _ %d--------------------------------------------",btn.tag);
    
}

-(void)removeAllAnnotations
{
    id userAnnotation = _mapView.userLocation;
    
    NSMutableArray *annotations = [NSMutableArray arrayWithArray:_mapView.annotations];
    [annotations removeObject:userAnnotation];
    
    [_mapView removeAnnotations:annotations];
}

//随意放几个测试数据
-(void)placeTempPins
{
    if (_pinAnnotation) {
        [_mapView deselectAnnotation:_pinAnnotation animated:NO];
    }
    [self removeAllAnnotations];
    
    PinAnnotation *pinAnno = [[PinAnnotation alloc]initWithLatitude: newLocCoordinate.latitude andLongitude:newLocCoordinate.longitude];
    
    [_mapView addAnnotation:pinAnno];
    PinAnnotation *pinAnno1 = [[PinAnnotation alloc]initWithLatitude: newLocCoordinate.latitude-0.1 andLongitude:newLocCoordinate.longitude];
    [_mapView addAnnotation:pinAnno1];
    PinAnnotation *pinAnno2 = [[PinAnnotation alloc]initWithLatitude: newLocCoordinate.latitude-0.2 andLongitude:newLocCoordinate.longitude];
    [_mapView addAnnotation:pinAnno2];
    PinAnnotation *pinAnno3 = [[PinAnnotation alloc]initWithLatitude: newLocCoordinate.latitude-0.3 andLongitude:newLocCoordinate.longitude];
    [_mapView addAnnotation:pinAnno3];
    PinAnnotation *pinAnno4 = [[PinAnnotation alloc]initWithLatitude: newLocCoordinate.latitude-0.4 andLongitude:newLocCoordinate.longitude];
    [_mapView addAnnotation:pinAnno4];
    PinAnnotation *pinAnno5 = [[PinAnnotation alloc]initWithLatitude: newLocCoordinate.latitude-0.5 andLongitude:newLocCoordinate.longitude];
    [_mapView addAnnotation:pinAnno5];
   
    
}
-(void)setMapRegin:(CLLocationCoordinate2D)coordinate
{
    newLocCoordinate = coordinate;
    double level = [_mapView getZoomLevel];
    if (level<oriZoomLevel) {
        level = oriZoomLevel;
    }
    
    [_mapView setCenterCoordinate:newLocCoordinate zoomLevel:level animated:YES];
    
    [self placeTempPins];
    
}

#pragma mark LOCATION
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    newLocCoordinate = userLocation.coordinate;
    
    [self setMapRegin:newLocCoordinate];
    
    self.mapView.showsUserLocation = NO;
	
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
	if (error != nil)
		DLog(@"locate failed: %@", [error localizedDescription]);
	else {
		DLog(@"locate failed");
	}
	
}

- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView
{
	DLog(@"start locate");
}

#pragma mark  Range
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    if ([_detailsAnnoArray count]>0) {
        DetailsAnnotation *first = [_detailsAnnoArray objectAtIndex:0];
        PinAnnotationView *pV = (PinAnnotationView *)[mapView viewForAnnotation:_pinAnnotation];
        DetailsAnnotationView *dV = (DetailsAnnotationView *)[mapView viewForAnnotation:first];
        [dV.superview bringSubviewToFront:dV];
        [pV.superview bringSubviewToFront:pV];
    }
    
    DLog(@"【移动哦ing】");
    
    if (!_detailsAnnotation) {
        return;
    }
    
    CGPoint pinPoint = [mapView convertCoordinate:_detailsAnnotation.coordinate toPointToView:self.view];
    BOOL bContains  = CGRectContainsPoint(self.view.bounds, pinPoint);
    
    if (bContains) {
        DetailsAnnotationView *annoView = (DetailsAnnotationView *)[mapView viewForAnnotation:_detailsAnnotation];
        CGPoint center = self.view.center;//[mapView convertCoordinate:_mapView.centerCoordinate toPointToView:self.view];
        CGFloat angle = [Utils getAngleByPoint:pinPoint center:center];
        [annoView.cell rotationViews:angle];
    }
    else{
        [_mapView deselectAnnotation:_pinAnnotation animated:NO];
    }
    
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    
    if ([_detailsAnnoArray count]>0) {
        DetailsAnnotation *first = [_detailsAnnoArray objectAtIndex:0];
        PinAnnotationView *pV = (PinAnnotationView *)[mapView viewForAnnotation:_pinAnnotation];
        DetailsAnnotationView *dV = (DetailsAnnotationView *)[mapView viewForAnnotation:first];
        [dV.superview bringSubviewToFront:dV];
        [pV.superview bringSubviewToFront:pV];
    }
    
    DLog(@"【将开始移动哦】");
    if (_detailsAnnotation) {
        
        
        CGPoint pinPoint = [mapView convertCoordinate:_detailsAnnotation.coordinate toPointToView:self.view];
        BOOL bContains  = CGRectContainsPoint(self.view.bounds, pinPoint);
        if (!bContains) {
            [_mapView deselectAnnotation:_pinAnnotation animated:NO];
        }
        
    }
    
    
    
}
#pragma mark Annotation
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
{
    DLog(@"【didChangeDragState】");
}
//选中MKAnnotationView
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
	if ([view.annotation isKindOfClass:[PinAnnotation class]]) {
        
        if (_detailsAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _detailsAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            return;
        }
        
        _pinAnnotation = (PinAnnotation *)view.annotation;
        
        DetailsAnnotation *detailsAnno = [[DetailsAnnotation alloc]
                                          initWithLatitude:view.annotation.coordinate.latitude
                                          andLongitude:view.annotation.coordinate.longitude];
        
        [mapView addAnnotation:detailsAnno];
        
        
        
        
        [_detailsAnnoArray insertObject:detailsAnno atIndex:0];
        
        if (!_detailsAnnotation) {
            _detailsAnnotation = detailsAnno;
        }
        
    }
    
    
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
    if ([_detailsAnnoArray count]>0) {
        
        DetailsAnnotation *last = [_detailsAnnoArray lastObject];
        
        PinAnnotationView *pV = (PinAnnotationView *)[mapView viewForAnnotation:_pinAnnotation];
        DetailsAnnotationView *dV = (DetailsAnnotationView *)[mapView viewForAnnotation:last];
        [dV.superview bringSubviewToFront:dV];
        [pV.superview bringSubviewToFront:pV];
        
        
        DetailsAnnotationView *annoView = (DetailsAnnotationView *)[mapView viewForAnnotation:last];
        [annoView.cell disappearItems:^{
            [mapView removeAnnotation:last];
            [_detailsAnnoArray removeLastObject];
            
            if ([_detailsAnnoArray count]>0) {
                _detailsAnnotation = [_detailsAnnoArray objectAtIndex:0];
            }
            else
            {
                _detailsAnnotation = nil;
            }
            
        }];
        
    }
    NSLog(@"de selecte");
    
}
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    //层次次序
    PinAnnotationView *pV = (PinAnnotationView *)[mapView viewForAnnotation:_pinAnnotation];
    DetailsAnnotationView *dV = (DetailsAnnotationView *)[mapView viewForAnnotation:_detailsAnnotation];
    [dV.superview bringSubviewToFront:dV];
    [pV.superview bringSubviewToFront:pV];
}

//设置MKAnnotation上的annotationView
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	
    if ([annotation isKindOfClass:[DetailsAnnotation class]]) {
        
        DetailsAnnotation *anno = (DetailsAnnotation *)annotation;
        _detailsAnnotation = anno;
        NSUInteger num = anno.tag;
        DetailsAnnotationView *annotationView =(DetailsAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"DetailsAnnotationView"];
        if (!annotationView) {
            
            annotationView = [[DetailsAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"DetailsAnnotationView"];
        }
        annotationView.tag = num;
        MapItemInfoVO *vo = [self.dataArray objectAtIndex:num];
        [annotationView setCellUI:vo];
        
        CGPoint selectCenter =[mapView convertCoordinate:annotation.coordinate toPointToView:self.view];
        CGPoint center =self.view.center;//[mapView convertCoordinate:_mapView.centerCoordinate toPointToView:self.view];
        CGFloat angle = [Utils getAngleByPoint:selectCenter center:center];
        CGPoint newCenter = CGPointMake(annotationView.cell.center.x - (annotationView.cell.bounds.size.width/2 * sin(angle)), annotationView.cell.center.y - (annotationView.cell.bounds.size.width/2 * cos(angle)));
        
        
        [annotationView.cell toAppearItemsView:newCenter angle:angle];
        [annotationView.cell setDetailsViewBlock:^(ItemView *btn) {
            [self clickItemButton:btn];
        }];
        
        return annotationView;
        
	}
    else if ([annotation isKindOfClass:[PinAnnotation class]]) {
       
        PinAnnotation *anno = (PinAnnotation *)annotation;
        NSUInteger num = anno.tag;
        static int countnum = 0;
        NSLog(@"anno tag is %d",countnum);
        PinAnnotationView *annotationView =(PinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PinAnnotationView"];
        if (!annotationView) {
            
            annotationView = [[PinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PinAnnotationView"];
            switch (countnum) {
                case 0:
                    annotationView.imgView.image = [UIImage imageNamed:@"mapview_tagshopping"];
                    break;
                case 1:
                    annotationView.imgView.image = [UIImage imageNamed:@"mapview_tagclassifieds"];
                    break;
                case 2:
                    annotationView.imgView.image = [UIImage imageNamed:@"mapview_tagjob"];
                    break;
                case 3:
                    annotationView.imgView.image = [UIImage imageNamed:@"mapview_tagmoment"];
                    break;
                case 4:
                    annotationView.imgView.image = [UIImage imageNamed:@"mapview_taglight"];
                    break;
                case 5:
                    annotationView.imgView.image = [UIImage imageNamed:@"mapview_tagwardrobe"];
                    break;
                default:
                    break;
            }
            
            countnum++;
        }
        annotationView.tag = num;
        return annotationView;
        
    }
	return nil;
}


#pragma mark -Button Action

- (void)navBtnClick:(UIButton *)sender
{
    if (sender.tag==2) {
        if (controlView) {
            [self.view bringSubviewToFront:controlView];
            [self.view addSubview:controlView];
            [UIView animateWithDuration:0.5 animations:^{
                controlView.frame = CGRectMake(47, 130, 226, 226);
                controlView.layer.cornerRadius = 113;
            }];
        }else
        {
            [self createControlPanel];
            [UIView animateWithDuration:0.5 animations:^{
                controlView.frame = CGRectMake(47, 130, 226, 226);
                controlView.layer.cornerRadius = 113;
            }];
        }
        
    }
    
}

                                                                                            
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
