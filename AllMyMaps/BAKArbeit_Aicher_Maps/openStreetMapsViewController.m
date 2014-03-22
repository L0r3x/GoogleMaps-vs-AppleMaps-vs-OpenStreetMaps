//
//  openStreetMapsViewController.m
//  BAKArbeit_Aicher_Maps
//
//  Created by Michael Aicher on 27.12.13.
//  Copyright (c) 2013 FH Technikum Wien. All rights reserved.
//

#import "openStreetMapsViewController.h"

@interface openStreetMapsViewController ()

@end

@implementation openStreetMapsViewController

@synthesize openStreetMapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [RMMapView class];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
