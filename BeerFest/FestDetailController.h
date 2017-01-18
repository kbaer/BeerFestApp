//
//  FestDetailController.h
//  BeerFest
//
//  Created by Ken Baer on 10/15/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FestDetailController : UIViewController
{
   IBOutlet UILabel *name;
   IBOutlet UILabel *dates;
   IBOutlet UILabel *where;
   IBOutlet UITextView *festDescription;
   IBOutlet UIButton *twitterFeedButton;
}

@property (nonatomic, retain) UILabel *name;
@property (nonatomic, retain) UILabel *dates;
@property (nonatomic, retain) UILabel *where;
@property (nonatomic, retain) UITextView *festDescription;

@end
