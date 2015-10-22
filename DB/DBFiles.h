//
//  DBFiles.h
//  SixGroups
//
//  Created by Arulpandiyan on 22/10/15.
//  Copyright (c) 2015 sybrant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBFiles : NSObject {
    
    NSString *pStrLoginStatus,*pUserId,*pCustomerID,*pStrId;
    int iFavourite;
    sqlite3 *database;
    NSInteger primaryKey;
    DBFiles *oDBFiles;
    NSMutableArray *pArrDetails;
}
@property(nonatomic)NSInteger primaryKey;
@property(nonatomic,retain) NSString *StringHomeTeamName,*StringAwayTeamName,*StringStatus,*StringHomeTeamGoal,*StringAwayTeamGoal,*StringDate;


- (id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db;
- (BOOL)fnInsertData:(NSMutableArray *)pArrMessage;
- (NSMutableArray *)fnGetDetails;
- (BOOL)fnDelete;


@end
