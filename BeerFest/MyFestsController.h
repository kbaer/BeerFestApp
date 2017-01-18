//
//  MyFestsController.h
//  BeerFest
//
//  Created by Ken Baer on 10/16/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FestDataSource;

@interface MyFestsController : UITableViewController
{
   NSDate *date;
}

@property (nonatomic, strong) FestDataSource *dataSource;

- (IBAction)showFestCalendar;

@end
