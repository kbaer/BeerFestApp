//
//  Fest.h
//  BeerFest
//
//  Created by Ken Baer on 9/20/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Beer;

@interface Fest : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * country;
@property (nonatomic)         double     latitude;
@property (nonatomic)         double     longitude;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * festDescription;
@property (nonatomic, retain) Beer *beers;

@end
