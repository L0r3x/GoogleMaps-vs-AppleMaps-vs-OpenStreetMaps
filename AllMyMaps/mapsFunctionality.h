//
//  mapsFunctionality.h
//  BAKArbeit_Aicher_Maps
//
//  Created by FYAYC on 19.03.14.
//  Copyright (c) 2014 FH Technikum Wien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "appleMapsViewController.h"

@interface mapsFunctionality : NSObject

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *streetName;
@property (strong, nonatomic) NSString *subtitleInfos;

@end
