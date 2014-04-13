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

@synthesize openStreetMapView, locationMarker, currentUserLocation, currentUserLocationMarker, markerManager, locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [RMMapView class];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    currentUserLocation = nil;
    
    openStreetSegment.hidden = YES;
    
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
    [locationMarker setTextForegroundColor:[UIColor blueColor]];
    [locationMarker setTextBackgroundColor:[UIColor darkGrayColor]];
    [locationMarker changeLabelUsingText:@"FH Technikum Wien"];
    [openStreetMapView.contents.markerManager addMarker:locationMarker AtLatLong: markerPosition];
    
    //just for the beginning
    CLLocationCoordinate2D currentUserLocationPosition;
    currentUserLocationPosition.latitude = 48.21111;
    currentUserLocationPosition.longitude = 16.378;
    currentUserLocationMarker = [[RMMarker alloc] initWithUIImage:[UIImage imageNamed:@"userMarker"]];
    [openStreetMapView.contents.markerManager addMarker:currentUserLocationMarker AtLatLong:currentUserLocationPosition];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self.openStreetMapView moveToLatLong:newLocation.coordinate];
    currentUserLocation = newLocation;
    RMLatLong newCoords = {newLocation.coordinate.latitude, newLocation.coordinate.longitude};
    [openStreetMapView.contents.markerManager moveMarker:currentUserLocationMarker AtLatLon:newCoords];
}

- (IBAction)zoomToUserLocation:(id)sender
{
    CLLocationCoordinate2D currentUserLocationPosition;
    currentUserLocationPosition.latitude = currentUserLocation.coordinate.latitude;
    currentUserLocationPosition.longitude = currentUserLocation.coordinate.longitude;
    
    [openStreetMapView moveToLatLong:currentUserLocationPosition];
    
    [openStreetMapView.contents setZoom:16.0];
    
    [[openStreetMapView contents] moveBy:CGSizeMake(-5.0, 0.0)];
}

- (IBAction)openStreetMapTypePressed:(UIBarButtonItem *)sender
{
    if(openStreetSegment.hidden == YES)
    {
        openStreetSegment.hidden = NO;
    }else
    {
        openStreetSegment.hidden = YES;
    }
}

//is working with no functionality!
- (IBAction)changeOpenStreetMapType:(id)sender
{
//    id <RMTileSource> tileSource;

	if(openStreetSegment.selectedSegmentIndex == 0)
    {
//        tileSource = [[RMOpenStreetMapSource] init];
//        [[openStreetMapView contents] setTileSource:tileSource];
        openStreetSegment.hidden = YES;
    }
    if(openStreetSegment.selectedSegmentIndex == 1)
    {
//        tileSource = [[RMOpenCycleMapSource] init];
//        [[openStreetMapView contents] setTileSource:tileSource];
        openStreetSegment.hidden = YES;
    }
#warning if you're using offline Map you will not see any map and have to restart the app-> it's not working and i don't know why-.-
    if(openStreetSegment.selectedSegmentIndex == 2)
    {
//        RMDBMapSource *offlineMap = [[RMDBMapSource alloc] initWithPath:@"Philadelphia.mbtiles"];
//        [openStreetMapView setConstraintsSW:CLLocationCoordinate2DMake(offlineMap.bottomRightOfCoverage.latitude, offlineMap.topLeftOfCoverage.longitude) NE:CLLocationCoordinate2DMake(offlineMap.topLeftOfCoverage.latitude, offlineMap.bottomRightOfCoverage.longitude)];
//        [openStreetMapView moveToLatLong:offlineMap.centerOfCoverage];
        openStreetMapView.contents.minZoom = 15.f;
        openStreetMapView.contents.maxZoom = 17.f;
        openStreetMapView.contents.zoom = 16.5;
        
        NSURL *tileSetUrl = [[NSBundle mainBundle] URLForResource:@"Philadelphia.mbtiles" withExtension:@"mbtiles"];
        openStreetMapView.contents.tileSource = [[RMMBTilesTileSource alloc] initWithTileSetURL:tileSetUrl];
        [openStreetMapView.contents moveToLatLong:CLLocationCoordinate2DMake(39.949721, -75.150261)];
        openStreetSegment.hidden = YES;
    }
}
@end
