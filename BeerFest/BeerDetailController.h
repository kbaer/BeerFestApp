//
//  BeerDetailController.h
//  BeerFest
//
//  Created by Ken Baer on 9/24/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRateView.h"
#import "Beer.h"


@interface BeerDetailController : UIViewController <DYRateViewDelegate>{
   IBOutlet UILabel *brewery;
   IBOutlet UILabel *name;
   IBOutlet UILabel *style;
   IBOutlet UILabel *abv;
   IBOutlet UILabel *ibu;
   IBOutlet UITextView *descView;
   IBOutlet DYRateView *rating;
   IBOutlet UILabel *rateLabel;
   IBOutlet UISwitch *onTap;
   IBOutlet UISwitch *highlighted;
}

@property (nonatomic, retain) UILabel *brewery;
@property (nonatomic, retain) UILabel *name;
@property (nonatomic, retain) UILabel *style;
@property (nonatomic, retain) UILabel *abv;
@property (nonatomic, retain) UILabel *ibu;
@property (nonatomic, retain) UITextView *descView;
@property (nonatomic, retain) DYRateView *rating;
@property (nonatomic, retain) Beer *beer;
@property (nonatomic, retain) UILabel *rateLabel;
@property (nonatomic, retain) UISwitch *onTap;
@property (nonatomic, retain) UISwitch *highlighted;

- (void)refreshRatingLabel;
- (IBAction)toggleTap:(id)sender;
- (IBAction)toggleHighlight:(id)sender;
- (IBAction)faceBook:(id)sender;
- (IBAction)twitter:(id)sender;

@end
