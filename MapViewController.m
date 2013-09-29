//
//  MapOverlayViewController.m
//  XQTest
//
//  Created by xf.lai on 13-7-18.
//  Copyright (c) 2013年 xf.lai. All rights reserved.
//

#import "MapViewController.h"
#import "DetailsView.h"
#import "PinAnnotation.h"
#import "PinAnnotationView.h"
#import "DetailsAnnotation.h"
#import "DetailsAnnotationView.h"
#import "MKMapView+MapViewUtil.h"

#define  spaceFNum  0.003
#define  oriZoomLevel 12.
#define oriSpan   MKCoordinateSpanMake(0.00494, 0.00538)
#define oriCenterCoordinate  CLLocationCoordinate2DMake(30.658273, 104.067864)

@interface MapViewController ()
{
    PinAnnotation       *_pinAnnotation;
    DetailsAnnotation   *_detailsAnnotation;
    NSMutableArray      *_detailsAnnoArray;
}
@end

@implementation MapViewController
@synthesize mapView = _mapView;
@synthesize segmentController = _segmentController;

-(void)dealloc
{
    _mapView.delegate = nil;
    _segmentController = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//ios 6.0 -
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}
//ios 6.0 +
- (BOOL)shouldAutorotate
{
    return NO;
}

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
        NSMutableArray *ary = [NSMutableArray array];
        
        int childCount = j;
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
    
    newLocCoordinate = oriCenterCoordinate;
    
    _detailsAnnoArray = [[NSMutableArray alloc]init];

    _mapView.showsUserLocation = YES;//定位
    _mapView.scrollEnabled = YES;
    _mapView.zoomEnabled = YES;
    _mapView.delegate = self;
    
   
    
    [self.segmentController addTarget:self
                               action:@selector(segmentValueChanged)
               forControlEvents:UIControlEventValueChanged];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidUnload {
    [self setMapView:nil];
     [super viewDidUnload];
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
        detailsAnno.tag = self.segmentController.selectedSegmentIndex;
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
        PinAnnotationView *annotationView =(PinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PinAnnotationView"];
        if (!annotationView) {
            
            annotationView = [[PinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PinAnnotationView"];
        }
        annotationView.tag = num;
        return annotationView;
        
    }
	return nil;
}

@end
