//
//  openStreetMapsViewController.h
//  BAKArbeit_Aicher_Maps
//
//  Created by Michael Aicher on 27.12.13.
//  Copyright (c) 2013 FH Technikum Wien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "RMMapView.h"
#import "RMMarkerManager.h"
#import "RMMarker.h"
#import "RMMBTilesTileSource.h"

@interface openStreetMapsViewController : UIViewController <RMMapViewDelegate>
{
    IBOutlet RMMapView *openStreetMapView;
}

@property (strong, nonatomic) IBOutlet RMMapView *openStreetMapView;

@property (nonatomic, retain) RMMarker *locationMarker;

@end