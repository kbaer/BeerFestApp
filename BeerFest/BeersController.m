//
//  FirstViewController.m
//  BeerFest
//
//  Created by Ken Baer on 9/19/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import "BeersController.h"
#import "Beer.h"
#import "BeerCell.h"
#import "BeerDetailController.h"
#import "CustomCellBackground.h"


@interface BeersController ()

@end

@implementation BeersController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize ABVResultsController = _ABVResultsController;
@synthesize styleResultsController = _styleResultsController;
@synthesize ratingResultsController = _ratingResultsController;
@synthesize sectionsArray, collation, filteredListContent, tableView, sortTypeButton;

- (void)viewDidLoad
{
    [super viewDidLoad];

	NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Handle the error.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
	if (![[self ratingResultsController] performFetch:&error]) {
		// Handle the error.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
	if (![[self ABVResultsController] performFetch:&error]) {
		// Handle the error.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
	if (![[self styleResultsController] performFetch:&error]) {
		// Handle the error.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
   
   [sortTypeButton addTarget:self
                        action:@selector(onSortChanged:)
              forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear {
	[self.tableView reloadData];
}

- (void)viewDidUnload {
	// Release any properties that are loaded in viewDidLoad or can be recreated lazily.
	self.fetchedResultsController = nil;
   self.ratingResultsController = nil;
   self.ABVResultsController = nil;
   self.styleResultsController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table view data source methods

/*
 The data source methods are handled primarily by the fetch results controller
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   switch ([sortTypeButton selectedSegmentIndex]) {
      case 0:
         return [[_fetchedResultsController sections] count];
         break;
      default: // only one section for all sort types except for Brewery
         return 1;
         break;
   }
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
   id <NSFetchedResultsSectionInfo> sectionInfo;
   switch ([sortTypeButton selectedSegmentIndex]) {
      case 0:
         sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
         return [sectionInfo numberOfObjects];
      case 1:
         sectionInfo = [[_ratingResultsController sections] objectAtIndex:0];
         return [sectionInfo numberOfObjects];
      case 2:
         sectionInfo = [[_ABVResultsController sections] objectAtIndex:0];
         return [sectionInfo numberOfObjects];
      case 3:
         sectionInfo = [[_styleResultsController sections] objectAtIndex:0];
         return [sectionInfo numberOfObjects];
   }
   return 0;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 54;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
   static NSString *CellIdentifier = @"BeerCell";
   
   BeerCell *cell = [myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
   if (cell == nil) {
      cell = [[BeerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
   }
   
   if (cell.backgroundView == nil)
      cell.backgroundView = [[CustomCellBackground alloc] init];
   if (cell.selectedBackgroundView)
      cell.selectedBackgroundView = [[CustomSelectedCellBackground alloc] init];

   // Configure the cell to show the book's title
	Beer *beer;
   switch ([sortTypeButton selectedSegmentIndex]) {
      case 0:
         beer = [_fetchedResultsController objectAtIndexPath:indexPath];
         [cell.beer setText:beer.name];
         [cell.beer setFont:[UIFont systemFontOfSize:18]];
         break;
      case 1:
         beer = [_ratingResultsController objectAtIndexPath:indexPath];
         [cell.beer setText:[NSString stringWithFormat:@"%@ %@", beer.brewerName, beer.name]];
         [cell.beer setFont:[UIFont systemFontOfSize:16]];
         break;
      case 2:
         beer = [_ABVResultsController objectAtIndexPath:indexPath];
         [cell.beer setText:[NSString stringWithFormat:@"%@ %@", beer.brewerName, beer.name]];
         [cell.beer setFont:[UIFont systemFontOfSize:16]];
         break;
      case 3:
         beer = [_styleResultsController objectAtIndexPath:indexPath];
         [cell.beer setText:[NSString stringWithFormat:@"%@ %@", beer.brewerName, beer.name]];
         [cell.beer setFont:[UIFont systemFontOfSize:16]];
         break;
   }
   
   [cell.beer setTextColor:(beer.onTap?[UIColor blackColor]:[UIColor redColor])];
   [cell.abv setText:[NSString stringWithFormat:@"%0.1f%%", beer.abv]];
   [cell.style setText:beer.style];
   [cell.rating setRate:beer.rating];
   [cell.rating setAlignment:RateViewAlignmentLeft];
   if (beer.highlighted)
      [cell.beer setBackgroundColor:[UIColor yellowColor]];
   else
      [cell.beer setBackgroundColor:[UIColor clearColor]];
 	
   return cell;
}

// Section-related methods: Retrieve the section titles and section index titles from the collation.

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	// Display the brewer's names as section headings.
   switch ([sortTypeButton selectedSegmentIndex]) {
      case 0:
         return [[[_fetchedResultsController sections] objectAtIndex:section] name];
      default:
         return nil;
   }
}

/*
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)myTableView {
   return [collation sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)myTableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
   return [collation sectionForSectionIndexTitleAtIndex:index];
}

- (void)configureSections {
	
	// Get the current collation and keep a reference to it.
	self.collation = [UILocalizedIndexedCollation currentCollation];
	
	NSInteger index, sectionTitlesCount = [[collation sectionTitles] count];
	
	NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
	
	// Set up the sections array: elements are mutable arrays that will contain the pubs for that section.
	for (index = 0; index < sectionTitlesCount; index++) {
		NSMutableArray *array = [[NSMutableArray alloc] init];
		[newSectionsArray addObject:array];
	}
	
	// Segregate the pubs into the appropriate arrays.
   id brewery;
	for (brewery in [_fetchedResultsController sections]) {
		
		NSInteger sectionNumber = [collation sectionForObject:brewery collationStringSelector:@selector(name)];
		
		// Get the array for the section.
		NSMutableArray *beers = [newSectionsArray objectAtIndex:sectionNumber];
		
//		[breweries addObject:breweryName];
	}
	
	// Now that all the data's in place, each section array needs to be sorted.
	for (index = 0; index < sectionTitlesCount; index++) {
		
		NSMutableArray *beersArrayForSection = [newSectionsArray objectAtIndex:index];
		
		// If the table view or its contents were editable, you would make a mutable copy here.
		NSArray *sortedBeersArrayForSection = [collation sortedArrayFromArray:beersArrayForSection collationStringSelector:@selector(name)];
		
		// Replace the existing array with the sorted array.
		[newSectionsArray replaceObjectAtIndex:index withObject:sortedBeersArrayForSection];
	}
	
	self.sectionsArray = newSectionsArray;
}
*/

- (void)tableView:(UITableView *)myTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}


#pragma mark -
#pragma mark Selection and moving

- (void)tableView:(UITableView *)myTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   [self performSegueWithIdentifier:@"BeerDetail" sender:nil];
 }

// Do some customization of our new view when a table item has been selected
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   // Make sure we're referring to the correct segue
   if ([[segue identifier] isEqualToString:@"BeerDetail"]) {
      
      // Get reference to the destination view controller
      BeerDetailController *vc = [segue destinationViewController];
      
      // get the selected index
      NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
      [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
      Beer *selectedBeer;
      switch ([sortTypeButton selectedSegmentIndex]) {
         case 0:
            selectedBeer = (Beer *)[[self fetchedResultsController] objectAtIndexPath:indexPath];
            break;
         case 1:
            selectedBeer = (Beer *)[[self ratingResultsController] objectAtIndexPath:indexPath];
            break;
         case 2:
            selectedBeer = (Beer *)[[self ABVResultsController] objectAtIndexPath:indexPath];
            break;
         case 3:
            selectedBeer = (Beer *)[[self styleResultsController] objectAtIndexPath:indexPath];
            break;
      }
      vc.beer = selectedBeer;
      vc.navigationItem.title = @"Beer Detail";
   }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
   // The table view should not be re-orderable.
   return NO;
}

#pragma mark -
#pragma mark Fetched results controller

/**
 Returns the fetched results controller. Creates and configures the controller if necessary.
 */
- (NSFetchedResultsController *)fetchedResultsController {
   
   if (_fetchedResultsController != nil) {
      return _fetchedResultsController;
   }
   
   AppDelegate *delegate = [AppDelegate sharedInstance];
   
	// Create and configure a fetch request with the Beer entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Beer" inManagedObjectContext:delegate.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Create the sort descriptors array.
	NSSortDescriptor *breweryDescriptor = [[NSSortDescriptor alloc] initWithKey:@"brewerName" ascending:YES];
	NSSortDescriptor *beerDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = @[breweryDescriptor, beerDescriptor];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Create and initialize the fetch results controller.
	NSFetchedResultsController *aFetchedResultsController = (NSFetchedResultsController *)[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:@"brewerName" cacheName:@"Breweries"];
	self.fetchedResultsController = aFetchedResultsController;
	_fetchedResultsController.delegate = self;
		
	return _fetchedResultsController;
}

- (NSFetchedResultsController *)ABVResultsController {
   
   if (_ABVResultsController != nil) {
      return _ABVResultsController;
   }
   
   AppDelegate *delegate = [AppDelegate sharedInstance];
   
	// Create and configure a fetch request with the Beer entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Beer" inManagedObjectContext:delegate.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Create the sort descriptors array.
	NSSortDescriptor *abvDescriptor = [[NSSortDescriptor alloc] initWithKey:@"abv" ascending:YES];
	NSArray *sortDescriptors = @[abvDescriptor];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Create and initialize the fetch results controller.
	NSFetchedResultsController *aFetchedResultsController = (NSFetchedResultsController *)[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:@"ABVs"];
	self.ABVResultsController = aFetchedResultsController;
	_ABVResultsController.delegate = self;
   
	return _ABVResultsController;
}

- (NSFetchedResultsController *)styleResultsController {
   
   if (_styleResultsController != nil) {
      return _styleResultsController;
   }
   
   AppDelegate *delegate = [AppDelegate sharedInstance];
   
	// Create and configure a fetch request with the Beer entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Beer" inManagedObjectContext:delegate.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Create the sort descriptors array.
	NSSortDescriptor *styleDescriptor = [[NSSortDescriptor alloc] initWithKey:@"style" ascending:YES];
	NSArray *sortDescriptors = @[styleDescriptor];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Create and initialize the fetch results controller.
	NSFetchedResultsController *aFetchedResultsController = (NSFetchedResultsController *)[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:@"Styles"];
	self.styleResultsController = aFetchedResultsController;
	_styleResultsController.delegate = self;
   
	return _styleResultsController;
}

- (NSFetchedResultsController *)ratingResultsController {
   
   if (_ratingResultsController != nil) {
      return _ratingResultsController;
   }
   
   AppDelegate *delegate = [AppDelegate sharedInstance];
   
	// Create and configure a fetch request with the Beer entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Beer" inManagedObjectContext:delegate.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Create the sort descriptors array.
	NSSortDescriptor *styleDescriptor = [[NSSortDescriptor alloc] initWithKey:@"rating" ascending:NO];
	NSArray *sortDescriptors = @[styleDescriptor];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Create and initialize the fetch results controller.
	NSFetchedResultsController *aFetchedResultsController = (NSFetchedResultsController *)[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:@"Ratings"];
	self.ratingResultsController = aFetchedResultsController;
	_ratingResultsController.delegate = self;
   
	return _ratingResultsController;
}

- (void)onSortChanged:(id)sender {
   [tableView reloadData];
}

/**
 Delegate method of NSFethcedResultsController to respond to additions, removals and so on.
 */
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	// Reload the table view, provided that the controller is not in editing state.
	if (!self.editing) {
		[self.tableView reloadData];
	}
}

@end
