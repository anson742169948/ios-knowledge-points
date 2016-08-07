//
//  HWDatabaseManager.h
//  Ticket-ios
//
//  Created by Anson on 15-9-5.
//  Copyright (c) 2015年 LHW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "fmdb/FMDB.h"
#import "BaseModel.h"
#import "Constant.h"

@interface HWDatabaseManager : NSObject

@property(nonatomic,retain) FMDatabase *database;

/**
 *  singleton 单例
 *
 *  @return HWDatabaseManager*
 */
+ (HWDatabaseManager *)shareInstance;

/**
 *  open data base 连接数据库
 *
 *  @return FMDatabase*
 */
- (FMDatabase *)openDatabase;

/**
 *  close data base 关闭数据库
 */
- (void)closeDatabase;
/**
 *  remove all data from table
 *
 *  @return success or failed
 */
- (BOOL)removeAllData:(NSString *)tablename;

/**
 *  delete data base
 *
 *  @return success or failed
 */
- (BOOL)deleteDatabase;

/**
 *  is table exists
 *
 *  @param table name
 *
 *  @return is exist or not
 */
- (BOOL)isTableExists:(NSString *)tableName;

/**
 *  create table
 *
 *  @param table name
 *
 *  @return is successful or failed
 */
- (BOOL)createTable:(NSString *)tableName withArguments:(NSString *)arguments;

/**
 *  insert data model to table
 *
 *  @param model with data
 *
 *  @return success or failed
 */
- (BOOL)insert:(BaseModel *)model table:(NSString*)tableName;

/**
 *  update data model
 *
 *  @param  model with data
 *
 *  @return success or failed
 */
- (BOOL)update:(BaseModel *)model table:(NSString*)tableName;

/**
 *  remove the model
 *
 *  @param model with data
 *
 *  @return success or failed
 */
- (BOOL)remove:(BaseModel *)model table:(NSString*)tableName;

/**
 *  remove the model which is that id
 *
 *  @param id is the model's id
 *
 *  @return success or failed
 */
- (BOOL)removeModelWithId:(NSString *)id table:(NSString*)tableName;

/**
 *  query the model with the id gived
 *
 *  @param id is the model's id
 *
 *  @return the data model
 */
- (BaseModel *)findModelWithId:(NSString *)id table:(NSString*)tableName;

/**
 *  update the model which is that id
 *
 *  @param id is the model's id
 *
 *  @return success or failed
 */
- (BOOL)updateModelWithId:(NSString *)id table:(NSString*)tableName;

/**
 *  query all model and order by time
 *
 *  @return array with all model
 */
- (NSMutableArray *)queryAllOrderByTimeInTable:(NSString*)tableName;

@end
