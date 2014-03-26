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

//-(void) addFhTWRMMarker
//{
//    CLLocationCoordinate2D fHTWCoord;
//    fHTWCoord.longitude = 16.377269;
//    fHTWCoord.latitude = 48.239522;
//    
//    RMMarker *fHTW = [[MKPointAnnotation alloc] init];
//    fHTW.coordinate = fHTWCoord;
//    fHTW.title = @"FH Technikum Wien";
//    fHTW.subtitle = @"Höchstädtplatz 6";
//    
//    [self.appleMapView addAnnotation:fHTW];
//}

@end
