//
//  HWDatabaseManager.m
//  Ticket-ios
//
//  Created by Anson on 15-9-5.
//  Copyright (c) 2015年 LHW. All rights reserved.
//

#import "HWDatabaseManager.h"


@implementation HWDatabaseManager
@synthesize database;

-(id)init
{
    if (self = [super init]) {
        NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSString *dbPath = [docsPath stringByAppendingPathComponent:@"hwdata.sqlite"];
        database = [FMDatabase databaseWithPath:dbPath];
        [database setShouldCacheStatements:YES];
    }
    return self;
}

+(HWDatabaseManager *)shareInstance
{
    static HWDatabaseManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

-(FMDatabase *)openDatabase
{
    if ([database open]){
        return database;
    }
    return nil;
}

-(void)closeDatabase
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([database close]) {
            database = nil;
        }
    });
}

-(BOOL)removeAllData:(NSString *)tablename
{
    if ([[self openDatabase] tableExists:tablename]) {
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where 1 = 1",tablename];
        BOOL isDelete = [[self openDatabase] executeUpdate:sql];
        NSLog(@"%@,table name:%@",isDelete ? @"Delete all data successfully":@"Delete all data failed",tablename);
        return isDelete;
    }else{
        return NO;
    }
}

-(BOOL)deleteDatabase
{
    NSString *dbPath = [__G__DOCUMENT_DIR stringByAppendingPathComponent:@"hwdata.sqlite"];
    return [[NSFileManager defaultManager]removeItemAtPath:dbPath error:nil];
}

-(BOOL)isTableExists:(NSString *)tableName
{
    if ([[self openDatabase] tableExists:tableName]) {
        NSLog(@"*** Table %@ is existed！",tableName);
        return YES;
    }else{
        NSLog(@"*** Table %@ is not existed！",tableName);
        return NO;
    }

}

-(BOOL)createTable:(NSString *)tableName withArguments:(NSString *)arguments
{

    if ([database open]) {
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@')",tableName,arguments];
        BOOL res = [database executeUpdate:sqlCreateTable];
        if (!res) {
            NSLog(@"error when creating db table");
            [database close];
            return NO;
        } else {
            NSLog(@"success to creating db table");
            return YES;
        }
        
    }else{
        return NO;
    }
        
}

//-(BOOL)insert:(BaseModel *)model table:(NSString *)tableName
//{
//    
//}

@end
