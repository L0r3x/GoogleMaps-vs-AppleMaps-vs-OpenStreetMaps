//
//  openStreetMapsViewController.m
//  BAKArbeit_Aicher_Maps
//
//  Created by Michael Aicher on 27.12.13.
//  Copyright (c) 2013 FH Technikum Wien. All rights reserved.
//

#import "openStreetMapsViewController.h"
#import "RMPath.h"

@interface openStreetMapsViewController ()

@end

@implementation openStreetMapsViewController

@synthesize openStreetMapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [RMMapView class];
    [openStreetMapView setDelegate:self];
    
    RMMapContents *contents = self.openStreetMapView.contents;
    CLLocationCoordinate2D mapCenter = [contents mapCenter];
    
    mapCenter.latitude = 66.44;
	mapCenter.longitude = -179.0;
    
    [self.view addSubview:openStreetMapView];
    
	[openStreetMapView moveToLatLong:mapCenter];

    [openStreetMapView.contents setZoom:6.0];
    
    [[openStreetMapView contents] moveBy:CGSizeMake(-5.0, 0.0)];
    
    CLLocationCoordinate2D markerPosition;
    
	markerPosition.latitude = 48.239522;
    markerPosition.longitude = 16.377269;
    
    RMMarker *fhTWMarker;
    
    [fhTWMarker changeLabelUsingText:[NSString stringWithFormat:@"%4.1f", markerPosition.longitude]];
    
    [self.openStreetMapView.contents.markerManager addMarker:fhTWMarker AtLatLong:markerPosition];
    
    openStreetMapSegment.hidden = YES;
}

//- (void)addFHTWRMMarker
//{
//	CLLocationCoordinate2D markerPosition;
//
//	markerPosition.latitude = 48.239522;
//    markerPosition.longitude = 16.377269;
//    
//    RMMarker *fhTWMarker;
//    
//    [self.openStreetMapView.contents.markerManager addMarker:fhTWMarker
//                                                 AtLatLong:markerPosition];
//    [fhTWMarker changeLabelUsingText:[NSString stringWithFormat:@"%4.1f", markerPosition.longitude]];
//}

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

- (IBAction)openStreetMapTypePressed:(UIBarButtonItem *)sender
{
    if(openStreetMapSegment.hidden == YES)
    {
        openStreetMapSegment.hidden = NO;
    }else
    {
        openStreetMapSegment.hidden = YES;
    }
}

//- (IBAction)changeOpenStreetMapType:(id)sender
//{
//    
//}
@end
