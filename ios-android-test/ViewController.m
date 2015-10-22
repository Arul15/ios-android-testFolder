//
//  ViewController.m
//  ios-android-test
//
//  Created by Arulpandiyan on 22/10/15.
//  Copyright (c) 2015 sybrant. All rights reserved.
//

#import "ViewController.h"
#import "RestAPICall.h"
#import "URLConnection.h"
#import "SimpleTableCell.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize ArrayAwayTeam,ArrayAwayTeamGoal,ArrayDate,ArrayHomeTeam,ArrayHomeTeamGoal,ArrayStatus,ArrayDBInsert;
@synthesize StringHomeTeamName,StringAwayTeamName,StringStatus,StringHomeTeamGoal,StringAwayTeamGoal,StringDate;

- (void)viewDidLoad {
    [super viewDidLoad];

    //Array Initialization
    ArrayAwayTeam = [[NSMutableArray alloc]init];
    ArrayAwayTeamGoal = [[NSMutableArray alloc]init];
    ArrayDate = [[NSMutableArray alloc]init];
    ArrayHomeTeam = [[NSMutableArray alloc]init];
    ArrayHomeTeamGoal = [[NSMutableArray alloc]init];
    ArrayStatus = [[NSMutableArray alloc]init];
    ArrayDBInsert = [[NSMutableArray alloc]init];
    
    oDBFiles = [[DBFiles alloc] init];
    NSMutableArray *Array = [oDBFiles fnGetDetails];
    NSLog(@"Array %lu",(unsigned long)[Array count]);
    if ([Array count] == 0) {
        /// API Call Initialization
        [self RestAPICall];

    } else {
    // Check Before the Local database, If there dont call REST API
    for (int i = 0; i < [Array count]; i++) {
        oDBFiles = [Array objectAtIndex:i];
        [ArrayHomeTeam addObject:oDBFiles.StringHomeTeamName];
        [ArrayAwayTeam addObject:oDBFiles.StringAwayTeamName];
        [ArrayHomeTeamGoal addObject:oDBFiles.StringHomeTeamGoal];
        [ArrayAwayTeamGoal addObject:oDBFiles.StringAwayTeamGoal];
        [ArrayStatus addObject:oDBFiles.StringStatus];
        [ArrayDate addObject:oDBFiles.StringDate];
        [self.spinner stopAnimating];
        [self.TblFootBall reloadData];
    }

    }

    // Set Center of the view
    [self.spinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    
    //Add Refresh to Table View
    refreshControl = [[UIRefreshControl alloc]init];
    [self.TblFootBall addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

/// Show the updated data
- (void)refreshTable {
    [self RestAPICall];
    [refreshControl endRefreshing];
    [self.TblFootBall reloadData];
}

-(void)RestAPICall{
    [self.spinner startAnimating];
    NSString *pStrUrl = [NSString stringWithFormat:@"http://api.football-data.org/alpha/soccerseasons/398/fixtures"];
    NSMutableURLRequest *theRequest=[RestAPICall  FootBalldata:pStrUrl];
    NSString *request=[NSString stringWithFormat:@"%@", theRequest];
    if ([request isEqualToString:@""]) {
    }else {
        URLConnection *connection=[[URLConnection alloc] initWithMethodNameRequest:theRequest delegate:self identifier:@"FootBallData"];
        NSLog(@"connection is %@",connection);
    }
}


// API Received Data
-(void)APIReceivedFootBallData:(NSMutableData *)data {
    // stop animation
    [self.spinner stopAnimating];
    
    /// Check the db and delete rows
    oDBFiles = [[DBFiles alloc] init];
    [oDBFiles fnDelete];
    
    NSError *myError = nil;
    NSMutableArray *ArrayFootball = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError] objectForKey:@"fixtures"];
    for (int i =0; i < [ArrayFootball count]; i++) {
        NSMutableDictionary *DictionaryTeamdata = [ArrayFootball objectAtIndex:i];
        StringHomeTeamName = [DictionaryTeamdata objectForKey:@"homeTeamName"];
        StringAwayTeamName = [DictionaryTeamdata objectForKey:@"awayTeamName"];
        StringDate = [DictionaryTeamdata objectForKey:@"date"];
        StringStatus = [DictionaryTeamdata objectForKey:@"status"];
        StringAwayTeamGoal = [[DictionaryTeamdata objectForKey:@"result"] objectForKey:@"goalsAwayTeam"];
        StringHomeTeamGoal = [[DictionaryTeamdata objectForKey:@"result"] objectForKey:@"goalsHomeTeam"];
        
        [ArrayAwayTeam addObject:StringAwayTeamName];
        [ArrayHomeTeam addObject:StringHomeTeamName];
        [ArrayDate addObject:StringDate];
        [ArrayStatus addObject:StringStatus];
        [ArrayHomeTeamGoal addObject:StringHomeTeamGoal];
        [ArrayAwayTeamGoal addObject:StringAwayTeamGoal];
        
        
        
        /// Insert Data into local Database
        [ArrayDBInsert insertObject:StringHomeTeamName atIndex:0];
        [ArrayDBInsert insertObject:StringAwayTeamName atIndex:1];
        [ArrayDBInsert insertObject:StringStatus atIndex:2];
        [ArrayDBInsert insertObject:StringHomeTeamGoal atIndex:3];
        [ArrayDBInsert insertObject:StringAwayTeamGoal atIndex:4];
        [ArrayDBInsert insertObject:StringDate atIndex:5];
        [oDBFiles fnInsertData:ArrayDBInsert];

    }

    [self.TblFootBall reloadData];

}

//Table Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ArrayAwayTeam count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *simpleTableIdentifier = @"CellFootBallData";
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.LblHomeTeamName.text = [ArrayHomeTeam objectAtIndex:indexPath.row];
    cell.LblAwayTeamName.text = [ArrayAwayTeam objectAtIndex:indexPath.row];
    cell.LblStatus.text = [ArrayStatus objectAtIndex:indexPath.row];
    cell.LblDate.text = [ArrayDate objectAtIndex:indexPath.row];
    cell.LblHomeGoal.text = [NSString stringWithFormat:@"%@",[ArrayHomeTeamGoal objectAtIndex:indexPath.row]];
    cell.LblAwayGoal.text = [NSString stringWithFormat:@"%@",[ArrayAwayTeamGoal objectAtIndex:indexPath.row]];
    
    return cell;
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
