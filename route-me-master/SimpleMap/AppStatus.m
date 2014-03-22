//
//  AppStatus.m
//
//  Created by Adrian Chiriac on 4/19/13.
//  Copyright (c) 2013 Adrian Chiriac. All rights reserved.
//

#import "AppStatus.h"
#import "Unit.h"
#define fileName    @"AppStatus.ser"



@implementation AppStatus



@synthesize allUnits,refreshInterval;

-(id)init{
    
    NSAssert(NO, @"Singleton, can't be instantiated this way use sharedAppStatus method!");
    return nil;
}

-(id) initSingleton {
    //see if there is a serialized version
    return [self initWithNothing];
    
}

-(id) initWithNothing {
    self = [super init];
    
    if(self)
    {
        self.refreshInterval = 60;
        self.allUnits = [[NSMutableArray alloc] init];
    }
    return self;
}
    


-(void)saveToMemory{
   
    NSLog(@"will serialize the AppStatus");
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSString *docsDir = [AppStatus getPrivateDocsDir];
    //NSLog(@"path to save to = %@", docsDir);
    
    [data writeToFile:[docsDir stringByAppendingPathComponent:fileName] atomically:YES];
    NSLog(@"saved file at %@", [docsDir stringByAppendingPathComponent:fileName]);
}

-(BOOL)loadFromMemory{
    NSLog(@"load AppStatus from disk...");
    NSString *filePath =[[AppStatus getPrivateDocsDir] stringByAppendingPathComponent:fileName];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    NSLog(@"Does a saved file exists? %d", fileExists);
    if(fileExists){
        //NSData *data = [NSData dataWithContentsOfFile:filePath];
        //AppStatus *s = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        /*
        self.currentZone = s.currentZone;
        self.currentChannel = s.currentChannel;
        
        [self setSettings:s.settings];
         */
        //[self setMyMessages:s.myMessages];
      //  [TrboXmlParser addSomeMessages];
        NSLog(@"app status loaded...");
        return YES;
    }
    return NO;
}



+ (NSString *)getPrivateDocsDir {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    return documentsDirectory;
    
}


- (id)initWithCoder:(NSCoder *)decoder{
    /*
    Zone *z = [decoder decodeObjectForKey:@"currentZone"];
    Channel *c = [decoder decodeObjectForKey:@"currentChannel"];
    RadioSettings *s = [decoder decodeObjectForKey:@"settings"];
    */
    AppStatus *res= [self initWithNothing];
     
    //res.myMessages = [decoder decodeObjectForKey:@"myMessages"];
    
    return res;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    /*
    [encoder encodeObject:self.currentZone forKey:@"currentZone"];
    [encoder encodeObject:self.currentChannel forKey:@"currentChannel"];
    [encoder encodeObject:self.settings forKey:@"settings"];
     */
   // [encoder encodeObject:self.myMessages forKey:@"myMessages"];
}


/* Accessors for Units NSMutableArray in order for KVO to work */

-(NSUInteger) countOfAllUnits {
    return [self.allUnits count];
}

-(id) objectInAllUnitsAtIndex:(NSUInteger)index {
    return [self.allUnits objectAtIndex:index];
}

-(void) insertObject:(id)object inAllUnitsAtIndex:(NSUInteger)index {
    [self.allUnits insertObject:object atIndex:index];
}

-(void) removeObjectFromAllUnitsAtIndex:(NSUInteger)index {
    [self.allUnits removeObjectAtIndex:index];
}

-(void) replaceObjectInAllUnitsAtIndex:(NSUInteger)index withObject:(id)object {
    [self.allUnits replaceObjectAtIndex:index withObject:object];
}


// get singleton
+ (id)sharedAppStatus
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] initSingleton];
    });
    return sharedInstance;
}


@end
