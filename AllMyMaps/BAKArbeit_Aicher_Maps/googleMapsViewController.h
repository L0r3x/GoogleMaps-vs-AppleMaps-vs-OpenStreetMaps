//
//  googleMapsViewController.h
//  BAKArbeit_Aicher_Maps
//
//  Created by Michael Aicher on 26.12.13.
//  Copyright (c) 2013 FH Technikum Wien. All rights reserved.
//

#import "googleMapsView.h"
#import "GoogleMaps.h"
#import <UIKit/UIKit.h>

@interface googleMapsViewController : UIViewController <GMSMapViewDelegate>
{
    IBOutlet GMSMapView *googleMapsView;
    IBOutlet UISegmentedControl *googleSegment;
}

@property (strong, nonatomic) NSString *streetName;
@property (strong, nonatomic) NSString *snippetInfos;

@property (strong, nonatomic) IBOutlet GMSMapView *googleMapsView;

- (IBAction)googleMapTypePressed:(UIBarButtonItem *)sender;
- (IBAction)changeGoogleMapType:(id)sender;

- (IBAction)deleteAllMarkers:(id)sender;

@end
