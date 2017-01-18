//
//  BeerCell.m
//  BeerFest
//
//  Created by Ken Baer on 9/22/12.
//  Copyright (c) 2012 Ken Baer. All rights reserved.
//

#import "BeerCell.h"

@implementation BeerCell

@synthesize beer, abv, style, rating;

- (id)initWithStyle:(UITableViewCellStyle)myStyle reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:myStyle reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
