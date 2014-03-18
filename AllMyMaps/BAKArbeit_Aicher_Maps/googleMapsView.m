//
//  googleMapsView.m
//  BAKArbeit_Aicher_Maps
//
//  Created by FYAYC on 08.02.14.
//  Copyright (c) 2014 FH Technikum Wien. All rights reserved.
//

#import "googleMapsView.h"
#import "googleMapsViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation googleMapsView{
    GMSMapView *mapView_;
}
//try it later...
/*
- (void)viewDidLoad
{
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:51.5
                                                            longitude:-0.127
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.view = mapView_;
    
    //Found out my current position
    mapView_.myLocationEnabled = YES;
    NSLog((@"User's Location: %@", mapView_.myLocation));
    
    //My Location Button enable
    mapView_.settings.myLocationButton = YES;
    
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
