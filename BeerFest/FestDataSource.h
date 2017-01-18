//
//  FestDataSource.h
//  BeerFest
//
//  Created by Ken Baer on 10/15/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Kal.h"
#import "Fest.h"

@interface FestDataSource : NSObject <KalDataSource> {
   AppDelegate *delegate;
   NSMutableArray *items;
   NSMutableArray *fests;
   NSMutableData *buffer;
   id<KalDataSourceCallbacks> callback;
   BOOL dataReady;
}

+ (FestDataSource *)dataSource;
- (Fest *)festAtIndexPath:(NSIndexPath *)indexPath;  // exposed for AppDelegate so that it can implement the UITableViewDelegate protocol.
- (void)processFestList;
- (NSArray *)festsFrom:(NSDate *)fromDate to:(NSDate *)toDate;
- (NSMutableArray *)items;

@end
