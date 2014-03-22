//
//  RadioStatus.h
//  TCPParser
//
//  Created by Adrian Chiriac on 4/19/13.
//  Copyright (c) 2013 Adrian Chiriac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Unit.h"

#define STATUS [AppStatus sharedAppStatus]

@interface AppStatus : NSObject <NSCoding>

@property int refreshInterval;

//will contain all units
@property (nonatomic, strong) NSMutableArray* allUnits;

-(id) initWithNothing;
+(id)sharedAppStatus;
-(void)saveToMemory;
-(BOOL)loadFromMemory;
+(NSString *)getPrivateDocsDir;


/* Units Accessors - needed for NSMutableArray KVO */
-(NSUInteger) countOfAllUnits;
-(id) objectInAllUnitsAtIndex:(NSUInteger)index;
-(void) insertObject:(id)object inAllUnitsAtIndex:(NSUInteger)index;
-(void) removeObjectFromAllUnitsAtIndex:(NSUInteger)index;
-(void) replaceObjectInAllUnitsAtIndex:(NSUInteger)index withObject:(id)object;

@end
