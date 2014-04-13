//
//  openStreetMapsViewController.h
//  BAKArbeit_Aicher_Maps
//
//  Created by Michael Aicher on 27.12.13.
//  Copyright (c) 2013 FH Technikum Wien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
//for the map
#import "RMMapView.h"
//For markers
#import "RMMarkerManager.h"
#import "RMMarker.h"
//for Map Types
#import "RMDBMapSource.h"
#import "RMMBTilesTileSource.h"
#import "RMOpenCycleMapSource.h"
#import "RMOpenStreetMapSource.h"

@interface openStreetMapsViewController : UIViewController <RMMapViewDelegate>
{
    IBOutlet RMMapView *openStreetMapView;
    IBOutlet UISegmentedControl *openStreetSegment;
}

- (IBAction)zoomToUserLocation:(id)sender;

- (IBAction)openStreetMapTypePressed:(UIBarButtonItem *)sender;
- (IBAction)changeOpenStreetMapType:(id)sender;

@property (strong, nonatomic) IBOutlet RMMapView *openStreetMapView;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *currentUserLocation;
@property (nonatomic, retain) RMMarkerManager *markerManager;
@property (nonatomic, retain) RMMarker *currentUserLocationMarker;

@property (nonatomic, retain) RMMarker *locationMarker;

@end