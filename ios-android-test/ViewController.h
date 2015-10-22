//
//  ViewController.h
//  ios-android-test
//
//  Created by Arulpandiyan on 22/10/15.
//  Copyright (c) 2015 sybrant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBFiles.h"
@interface ViewController : UIViewController {
    DBFiles *oDBFiles;
    UIRefreshControl *refreshControl;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UITableView *TblFootBall;
@property(nonatomic,retain) NSMutableArray *ArrayHomeTeam,*ArrayAwayTeam,*ArrayHomeTeamGoal,*ArrayAwayTeamGoal,*ArrayStatus,*ArrayDate,*ArrayDBInsert;
@property(nonatomic,retain) NSString *StringHomeTeamName,*StringAwayTeamName,*StringStatus,*StringHomeTeamGoal,*StringAwayTeamGoal,*StringDate;

-(void)APIReceivedFootBallData:(NSMutableData *)data;


@end

