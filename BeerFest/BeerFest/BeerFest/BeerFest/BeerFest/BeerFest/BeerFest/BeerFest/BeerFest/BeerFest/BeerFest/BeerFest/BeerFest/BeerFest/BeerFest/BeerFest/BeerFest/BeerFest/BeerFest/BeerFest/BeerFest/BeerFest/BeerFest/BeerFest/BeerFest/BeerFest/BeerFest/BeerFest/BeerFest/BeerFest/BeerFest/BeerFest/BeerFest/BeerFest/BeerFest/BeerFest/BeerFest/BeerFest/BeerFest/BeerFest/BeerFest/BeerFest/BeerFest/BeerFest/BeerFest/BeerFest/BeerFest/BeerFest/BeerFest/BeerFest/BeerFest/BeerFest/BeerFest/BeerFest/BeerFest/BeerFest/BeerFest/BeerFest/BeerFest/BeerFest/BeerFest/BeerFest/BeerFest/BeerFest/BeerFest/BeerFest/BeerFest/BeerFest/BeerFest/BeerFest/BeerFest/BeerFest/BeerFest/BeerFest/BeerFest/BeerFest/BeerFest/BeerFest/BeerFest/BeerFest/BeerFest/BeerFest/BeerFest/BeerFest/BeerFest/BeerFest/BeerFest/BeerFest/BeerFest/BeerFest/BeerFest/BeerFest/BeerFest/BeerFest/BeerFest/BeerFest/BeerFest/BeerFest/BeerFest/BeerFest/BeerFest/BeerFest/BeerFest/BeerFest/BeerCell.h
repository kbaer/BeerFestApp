//
//  BeerCell.h
//  BeerFest
//
//  Created by Ken Baer on 9/22/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRateView.h"


@interface BeerCell : UITableViewCell {
   IBOutlet UILabel *beer;
   IBOutlet UILabel *style;
   IBOutlet UILabel *abv;
   IBOutlet DYRateView *rating;
}

@property (nonatomic, retain) UILabel *beer;
@property (nonatomic, retain) UILabel *style;
@property (nonatomic, retain) UILabel *abv;
@property (nonatomic, retain) DYRateView *rating;

@end
