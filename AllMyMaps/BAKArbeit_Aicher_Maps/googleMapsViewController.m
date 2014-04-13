//
//  googleMapsViewController.m
//  BAKArbeit_Aicher_Maps
//
//  Created by Michael Aicher on 26.12.13.
//  Copyright (c) 2013 FH Technikum Wien. All rights reserved.
//

#import "googleMapsViewController.h"

@interface googleMapsViewController()
@end

@implementation googleMapsViewController
    BOOL firstLocationUpdate;

@synthesize googleMapsView, snippetInfos, streetName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Is only for GoogleMaps to initialize the camera, in real the camera zooms immediatly to the users location
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                            longitude:151.2086
                                                                 zoom:12];
    self.googleMapsView.camera = camera;
    
    self.googleMapsView.accessibilityElementsHidden = YES;
    
    //My Location Button enable
    self.googleMapsView.settings.myLocationButton = YES;
    
    //compass is enabled
    self.googleMapsView.settings.compassButton = YES;
    
    //floor picker is enabled
    self.googleMapsView.settings.indoorPicker = YES;
    
    // Enables Traffic Data
    googleMapsView.trafficEnabled = YES;
    
    //Creates a marker in the center of the map.
    [self addFHTWMarker];
    
    //hide googleSegment
    googleSegment.hidden = YES;
    
    // Listen to the myLocation property of GMSMapView.
    [self.googleMapsView addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        self.googleMapsView.myLocationEnabled = YES;
    });
    
    self.googleMapsView.delegate = self;
}

- (void)dealloc {
    [self.googleMapsView removeObserver:self
                  forKeyPath:@"myLocation"
                     context:NULL];
}

#pragma mark - set camera to user location

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate) {
        // If the first location update has not yet been recieved, then jump to that location.
        firstLocationUpdate = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        self.googleMapsView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];
    }
}

-(void) addFHTWMarker
{
    //Marker FH Gebäude alt
    CLLocationCoordinate2D fHTWCoord = CLLocationCoordinate2DMake(48.239480, 16.377915);
    GMSMarker *fHTW = [[GMSMarker alloc] init];
    fHTW.icon = [GMSMarker markerImageWithColor:[UIColor blackColor]];
    fHTW.position = fHTWCoord;
    fHTW.title = @"FH Technikum Wien A-Gebäude";
    fHTW.snippet = @"Höchstädtplatz 6";
    fHTW.map = self.googleMapsView;
    
    //Marker FH Gebäude neu
    CLLocationCoordinate2D fhTWCoordNew = CLLocationCoordinate2DMake(48.239344, 16.377177);
    GMSMarker *fhTWNew = [[GMSMarker alloc] init];
    fhTWNew.position = fhTWCoordNew;
    fhTWNew.icon = [UIImage imageNamed:@"mapMarker"];
    fhTWNew.title = @"FH Technikum Wien F-Gebäude";
    fhTWNew.snippet = @"Höchstädtplatz 6";
    fhTWNew.map = self.googleMapsView;
}

-(void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    mapView = self.googleMapsView;

    //Reverse Geocoding Part
    GMSGeocoder *geocoder = [[GMSGeocoder alloc] init];
    
    id handler = ^(GMSReverseGeocodeResponse *response, NSError *error) {
        if (error == nil) {
            GMSReverseGeocodeResult *result = response.firstResult;
            GMSMarker *addMarker = [GMSMarker markerWithPosition:coordinate];
            addMarker.title = result.addressLine1;
            addMarker.snippet = result.addressLine2;
            addMarker.draggable = YES;
            addMarker.appearAnimation = kGMSMarkerAnimationPop;
            addMarker.map = mapView;
        }
    };
    [geocoder reverseGeocodeCoordinate:coordinate completionHandler:handler];
}

- (IBAction)googleMapTypePressed:(UIBarButtonItem *)sender
{
    if(googleSegment.hidden == YES)
    {
        googleSegment.hidden = NO;
    }else
    {
        googleSegment.hidden = YES;
    }
}

- (IBAction)changeGoogleMapType:(id)sender
{
    if (googleSegment.selectedSegmentIndex == 0)
    {
        self.googleMapsView.mapType = kGMSTypeNormal;
        googleSegment.hidden = YES;
    }
    if (googleSegment.selectedSegmentIndex == 1)
    {
        self.googleMapsView.mapType = kGMSTypeHybrid;
        googleSegment.hidden = YES;
    }
    if (googleSegment.selectedSegmentIndex == 2)
    {
        self.googleMapsView.mapType = kGMSTypeSatellite;
        googleSegment.hidden = YES;
    }
    if (googleSegment.selectedSegmentIndex == 3)
    {
        self.googleMapsView.mapType = kGMSTypeTerrain;
        googleSegment.hidden = YES;
    }
}

- (IBAction)toogleTrafficSwitch:(UISwitch *)sender
{
    if([sender isOn])
    {
        // Enables Traffic Data
        googleMapsView.trafficEnabled = YES;
    }
    else
    {
        googleMapsView.trafficEnabled = NO;
    }
}

- (IBAction)deleteAllMarkers:(id)sender
{
    [self.googleMapsView clear];
    [self addFHTWMarker];
}

@end