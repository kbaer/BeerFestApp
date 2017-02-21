//
//  AppDelegate.m
//  BeerFest
//
//  Created by Ken Baer on 9/19/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import "AppDelegate.h"
#import "Beer.h"


@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize upcomingFests;

id sharedInstance;

+ (void)initialize{
   
   NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
   // unset defaults are empty strings
   NSDictionary *appDefaults = [NSDictionary
                                dictionaryWithObjectsAndKeys:@"NO", @"initialized", nil];
   
   [myDefaults registerDefaults:appDefaults];
}

+ (id)sharedInstance {
   return sharedInstance;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

   sharedInstance = self;

   [self processBeerList];  // load hardcoded beer list
   
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
   // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
   // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
   // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
   // Saves changes in the application's managed object context before the application terminates.
   [self saveContext];
}

- (void)saveContext
{
   NSError *error = nil;
   NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
   if (managedObjectContext != nil) {
      if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
         NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      }
   }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
   if (_managedObjectContext != nil) {
      return _managedObjectContext;
   }
   
   NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
   if (coordinator != nil) {
      _managedObjectContext = [[NSManagedObjectContext alloc] init];
      [_managedObjectContext setPersistentStoreCoordinator:coordinator];
   }
   return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
   if (_managedObjectModel != nil) {
      return _managedObjectModel;
   }
   NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BeerFestData" withExtension:@"momd"];
   _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
   return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
   if (_persistentStoreCoordinator != nil) {
      return _persistentStoreCoordinator;
   }
   
   NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BeerFest.sqlite"];
   
   NSError *error = nil;
   _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
   if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
      /*
       Replace this implementation with code to handle the error appropriately.
       
       abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
       
       Typical reasons for an error here include:
       * The persistent store is not accessible;
       * The schema for the persistent store is incompatible with current managed object model.
       Check the error message to determine what the actual problem was.
       
       
       If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
       
       If you encounter schema incompatibility errors during development, you can reduce their frequency by:
       * Simply deleting the existing store:
       [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
       
       * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
       @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
       
       Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
       
       */
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
   }
   
   return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
   return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)processBeerList
{
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   
   // add beer list only once
   if (![[defaults stringForKey:@"initialized"] isEqualToString:@"NO"])
      return;

   NSString* path = [[NSBundle mainBundle] pathForResource:@"HRHopsFest" ofType:@"csv"];
   NSString* beersFile = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];

   if (beersFile) {
      NSArray *beersList = [beersFile componentsSeparatedByString:@"\r\n"];
      NSString *beer;
      NSArray *beerInfo;
      BOOL    first = YES;
      
      for (beer in beersList) {
         if (first) { // skip the first entry, which has the column labels
            first = NO;
            continue;
         }
         beerInfo = [beer componentsSeparatedByString:@","];
         
         Beer *newBeer = (Beer *)[NSEntityDescription insertNewObjectForEntityForName:@"Beer" inManagedObjectContext:[self managedObjectContext]];
         [newBeer setBrewerName:[beerInfo objectAtIndex:0]];
         [newBeer setName:[beerInfo objectAtIndex:1]];
         [newBeer setStyle:[beerInfo objectAtIndex:2]];
         [newBeer setAbv:[[beerInfo objectAtIndex:3] floatValue]];
         [newBeer setIbu:([beerInfo objectAtIndex:4])?[[beerInfo objectAtIndex:4] intValue]:0];
         NSString *desc = [beerInfo objectAtIndex:5];
         if ([beerInfo count] > 6) {
            int i;
            for (i = 6; i < [beerInfo count]; i++)
               desc = [desc stringByAppendingString:[beerInfo objectAtIndex:i]];
         }
         [newBeer setDesc:desc];
         [newBeer setRating: 0]; // starts with no rating
         [newBeer setOnTap:YES];
         [newBeer setHighlighted:NO];
      }
      [self saveContext];
      [defaults setBool:YES forKey:@"initialized"];
   }
}

@end
