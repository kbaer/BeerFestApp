//
//  FestDetailController.m
//  BeerFest
//
//  Created by Ken Baer on 10/15/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import "FestDetailController.h"

@interface FestDetailController ()

@end

@implementation FestDetailController

@synthesize name, dates, where, festDescription;

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

@end
