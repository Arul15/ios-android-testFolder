//
//  DBFiles.m
//  SixGroups
//
//  Created by Arulpandiyan on 22/10/15.
//  Copyright (c) 2015 sybrant. All rights reserved.
//


#import "DBFiles.h"
#import "DataBaseConnection.h"


@implementation DBFiles

@synthesize primaryKey;
@synthesize StringHomeTeamName,StringAwayTeamName,StringStatus,StringHomeTeamGoal,StringAwayTeamGoal,StringDate;

static sqlite3_stmt *fav_update_statement = nil;

//Array insert into SQLite

- (BOOL)fnInsertData:(NSMutableArray *)pArrMessage {
    DataBaseConnection *oDBCon = [[DataBaseConnection alloc] init];

    @try {
        if (sqlite3_open([[oDBCon fnGetDBPath] UTF8String], &database) == SQLITE_OK) {
            
                NSString *updateSql = [NSString stringWithFormat: @"INSERT INTO FootBallTbl (hometeamname,awayteamname,status, hometeamgoal, awayteamgoal, date) VALUES ('%@','%@','%@','%@','%@','%@');",[pArrMessage objectAtIndex:0],[pArrMessage objectAtIndex:1],[pArrMessage objectAtIndex:2],[pArrMessage objectAtIndex:3],[pArrMessage objectAtIndex:4],[pArrMessage objectAtIndex:5]];
                const char *sql = [updateSql UTF8String];
                //const char *sql = "UPDATE tbldetails SET loginstatus=1,userid=? WHERE id=1";
                if (sqlite3_prepare_v2(database, sql, -1, &fav_update_statement, NULL) != SQLITE_OK) {
                    NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
                }
            
            NSLog(@"Successfully inserted or not");
            int success = sqlite3_step(fav_update_statement);
            if (success != SQLITE_DONE) {
                NSAssert1(0, @"Error: failed to save priority with message '%s'.", sqlite3_errmsg(database));
            }
            sqlite3_reset(fav_update_statement);
            sqlite3_close(database);
            
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exception in Db %@",exception);
    }
    @finally {
        
    }
    
    return YES;
}


/// get the datas from sqlite


- (NSMutableArray *)fnGetDetails {
    
   @try {
        DataBaseConnection *oDBCon = [[DataBaseConnection alloc] init];
        [oDBCon fnInitializeDB];
        oDBFiles = [[DBFiles alloc]init];

       pArrDetails = [[NSMutableArray alloc] init];
        
        NSString *sQryAuthor = [NSString stringWithFormat:@"SELECT * FROM FootBallTbl"];
        sqlite3_stmt *selectstmt;
        
        if(sqlite3_prepare_v2(oDBCon.database, [sQryAuthor UTF8String], -1, &selectstmt, NULL) == SQLITE_OK) {
            
            while(sqlite3_step(selectstmt) == SQLITE_ROW) {
                
                primaryKey = sqlite3_column_int(selectstmt, 0);
                oDBFiles = [[DBFiles alloc]initWithPrimaryKey:primaryKey database:oDBCon.database];
                
                
                oDBFiles.StringHomeTeamName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                oDBFiles.StringAwayTeamName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
                oDBFiles.StringStatus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
                oDBFiles.StringHomeTeamGoal = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 4)];
                oDBFiles.StringAwayTeamGoal = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 5)];
                oDBFiles.StringDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 5)];
                [pArrDetails addObject:oDBFiles];
            }
            
        } else {
            
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(oDBCon.database));
        }
        sqlite3_finalize(selectstmt);
        [oDBCon fnCloseDB];
        
        return pArrDetails;
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exception Error is %@",exception);
    }
    @finally {
        
    }


    
    
}

// Delete the Table Data

- (BOOL)fnDelete {
    
    DataBaseConnection *oDBCon = [[DataBaseConnection alloc] init];
    
    sqlite3_stmt *fav_update_statement = nil;
    
    if(sqlite3_open([[oDBCon fnGetDBPath] UTF8String],&database)==SQLITE_OK)
    {
        
        NSString *sqlStmt=[NSString stringWithFormat:@"DELETE FROM FootBallTbl"];
        if(sqlite3_prepare_v2(database, [sqlStmt UTF8String],-1,&fav_update_statement, NULL)==SQLITE_OK)
        {
        }
        sqlite3_step(fav_update_statement);
        sqlite3_close(database);
    }
    
    return YES;
    
}


- (id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db {
    database=db;
    primaryKey = pk;
    return self;
}

@end
