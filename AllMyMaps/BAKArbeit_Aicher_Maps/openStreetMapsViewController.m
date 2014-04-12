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

@synthesize openStreetMapView, locationMarker;

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [RMMapView class];
    [openStreetMapView setDelegate:self];
    
    RMMapContents *contents = self.openStreetMapView.contents;
    CLLocationCoordinate2D mapCenter = [contents mapCenter];
    
    mapCenter.latitude = 48.239522;
	mapCenter.longitude = 16.377269;
    
    [self.view addSubview:openStreetMapView];
    
	[openStreetMapView moveToLatLong:mapCenter];

    [openStreetMapView.contents setZoom:6.0];
    
    [[openStreetMapView contents] moveBy:CGSizeMake(-5.0, 0.0)];
    
    CLLocationCoordinate2D markerPosition;
	markerPosition.latitude = 48.239522;
    markerPosition.longitude = 16.377269;
    
    UIImage *iconImage = [UIImage imageNamed:@"mapMarker"];
    locationMarker = [[RMMarker alloc] initWithUIImage: iconImage];
    [openStreetMapView.contents.markerManager addMarker:locationMarker AtLatLong: markerPosition];

//for offline Maps
//    openStreetMapView.contents.minZoom = 15.f;
//    openStreetMapView.contents.maxZoom = 17.f;
//    openStreetMapView.contents.zoom = 16.5;
//    NSURL *tileSetURL = [[NSBundle mainBundle] URLForResource:@"offlineMap.mbtiles" withExtension:@"mbtiles"];
//    openStreetMapView.contents.tileSource = [[RMMBTilesTileSource alloc] initWithTileSetURL: tileSetURL];
    
}

@end
