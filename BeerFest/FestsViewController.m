//
//  FestsViewController.m
//  BeerFest
//
//  Created by Ken Baer on 10/15/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import "FestsViewController.h"
#import "FestDataSource.h"
#import "AppDelegate.h"


@interface FestsViewController ()

@end

@implementation FestsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
   return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // Return the number of rows in the section.
   AppDelegate *myDelegate = [AppDelegate sharedInstance];
   return [[myDelegate upcomingFests] count];
}

- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellIdentifier = @"MyFestCell";
   UITableViewCell *cell = [myTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
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

- (FestDataSource *)dataSource
{
   return (FestDataSource *)dataSource;
}

@end
