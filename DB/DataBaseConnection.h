//
//  DataBaseConnection.h
//  SixGroups
//
//  Created by Arulpandiyan on 22/10/15.
//  Copyright (c) 2015 sybrant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DataBaseConnection : NSObject {
    NSString *defaultDBPath;

    sqlite3 *database;
}

@property (nonatomic) sqlite3 *database;

- (void)fnCopyDatabase;
- (void) fnInitializeDB;
- (NSString *) fnGetDBPath;
- (void)fnCloseDB;

@end
