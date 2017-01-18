//
//  FestsViewController.h
//  BeerFest
//
//  Created by Ken Baer on 10/15/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kal.h"

@class FestDataSource;

@interface FestsViewController : KalViewController <UITableViewDelegate, UITableViewDataSource>

- (FestDataSource *)dataSource;

@end
