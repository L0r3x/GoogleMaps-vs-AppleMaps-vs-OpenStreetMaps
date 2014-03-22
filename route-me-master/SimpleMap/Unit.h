//
//  Unit.h
//  SimpleMap
//
//  Created by Adrian Chiriac on 6/9/13.
//
//

#import <Foundation/Foundation.h>

@interface Unit : NSObject


@property int radioID;
@property long latitude;
@property long longitude;
@property (nonatomic, retain) NSString *name;
@property int type;


- (id)init;

- (id) initWithRadioID:(int) radioID andName:(NSString*) name andType:(int) type andLat:(long) lat andLng:(long) lng;
@end
