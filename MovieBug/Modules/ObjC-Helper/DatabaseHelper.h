//
//  DatabaseHelper.h
//  MovieBug
//
//  Created by Vaghula krishnan on 13/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DatabaseHelper : NSObject
{
	sqlite3 *mySqliteDB;
}

@property (nonatomic, strong) NSString *databasePath;
- (void) initDatabase;

- (NSMutableArray *) getDetails;
- (BOOL) savePoints:(NSDictionary *)dict;

@end
