//
//  FestDataSource.m
//  BeerFest
//
//  Created by Ken Baer on 10/15/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import "FestDataSource.h"
#import "Fest.h"


static BOOL IsDateBetweenInclusive(NSDate *date, NSDate *begin, NSDate *end)
{
   return [date compare:begin] != NSOrderedAscending && [date compare:end] != NSOrderedDescending;
}

@implementation FestDataSource

+ (FestDataSource *)dataSource
{
   return [[[self class] alloc] init];
}

- (id)init
{
   if ((self = [super init])) {
      items = [[NSMutableArray alloc] init];
      fests = [[NSMutableArray alloc] init];
      buffer = [[NSMutableData alloc] init];
   }
   [self processFestList];  // load hardcoded festival list
   return self;
}

- (Fest *)festAtIndexPath:(NSIndexPath *)indexPath
{
   return [items objectAtIndex:indexPath.row];
}

#pragma mark KalDataSource protocol conformance

- (void)presentingDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate delegate:(id<KalDataSourceCallbacks>)myDelegate
{
   /*
    * In this example, I load the entire dataset in one HTTP request, so the date range that is
    * being presented is irrelevant. So all I need to do is make sure that the data is loaded
    * the first time and that I always issue the callback to complete the asynchronous request
    * (even in the trivial case where we are responding synchronously).
    */
   
   if (dataReady) {
      [callback loadedDataSource:self];
      return;
   }
   
   callback = myDelegate;
}

- (NSArray *)markedDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
   if (!dataReady)
      return [NSArray array];
   
   return [[self festsFrom:fromDate to:toDate] valueForKeyPath:@"date"];
}

- (void)loadItemsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
   if (!dataReady)
      return;
   
   [items addObjectsFromArray:[self festsFrom:fromDate to:toDate]];
}

- (void)removeAllItems
{
   [items removeAllObjects];
}

#pragma mark -

- (void)processFestList
{
   NSString *path = [[NSBundle mainBundle] pathForResource:@"UpcomingFests" ofType:@"json"];
   NSData *festData = [NSData dataWithContentsOfFile:path];
   NSError *error = nil;
   delegate = [AppDelegate sharedInstance];
   NSDictionary *data = [NSJSONSerialization JSONObjectWithData:festData options:NSJSONReadingMutableContainers error:&error];
   items = [data objectForKey:@"festivals"];
   [delegate setUpcomingFests:items];
}

- (NSArray *)festsFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
   NSMutableArray *matches = [NSMutableArray array];
   for (Fest *fest in [delegate upcomingFests])
      if (IsDateBetweenInclusive(fest.startDate, fromDate, toDate))
         [matches addObject:fest];
   
   return matches;
}

- (NSMutableArray *)items
{
   return items;
}

@end
