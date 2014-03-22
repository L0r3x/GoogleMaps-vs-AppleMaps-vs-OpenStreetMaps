//
//  mapsFunctionality.m
//  BAKArbeit_Aicher_Maps
//
//  Created by FYAYC on 19.03.14.
//  Copyright (c) 2014 FH Technikum Wien. All rights reserved.
//

#import "mapsFunctionality.h"

@implementation mapsFunctionality

-(void) addFHTWAnnotation
{
    CLLocationCoordinate2D fHTWCoord;
    fHTWCoord.longitude = 16.377269;
    fHTWCoord.latitude = 48.239522;
    
    MKPointAnnotation *fHTW = [[MKPointAnnotation alloc] init];
    fHTW.coordinate = fHTWCoord;
    fHTW.title = @"FH Technikum Wien";
    fHTW.subtitle = @"Höchstädtplatz 6";
    
    [self.appleMapView addAnnotation:fHTW];
}

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
             
             [self.appleMapView addAnnotation:toAdd];
         }
     }];
}

@end
