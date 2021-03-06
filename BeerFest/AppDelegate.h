//
//  AppDelegate.h
//  BeerFest
//
//  Created by Ken Baer on 9/19/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@class Fest;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSMutableArray *upcomingFests;

+ (id)sharedInstance;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)processBeerList;

@end
