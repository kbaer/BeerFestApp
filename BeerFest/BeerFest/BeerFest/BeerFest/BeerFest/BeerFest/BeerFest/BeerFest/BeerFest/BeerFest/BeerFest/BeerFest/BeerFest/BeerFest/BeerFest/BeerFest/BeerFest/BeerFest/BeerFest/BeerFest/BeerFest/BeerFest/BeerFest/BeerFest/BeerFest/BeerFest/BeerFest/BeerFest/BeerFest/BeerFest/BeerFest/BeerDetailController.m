//
//  BeerDetailController.m
//  BeerFest
//
//  Created by Ken Baer on 9/24/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import "BeerDetailController.h"
#import "AppDelegate.h"
#import "Social/Social.h"
#import "Accounts/Accounts.h"


@interface BeerDetailController ()

@end

@implementation BeerDetailController

@synthesize brewery, name, abv, style, descView, rating, beer, rateLabel, onTap, highlighted;

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
   UIImage *starFullImage = [UIImage imageNamed:@"StarFullLarge.png"]; //[UIImage imageNamed:starFullFile];
   UIImage *starEmptyImage = [UIImage imageNamed:@"StarEmptyLarge.png"]; //[UIImage imageNamed:starEmptyFile];
   [rating setFullStarImage:starFullImage];
   [rating setEmptyStarImage:starEmptyImage];
   rating.padding = 20;
   rating.alignment = RateViewAlignmentCenter;
   rating.editable = YES;
   rating.delegate = self;
   [self.view addSubview:rating];
}

- (void)viewWillAppear:(BOOL)animated {
   [super viewWillAppear:animated];
   [brewery setText:beer.brewerName];
   [name setText:beer.name];
   [style setText:beer.style];
   [abv setText:[NSString stringWithFormat:@"%0.1f%%", beer.abv]];
   [descView setText:beer.desc];
   [onTap setOn:beer.onTap];
   [rating setRate:beer.rating];
   [highlighted setOn:beer.highlighted];
   [self refreshRatingLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshRatingLabel {
   NSString *rateString;
   switch (beer.rating) {
      case 0:
         rateString = @"No Rating";
         break;
      case 1:
         rateString = @"Hated it!";
         break;
      case 2:
         rateString = @"Meh";
         break;
      case 3:
         rateString = @"OK";
         break;
      case 4:
         rateString = @"Good";
         break;
      case 5:
         rateString = @"Awesome!";
         break;
   }
   self.rateLabel.text = rateString;
}

#pragma mark - Actions

- (void)toggleTap:(id)sender {
   beer.onTap = onTap.on;
   [[AppDelegate sharedInstance] saveContext]; // update database
}

- (void)toggleHighlight:(id)sender {
   beer.highlighted = highlighted.on;
   [[AppDelegate sharedInstance] saveContext]; // update database
}

- (IBAction)faceBook:(id)sender {
   
   if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
      
      SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
      
      SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
         if (result == SLComposeViewControllerResultCancelled) {
            
            NSLog(@"Cancelled");
            
         } else
            
         {
            NSLog(@"Done");
         }
         
         [controller dismissViewControllerAnimated:YES completion:Nil];
      };
      controller.completionHandler = myBlock;
      
      NSString *message = [NSString stringWithFormat:@"I enjoyed %@ %@ at Hood River Hops Fest 2012. Posted with BeerFest app for iOS.", [brewery text], [name text]];
      [controller setInitialText:message];
      //      [controller addURL:[NSURL URLWithString:@"http://www.mobile.safilsunny.com"]];
      //      [controller addImage:[UIImage imageNamed:@"fb.png"]];
      
      [self presentViewController:controller animated:YES completion:Nil];
      
   }
   else{
      NSLog(@"UnAvailable");
   }
   
}

- (IBAction)twitter:(id)sender {
   
   if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
      
      SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
      
      SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
         if (result == SLComposeViewControllerResultCancelled) {
            
            NSLog(@"Cancelled");
            
         } else
            
         {
            NSLog(@"Done");
         }
         
         [controller dismissViewControllerAnimated:YES completion:Nil];
      };
      controller.completionHandler = myBlock;
      
      NSString *message = [NSString stringWithFormat:@"I enjoyed %@ %@ at Hood River Hops Fest 2012. #beerfestapp", [brewery text], [name text]];
      [controller setInitialText:message];
      //      [controller addURL:[NSURL URLWithString:@"http://www.mobile.safilsunny.com"]];
      //      [controller addImage:[UIImage imageNamed:@"fb.png"]];
      
      [self presentViewController:controller animated:YES completion:Nil];
      
   }
   else{
      NSLog(@"UnAvailable");
   }
   
}

#pragma mark - DYRateViewDelegate

- (void)rateView:(DYRateView *)rateView changedToNewRate:(NSNumber *)rate {
   beer.rating = [rate intValue];
   [self refreshRatingLabel];
   [[AppDelegate sharedInstance] saveContext]; // update database
}

@end
