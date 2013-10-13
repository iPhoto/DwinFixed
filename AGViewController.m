//
//  AGViewController.m
//  AGImagePickerController Demo
//
//  Created by Artur Grigor on 2/16/12.
//  Copyright (c) 2012 - 2013 Artur Grigor. All rights reserved.
//

#import "AGViewController.h"



@interface AGViewController ()
{
    AGImagePickerController *ipc;
}

@end

@implementation AGViewController

#pragma mark - Properties

@synthesize selectedPhotos;

#pragma mark - Object Lifecycle


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.selectedPhotos = [NSMutableArray array];
        
        __block AGViewController *blockSelf = self;
        
        ipc = [[AGImagePickerController alloc] initWithDelegate:self];
        ipc.didFailBlock = ^(NSError *error) {
            NSLog(@"Fail. Error: %@", error);
            
            if (error == nil) {
                [blockSelf.selectedPhotos removeAllObjects];
                NSLog(@"User has cancelled.");
                
                [blockSelf dismissViewControllerAnimated:YES completion:nil];
            } else {
                
                // We need to wait for the view controller to appear first.
                double delayInSeconds = 0.5;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [blockSelf dismissViewControllerAnimated:YES completion:nil];
                });
            }

        };
        ipc.didFinishBlock = ^(NSArray *info) {
            [blockSelf.selectedPhotos setArray:info];
            
            
            
            
            NSLog(@"1234567890-Info: %@", blockSelf.selectedPhotos);
            
            
            
            
            NSURL *uri=[NSURL URLWithString:@"//asset/asset.JPG?id=69FF6F24-E989-46AC-AE95-0893B8F0D258&ext=JPG"];
            
            
            NSData * data = [NSData dataWithContentsOfURL:uri];
            [UIImage imageWithData:data];
   
            [blockSelf dismissViewControllerAnimated:YES completion:nil];
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            
            
            
        };
    }
    
    return self;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    UIButton*btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn addTarget:self action:@selector(openAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame=CGRectMake(100, 100, 100, 100);
    [self.view addSubview:btn];
    
    
    
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - Public methods

- (void)openAction:(id)sender
{
    // Show saved photos on top
    ipc.shouldShowSavedPhotosOnTop = NO;
    ipc.shouldChangeStatusBarStyle = YES;
    ipc.selection = self.selectedPhotos;
    //    ipc.maximumNumberOfPhotosToBeSelected = 1;
       [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - AGImagePickerControllerDelegate methods

- (NSUInteger)agImagePickerController:(AGImagePickerController *)picker
         numberOfItemsPerRowForDevice:(AGDeviceType)deviceType
              andInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (deviceType == AGDeviceTypeiPad)
    {
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
            return 7;
        else
            return 6;
    } else {
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
            return 5;
        else
            return 4;
    }
}

- (BOOL)agImagePickerController:(AGImagePickerController *)picker shouldDisplaySelectionInformationInSelectionMode:(AGImagePickerControllerSelectionMode)selectionMode
{
    return (selectionMode == AGImagePickerControllerSelectionModeSingle ? NO : YES);
}

- (BOOL)agImagePickerController:(AGImagePickerController *)picker shouldShowToolbarForManagingTheSelectionInSelectionMode:(AGImagePickerControllerSelectionMode)selectionMode
{
    return (selectionMode == AGImagePickerControllerSelectionModeSingle ? NO : YES);
}

- (AGImagePickerControllerSelectionBehaviorType)selectionBehaviorInSingleSelectionModeForAGImagePickerController:(AGImagePickerController *)picker
{
    return AGImagePickerControllerSelectionBehaviorTypeRadio;
}

@end
