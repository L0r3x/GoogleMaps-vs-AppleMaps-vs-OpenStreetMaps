//
//  MapViewViewController.m
//
// Copyright (c) 2008, Route-Me Contributors
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
//   list of conditions and the following disclaimer.
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

#import "MapViewViewController.h"

#import "RMMapContents.h"
#import "RMFoundation.h"
#import "RMMarker.h"
#import "RMMarkerManager.h"
#import "AppStatus.h"
#import "Unit.h"

@implementation MapViewViewController

@synthesize mapView;
/*
// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
}
*/

- (void)testMarkers
{
	RMMarkerManager *markerManager = [mapView markerManager];
	NSArray *markers = [markerManager markers];
	
	NSLog(@"Nb markers %d", [markers count]);
	
	NSEnumerator *markerEnumerator = [markers objectEnumerator];
	RMMarker *aMarker;
	
	while (aMarker = (RMMarker *)[markerEnumerator nextObject])
		
	{
		RMProjectedPoint point = [aMarker projectedLocation];
		NSLog(@"Marker projected location: east:%lf, north:%lf", point.easting, point.northing);
		CGPoint screenPoint = [markerManager screenCoordinatesForMarker: aMarker];
		NSLog(@"Marker screen location: X:%lf, Y:%lf", screenPoint.x, screenPoint.y);
		CLLocationCoordinate2D coordinates =  [markerManager latitudeLongitudeForMarker: aMarker];
		NSLog(@"Marker Lat/Lon location: Lat:%lf, Lon:%lf", coordinates.latitude, coordinates.longitude);
		
		[markerManager removeMarker:aMarker];
	}
	
	// Put the marker back
	RMMarker *marker = [[RMMarker alloc]initWithUIImage:[UIImage imageNamed:@"marker-blue.png"]
											anchorPoint:CGPointMake(0.5, 1.0)];
    
    // Put the marker back
	RMMarker *marker2 = [[RMMarker alloc]initWithUIImage:[UIImage imageNamed:@"marker-blue.png"]
											anchorPoint:CGPointMake(0.5, 1.0)];
    
    [marker2 changeLabelUsingText:@"Unit101"];
    
    [markerManager addMarker:marker2 AtLatLong:CLLocationCoordinate2DMake(44.418854, 26.09647)];

    //[marker changeLabelUsingText:@"Hello"];
	
	
   // [markerManager addMarker:marker AtLatLong:[[mapView contents] mapCenter]];
    
    
    
   	
	[marker release];
	markers  = [markerManager markersWithinScreenBounds];
	
    
    
	NSLog(@"Nb Markers in Screen: %d", [markers count]);
	
	//	[mapView getScreenCoordinateBounds];
	
	[markerManager hideAllMarkers];
	[markerManager unhideAllMarkers];
	

}

- (BOOL)mapView:(RMMapView *)map shouldDragMarker:(RMMarker *)marker withEvent:(UIEvent *)event
{
   //If you do not implement this function, then all drags on markers will be sent to the didDragMarker function.
   //If you always return YES you will get the same result
   //If you always return NO you will never get a call to the didDragMarker function
   return YES;
}

- (void)mapView:(RMMapView *)map didDragMarker:(RMMarker *)marker withEvent:(UIEvent *)event 
{
   CGPoint position = [[[event allTouches] anyObject] locationInView:mapView];
   
	RMMarkerManager *markerManager = [mapView markerManager];

	NSLog(@"New location: east:%lf north:%lf", [marker projectedLocation].easting, [marker projectedLocation].northing);
	CGRect rect = [marker bounds];
	
	[markerManager moveMarker:marker AtXY:CGPointMake(position.x,position.y +rect.size.height/3)];

}

- (void) singleTapOnMap: (RMMapView*) map At: (CGPoint) point
{
	NSLog(@"Clicked on Map - New location: X:%lf Y:%lf", point.x, point.y);
}

- (void) tapOnMarker: (RMMarker*) marker onMap: (RMMapView*) map
{
	NSLog(@"MARKER TAPPED!");
	RMMarkerManager *markerManager = [mapView markerManager];
	if(!tap)
	{
		[marker replaceUIImage:[UIImage imageNamed:@"marker-red.png"]];
		[marker changeLabelUsingText:@"World"];
		tap=YES;
		[markerManager moveMarker:marker AtXY:CGPointMake([marker position].x,[marker position].y + 20.0)];
		[mapView setDeceleration:YES];
	}else
	{
			[marker replaceUIImage:[UIImage imageNamed:@"marker-blue.png"]
					   anchorPoint:CGPointMake(0.5, 1.0)];
		[marker changeLabelUsingText:@"Hello"];
		[markerManager moveMarker:marker AtXY:CGPointMake([marker position].x,[marker position].y - 20.0)];
		tap=NO;
		[mapView setDeceleration:NO];
	}

}

- (void) tapOnLabelForMarker:(RMMarker*) marker onMap:(RMMapView*) map
{
	NSLog(@"Label <0x%x, RC:%U> tapped for marker <0x%x, RC:%U>",  marker.label, [marker.label retainCount], marker, [marker retainCount]);
	[marker changeLabelUsingText:[NSString stringWithFormat:@"Tapped! (%U)", ++tapCount]];
}


/* #######################################
   ###            OBSERVERS           ####
   #######################################*/
- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
    
    NSLog(@"observer for key = %@", keyPath);
    
    //this is not happening when loading from memory, don't know why  :-(
    if ([keyPath isEqualToString:@"allUnits"]) {
        NSLog(@"Something has changed in units list");
    }
}


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
	NSLog(@"%@ viewDidLoad", self);
    [super viewDidLoad];
    Unit* unit = [[Unit alloc] initWithRadioID:101 andName:@"Unit101" andType:1 andLat:44.418765 andLng:26.09687];
    [STATUS insertObject:unit inAllUnitsAtIndex:0];
    
    unit = [[Unit alloc] initWithRadioID:102 andName:@"Unit102" andType:1 andLat:44.418845 andLng:26.09435];
    [STATUS insertObject:unit inAllUnitsAtIndex:0];
    
    // add observer for Units Status
    [STATUS addObserver:self forKeyPath:@"allUnits" options:NSKeyValueObservingOptionNew context:NULL];
    
    unit = [[Unit alloc] initWithRadioID:103 andName:@"Demo103" andType:2 andLat:44.418487 andLng:26.09845];
    [STATUS insertObject:unit inAllUnitsAtIndex:0];
    
	tap=NO;
	RMMarkerManager *markerManager = [mapView markerManager];
	[mapView setDelegate:self];
	
	CLLocationCoordinate2D coolPlace;
	//coolPlace.latitude = -33.9464;
	//coolPlace.longitude = 151.2381;
    coolPlace.latitude = 44.418854;
	coolPlace.longitude = 26.09647;
	
	RMMarker *marker = [[RMMarker alloc]initWithUIImage:[UIImage imageNamed:@"marker-blue.png"]
											anchorPoint:CGPointMake(0.5, 1.0)];
	[marker setTextForegroundColor:[UIColor blueColor]];
	[marker changeLabelUsingText:@"Hello"];
    
    
    // Put the marker back
	RMMarker *marker2 = [[RMMarker alloc]initWithUIImage:[UIImage imageNamed:@"marker-blue.png"]
                                             anchorPoint:CGPointMake(0.5, 1.0)];
    
    [marker2 changeLabelUsingText:@"Unit101"];
    
    [markerManager addMarker:marker2 AtLatLong:CLLocationCoordinate2DMake(44.418854, 26.09647)];
    
    
	//[markerManager addMarker:marker AtLatLong:[[mapView contents] mapCenter]];
	[marker release];
    
    //CLLocationCoordinate2D coolPlace;
	

    //
    MapViewViewController * controller = [[MapViewViewController alloc] init];
    [controller.mapView moveToLatLong:coolPlace];
    
    
    
    
    
	//NSLog(@"Center: Lat: %lf Lon: %lf", mapView.contents.mapCenter.latitude, mapView.contents.mapCenter.longitude);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
}

- (void)dealloc {
	[mapView release];
    [super dealloc];
}

@end
