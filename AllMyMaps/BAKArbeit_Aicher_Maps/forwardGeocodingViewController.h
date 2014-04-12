//
//  forwardGeocodingViewController.h
//  MapView
//
//  Created by FYAYC on 12.04.14.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>

@interface forwardGeocodingViewController : UIViewController

@property CLLocationCoordinate2D coords;

@property (strong, nonatomic) IBOutlet UITextField *street;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *zip;
@property (strong, nonatomic) IBOutlet UITextField *state;

- (IBAction)textFieldDone:(id)sender;
- (IBAction)showOnMap:(id)sender;

@end
