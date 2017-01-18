//
//  MyFestsController.m
//  BeerFest
//
//  Created by Ken Baer on 10/16/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import "MyFestsController.h"
#import "FestsViewController.h"
#import "FestDataSource.h"


@interface MyFestsController ()

@end

@implementation MyFestsController

@synthesize dataSource;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   dataSource = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	// Display the brewer's names as section headings.
   switch (section) {
      case 0:
         return @"My Ongoing and Upcoming Fests";
      case 1:
         return @"My Past Fests";
   }
   return @"";
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 58;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyFestCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Actions

- (void)showFestCalendar
{
   date = (NSDate *)[NSDate date];
   FestsViewController *vc = [[FestsViewController alloc] initWithSelectedDate:date];
   if (!dataSource) {
      FestDataSource *festDataSource = [[FestDataSource alloc] init];
      [self setDataSource:festDataSource];
   }
   [vc setDelegate:vc];
   vc.navigationItem.title = @"Fest Calendar";
   [self.navigationController pushViewController:vc animated:YES];
}

@end
