//
//  Unit.m
//  SimpleMap
//
//  Created by Adrian Chiriac on 6/9/13.
//
//

#import "Unit.h"

@implementation Unit : NSObject 

-(id) init {
    return [self initWithRadioID:0 andName:@"" andType:0 andLat:0 andLng:0];
}

-(id) initWithRadioID:(int)radioID andName:(NSString *)name andType:(int)type andLat:(long)lat andLng:(long)lng {
    self = [super init];
    
    if(self)
    {
        self.radioID = radioID;
        self.name = name;
        self.type = type;
        self.latitude = lat;
        self.longitude = lng;
    }
    return self;
}

@end
