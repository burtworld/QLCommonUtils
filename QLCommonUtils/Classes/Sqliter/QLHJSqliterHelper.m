//
//  QLHJSqliterHelper.m
//  JuYiGo2
//
//  Created by Paramita on 16/3/18.
//  Copyright © 2016年 qlhj. All rights reserved.
//

#import "QLHJSqliterHelper.h"
#import "QLHJAPPManager.h"

@interface QLHJSqliterHelper()

@end


@implementation QLHJSqliterHelper


+ (instancetype)sqliterHelper {
    static id sqliterHelp = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sqliterHelp = [[[self class] alloc]initWithDBName:@"appdata.sqlite"];
    });
    return sqliterHelp;
}
- (id)initWithDBName:(NSString *)dbName {
    self = [super init];
    if (self) {
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:[DB_PATH stringByAppendingPathComponent:dbName]];
        NSLog(@"DB_PATH :%@",[DB_PATH stringByAppendingPathComponent:dbName]);
        [self createTables];
    }
    return self;
}

- (void)createTables {
    
}

//- (FMDatabase *)db {
////    return _dbQueue database
//    return nil;
//}

- (BOOL)openDB {
//    if (![db open]) {
//        NSLog(@"open db failed.");
//        return NO;
//    }
    return YES;
}
// 判断是否存在表
- (BOOL) isTableOK:(NSString *)tableName
{
    __block BOOL ok = NO;
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
        while ([rs next])
        {
            NSInteger count = [rs intForColumn:@"count"];
            if (0 == count) {
                ok = NO;
            }else{
                ok = YES;
            }
        }
        [rs close];
    }];
    return ok;
}
- (BOOL)existsRecordsInTable:(NSString *)tableName {
//    [self openDB];
    __block BOOL hasRecords = NO;
    if ([self isTableOK:tableName]) {
        [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *sql = [NSString stringWithFormat:@"select 1 from %@", tableName];
            FMResultSet *rs = [db executeQuery:sql];
            if (rs.next) {
                hasRecords = YES;
            }
            [rs close];
        }];
    }
    return hasRecords;
}





@end
