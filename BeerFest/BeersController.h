//
//  BeersController.h
//  BeerFest
//
//  Created by Ken Baer on 9/19/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class BeerDetailController;

@interface BeersController : UIViewController<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate> {

   NSFetchedResultsController *fetchedResultsController;
   NSFetchedResultsController *ABVResultsController;
   NSFetchedResultsController *styleResultsController;
   NSFetchedResultsController *ratingResultsController;
   IBOutlet BeerDetailController *beerDetailController;
	NSMutableArray                *sectionsArray;
	UILocalizedIndexedCollation   *collation;
	NSMutableArray                *filteredListContent;
   IBOutlet UITableView          *tableView;
   IBOutlet UISegmentedControl   *sortTypeButton;
   
}

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSFetchedResultsController *ABVResultsController;
@property (nonatomic, strong) NSFetchedResultsController *styleResultsController;
@property (nonatomic, strong) NSFetchedResultsController *ratingResultsController;
@property (nonatomic, strong) NSMutableArray                *sectionsArray;
@property (nonatomic, strong) UILocalizedIndexedCollation   *collation;
@property (nonatomic, strong) NSMutableArray                *filteredListContent;
@property (nonatomic, strong) UITableView                   *tableView;
@property (nonatomic, strong) UISegmentedControl            *sortTypeButton;

- (void)onSortChanged:(id)sender;

@end
