//
//  DatabaseHelper.m
//  MovieBug
//
//  Created by Vaghula krishnan on 13/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

#import "DatabaseHelper.h"

@implementation DatabaseHelper
@synthesize databasePath;

#pragma mark - Database Init
- (void) initDatabase {
	
	NSString *docsDir;
	NSArray *dirPaths;
	
	// Get the documents directory
	dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	docsDir = [dirPaths objectAtIndex:0];
	
	// Build the path to the database file
	databasePath = [[NSString alloc] initWithString:
					[docsDir stringByAppendingPathComponent:@"MovieBug.sqlite"]];
	
	NSFileManager *filemgr = [NSFileManager defaultManager];
	//the file will not be there when we load the application for the first time
	//so this will create the database table
	if ([filemgr fileExistsAtPath: databasePath ] == NO)
	{
		const char *dbpath = [databasePath UTF8String];
		if (sqlite3_open(dbpath, &mySqliteDB) == SQLITE_OK)
		{
			char *errMsg;
			NSString *sql_stmt = @"CREATE TABLE IF NOT EXISTS Movies (";
			sql_stmt = [sql_stmt stringByAppendingString:@"auto_id INTEGER PRIMARY KEY AUTOINCREMENT, "];
			sql_stmt = [sql_stmt stringByAppendingString:@"id int,"];
			sql_stmt = [sql_stmt stringByAppendingString:@"vote_average float,"];
			sql_stmt = [sql_stmt stringByAppendingString:@"title text,"];
			sql_stmt = [sql_stmt stringByAppendingString:@"popularity float,"];
			sql_stmt = [sql_stmt stringByAppendingString:@"poster_path text,"];
			sql_stmt = [sql_stmt stringByAppendingString:@"backdrop_path text,"];
			sql_stmt = [sql_stmt stringByAppendingString:@"overview text,"];
			sql_stmt = [sql_stmt stringByAppendingString:@"release_date text,"];
			sql_stmt = [sql_stmt stringByAppendingString:@"page text)"];

			
			
			
			if (sqlite3_exec(mySqliteDB, [sql_stmt UTF8String], NULL, NULL, &errMsg) != SQLITE_OK)
			{
				NSLog(@"Failed to create table");
			}
			else
			{
				NSLog(@"Message table created successfully");
			}
			
			sqlite3_close(mySqliteDB);
			
		} else {
			NSLog(@"Failed to open/create database");
		}
	}
	
}
#pragma mark - Database Save

- (BOOL) savePoints:(NSDictionary *)dict;
{
	BOOL success = false;
	sqlite3_stmt *statement = NULL;
	const char *dbpath = [databasePath UTF8String];
	if (sqlite3_open(dbpath, &mySqliteDB) == SQLITE_OK)
	{
		
		const char *insert_stmt = "INSERT INTO Movies (id,vote_average,title,popularity,poster_path,backdrop_path,overview,release_date,page) VALUES (?,?,?,?,?,?,?,?,?)";
		//NSLog(@"%@",[[dict objectForKey:@"popularity"] floatValue]);
		//NSLog(@"%@",dict);
		sqlite3_prepare_v2(mySqliteDB, insert_stmt, -1, &statement, NULL);
		sqlite3_bind_int64(statement, 1, [[dict objectForKey:@"id"] intValue]);
		sqlite3_bind_int64(statement, 2, [[dict objectForKey:@"vote_average"] floatValue]);
		sqlite3_bind_text(statement, 3, [[dict objectForKey:@"title"] UTF8String], -1, SQLITE_STATIC);
		sqlite3_bind_int64(statement, 4, [[dict objectForKey:@"popularity"] floatValue]);
		sqlite3_bind_text(statement, 5, [[dict objectForKey:@"poster_path"] UTF8String], -1, SQLITE_STATIC);
		sqlite3_bind_text(statement, 6, [[dict objectForKey:@"backdrop_path"] UTF8String], -1, SQLITE_STATIC);
		sqlite3_bind_text(statement, 7, [[dict objectForKey:@"overview"] UTF8String], -1, SQLITE_STATIC);
		sqlite3_bind_text(statement, 8, [[dict objectForKey:@"release_date"] UTF8String], -1, SQLITE_STATIC);
		sqlite3_bind_text(statement, 9, [[dict objectForKey:@"page"] UTF8String], -1, SQLITE_STATIC);
							   if (sqlite3_step(statement) == SQLITE_DONE)
							   {
								   success = true;
								   NSLog(@"insert done %d",success);

							   }else{
								   NSLog(@"%@",dict);
								   NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(mySqliteDB), sqlite3_errcode(mySqliteDB));
							   }
							   
							   sqlite3_finalize(statement);
							   sqlite3_close(mySqliteDB);
							   
							   }
							   
							   return success;
							   }
							   
							   
#pragma mark - Database Retrive

- (NSMutableArray *) getDetails
		{
			NSMutableArray *notifyList = [[NSMutableArray alloc] init];
			const char *dbpath = [databasePath UTF8String];
			sqlite3_stmt    *statement;
			
			if (sqlite3_open(dbpath, &mySqliteDB) == SQLITE_OK)
			{
				NSString *querySQL =[NSString stringWithFormat:@"SELECT * FROM Movies"];
				
				const char *query_stmt = [querySQL UTF8String];
				
				if (sqlite3_prepare_v2(mySqliteDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
				{
					while (sqlite3_step(statement) == SQLITE_ROW)
					{
						NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
						dict[@"id"] = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
						dict[@"vote_average"] = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
						dict[@"title"] = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
						dict[@"popularity"] = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 4)];
						dict[@"poster_path"] = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 5)];
						dict[@"backdrop_path"] = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 6)];
						dict[@"overview"] = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 7)];
						dict[@"release_date"] = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 8)];
						[notifyList addObject:dict];
					}
					sqlite3_finalize(statement);
				}
				sqlite3_close(mySqliteDB);
			}
			
			return notifyList;
		}
							   
-(NSMutableString*) sqlite3StmtToString:(sqlite3_stmt*) statement
		{
			NSMutableString *s = [NSMutableString new];
			[s appendString:@"{\"statement\":["];
			for (int c = 0; c < sqlite3_column_count(statement); c++){
				[s appendFormat:@"{\"column\":\"%@\",\"value\":\"%@\"}",[NSString stringWithUTF8String:(char*)sqlite3_column_name(statement, c)],[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, c)]];
				if (c < sqlite3_column_count(statement) - 1)
					[s appendString:@","];
			}
			[s appendString:@"]}"];
			return s;
		}
							   
							   @end
							   

