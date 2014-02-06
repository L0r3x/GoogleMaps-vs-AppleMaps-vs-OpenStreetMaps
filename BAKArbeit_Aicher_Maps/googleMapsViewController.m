//
//  mapsFirstViewController.m
//  BAKArbeit_Aicher_Maps
//
//  Created by Michael Aicher on 26.12.13.
//  Copyright (c) 2013 FH Technikum Wien. All rights reserved.
//

#import "googleMapsViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation googleMapsViewController {
    GMSMapView *mapView_;
}

- (void)viewDidLoad {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:51.5
                                                            longitude:-0.127
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    //compass is enabled
    mapView_.settings.compassButton = YES;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(51.5, -0.127);
    marker.title = @"London";
    marker.snippet = @"Great Britain";
    marker.map = mapView_;
}

/*
#pragma mark - GMSMapViewDelegate

- (void)mapView:(GMSMapView *)mapView
didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
}
*/
@end