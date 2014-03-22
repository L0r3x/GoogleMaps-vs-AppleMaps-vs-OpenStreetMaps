//
//  mapsSecondViewController.h
//  BAKArbeit_Aicher_Maps
//
//  Created by Michael Aicher on 26.12.13.
//  Copyright (c) 2013 FH Technikum Wien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface appleMapsViewController : UIViewController <UIApplicationDelegate, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>
{
    CLGeocoder *locationManager;
    IBOutlet MKMapView *appleMapView;
    UIToolbar *toolBar;
    IBOutlet UISegmentedControl *appleSegment;
}

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *streetName;
@property (strong, nonatomic) NSString *subtitleInfos;

@property (strong, nonatomic) IBOutlet MKMapView *appleMapView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;

- (IBAction)deleteAllAnnotations:(id)sender;

- (IBAction)zoomToMyPosition:(id)sender;

- (IBAction)appleMapTypePressed:(UIBarButtonItem *)sender;
- (IBAction)changeAppleMapType:(id)sender;

@end
