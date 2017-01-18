//
//  Beer.h
//  BeerFest
//
//  Created by Ken Baer on 9/20/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Beer : NSManagedObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *rbID;
@property (nonatomic, strong) NSString *style;
@property (nonatomic)         float     abv;
@property (nonatomic)         int16_t   ibu;
@property (nonatomic, strong) NSString *brewerName;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic)         int16_t   rating;
@property (nonatomic)         float     groupRating;
@property (nonatomic)         BOOL      onTap;
@property (nonatomic)         BOOL      highlighted;
@property (nonatomic, retain) NSManagedObject *fests;

@end
