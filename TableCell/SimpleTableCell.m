//
//  SimpleTableCell.m
//  SimpleTable
//
//  Created by Arulpandiyan on 22/10/15.
//  Copyright (c) 2015 sybrant. All rights reserved.
//

#import "SimpleTableCell.h"

@implementation SimpleTableCell
@synthesize LblAwayGoal,LblAwayTeamName,LblDate,LblHomeGoal,LblHomeTeamName,LblStatus;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
