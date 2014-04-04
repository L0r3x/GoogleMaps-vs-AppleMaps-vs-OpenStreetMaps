//
//  appleMapsViewController.m
//  BAKArbeit_Aicher_Maps
//
//  Created by Michael Aicher on 26.12.13.
//  Copyright (c) 2013 FH Technikum Wien. All rights reserved.
//

#import "appleMapsViewController.h"

@interface appleMapsViewController ()

@property (nonatomic) BOOL fhTWAnnotationIsSet;

@end

@implementation appleMapsViewController

@synthesize appleMapView, toolBar, address, streetName, subtitleInfos;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.appleMapView setDelegate:self];
    
    self.fhTWAnnotationIsSet = NO;
    
    [self addFHTWAnnotation];
//    [self addUserAnnotation];
    
    //Touch me and I will recognize you *hrhr*
    [self addGestureRecognizerToAppleMapView];
    
    // I dont want to see you!
    appleSegment.hidden = YES;
}

-(void) addFHTWAnnotation
{
    self.fhTWAnnotationIsSet = YES;
    CLLocationCoordinate2D fHTWCoord;
    fHTWCoord.longitude = 16.377269;
    fHTWCoord.latitude = 48.239522;
    
    MKPointAnnotation *fHTW = [[MKPointAnnotation alloc] init];
    fHTW.coordinate = fHTWCoord;
    fHTW.title = @"FH Technikum Wien";
    fHTW.subtitle = @"Höchstädtplatz 6";

    [self.appleMapView addAnnotation:fHTW];
}

#warning funktioniert ned!!!

//-(void) addUserAnnotation
//{
//    
//    MKPointAnnotation *userAnnotation = [[MKPointAnnotation alloc] init];
//    userAnnotation.coordinate = self.appleMapView.userLocation.location.coordinate;
//    //Reverse Geocoding Part
//    CLLocation *tempLocation = [[CLLocation alloc] initWithLatitude:userAnnotation.coordinate.latitude longitude:userAnnotation.coordinate.longitude];
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    [geocoder reverseGeocodeLocation:tempLocation completionHandler:
//     ^(NSArray* placemarks, NSError* error){
//         if ([placemarks count] > 0)
//         {
//             CLPlacemark *placemark = [placemarks objectAtIndex:0];
//             NSLog(@" %@",placemark.addressDictionary);
//             
//             streetName = [placemark.addressDictionary objectForKey:@"Street"];
//             subtitleInfos = [placemark.addressDictionary objectForKey:@"City"];
//             
//             NSString *helperForSubtitleInfos = [NSString stringWithFormat:@"%@, %@ %@", streetName, [placemark.addressDictionary objectForKey:@"ZIP"], subtitleInfos];
//             
//             userAnnotation.title = @"You are currently at: ";
//             userAnnotation.subtitle = helperForSubtitleInfos;
//             
//             [self.appleMapView addAnnotation:userAnnotation];
//         }
//     }];
//}

-(void) addGestureRecognizerToAppleMapView
{
    UILongPressGestureRecognizer *longTouchRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(addPinToAppleMap:)];
    longTouchRecognizer.minimumPressDuration = 0.5;
    [self.appleMapView addGestureRecognizer:longTouchRecognizer];
}

-(void) addPinToAppleMap:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.appleMapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.appleMapView convertPoint:touchPoint toCoordinateFromView:self.appleMapView];
    
    MKPointAnnotation *toAdd = [[MKPointAnnotation alloc] init];
    toAdd.coordinate = touchMapCoordinate;
    
    //Reverse Geocoding Part
    CLLocation *tempLocation = [[CLLocation alloc] initWithLatitude:toAdd.coordinate.latitude longitude:toAdd.coordinate.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:tempLocation completionHandler:
     ^(NSArray* placemarks, NSError* error){
         if ([placemarks count] > 0)
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSLog(@" %@",placemark.addressDictionary);
             
             streetName = [placemark.addressDictionary objectForKey:@"Street"];
             subtitleInfos = [placemark.addressDictionary objectForKey:@"City"];

             NSString *helperForSubtitleInfos = [NSString stringWithFormat:@"%@ %@", [placemark.addressDictionary objectForKey:@"ZIP"], subtitleInfos];
             
             toAdd.title = streetName;
             toAdd.subtitle = helperForSubtitleInfos;

             self.fhTWAnnotationIsSet = NO;
             [self.appleMapView addAnnotation:toAdd];
         }
     }];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *identifier = @"myAnnotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.appleMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView)
    {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        if((self.fhTWAnnotationIsSet == YES) && ([[annotation title] isEqualToString:@"FH Technikum Wien"]))
        {
            annotationView.animatesDrop = NO;
            annotationView.draggable = NO;
            annotationView.pinColor = MKPinAnnotationColorRed;
            self.fhTWAnnotationIsSet = NO;
        }
        else
        {
            annotationView.pinColor = MKPinAnnotationColorGreen;
            annotationView.animatesDrop = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"hugo"];
            annotationView.draggable = YES;
            self.fhTWAnnotationIsSet = NO;
        }
    }
    else
    {
        self.fhTWAnnotationIsSet = NO;
        annotationView.annotation = annotation;
    }
    self.fhTWAnnotationIsSet = NO;
    return annotationView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.appleMapView setCenterCoordinate:self.appleMapView.userLocation.location.coordinate animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// UIToolbarButtons
- (IBAction)deleteAllAnnotations:(id)sender
{
    id userAnnotation = self.appleMapView.userLocation;
    
    NSMutableArray *annotations = [NSMutableArray arrayWithArray:self.appleMapView.annotations];
    [annotations removeObject:userAnnotation];
    
    [self.appleMapView removeAnnotations:annotations];
    [self addFHTWAnnotation];
}

- (IBAction)zoomToMyPosition:(id)sender
{
    MKUserLocation *userLocation = appleMapView.userLocation;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 300, 300);
    
    [appleMapView setRegion:region animated:YES];
}

- (IBAction)appleMapTypePressed:(UIBarButtonItem *)sender
{
    if(appleSegment.hidden == YES)
    {
        appleSegment.hidden = NO;
    }else
        appleSegment.hidden = YES;
}

- (IBAction)changeAppleMapType:(id)sender
{
    if (appleSegment.selectedSegmentIndex == 0)
    {
        appleMapView.mapType = MKMapTypeStandard;
        appleSegment.hidden = YES;
    }
    if (appleSegment.selectedSegmentIndex == 1)
    {
        appleMapView.mapType = MKMapTypeHybrid;
        appleSegment.hidden = YES;
    }
    if (appleSegment.selectedSegmentIndex == 2)
    {
        appleMapView.mapType = MKMapTypeSatellite;
        appleSegment.hidden = YES;
    }
}

@end
