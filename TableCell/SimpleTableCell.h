//
//  SimpleTableCell.h
//  SimpleTable
//
//  Created by Arulpandiyan on 22/10/15.
//  Copyright (c) 2015 sybrant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell

/// List of Bookings Page
@property (nonatomic, weak) IBOutlet UILabel *LblHomeTeamName,*LblAwayTeamName,*LblStatus,*LblHomeGoal,*LblAwayGoal,*LblDate;

@end
