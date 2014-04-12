//
//  forwardGeocodingViewController.m
//  MapView
//
//  Created by FYAYC on 12.04.14.
//
//

#import "forwardGeocodingViewController.h"

@interface forwardGeocodingViewController ()

@end

@implementation forwardGeocodingViewController

@synthesize street, city, zip, state, coords;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)showMap
{
    NSDictionary *address = @{(NSString *)kABPersonAddressStreetKey: street.text,
                              (NSString *)kABPersonAddressCityKey: city.text,
                              (NSString *)kABPersonAddressZIPKey: zip.text,
                              (NSString *)kABPersonAddressStateKey: state.text
                              };
    
    MKPlacemark *place = [[MKPlacemark alloc] initWithCoordinate:coords addressDictionary:address];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:place];
    
    NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving};
    
    [mapItem openInMapsWithLaunchOptions:options];
}

- (IBAction)textFieldDone:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)showOnMap:(id)sender
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    NSString *completeAddress = [NSString stringWithFormat:@"%@ %@ %@ %@", street.text, city.text, zip.text, state.text];
    
    [geocoder geocodeAddressString:completeAddress completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(error)
         {
             NSLog(@"Forward Geocoding failed with error: %@", error);
         }
         
         if (placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark = placemarks[0];
             
             CLLocation *location = placemark.location;
             coords = location.coordinate;
             
             [self showMap];
         }
     }];
}
@end
