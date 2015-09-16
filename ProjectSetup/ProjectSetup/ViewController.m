//
//  ViewController.m
//  ProjectSetup
//
//  Created by JKCS-Shyamal on 9/16/15.
//  Copyright (c) 2015 JKCS. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"

@interface ViewController (){
   
}

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[LocationHandler getSharedInstance]setDelegate:self];
    [[LocationHandler getSharedInstance]startUpdating];
}

-(void)didUpdateToLocation:(CLLocation *)newLocation
              fromLocation:(CLLocation *)oldLocation{
    
    NSLog( @"Latitude: %f",newLocation.coordinate.latitude);
    NSLog( @"Latitude: %f",newLocation.coordinate.longitude);
    [[LocationHandler getSharedInstance] stopUpdating];
}



-(void)viewDidAppear:(BOOL)animated{
    
    if ([[UtilitiFunc sharedInstance] isInternetAvailable]) {
        [SVProgressHUD show];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // time-consuming task
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[LibraryAPI sharedInstance] userLogin:@"ranjana" password:@"11222" withBlock:^(NSArray* results){
                    NSLog(@"hoooooooooo");
                    [SVProgressHUD dismiss];
                }];
            });
        });
    }else{
        UIAlertView *rechableAlert = [[UIAlertView alloc] initWithTitle:@"App"
                                                                message:@"No internet connection"
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                      otherButtonTitles: nil];
        
        [rechableAlert show];
    }
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
