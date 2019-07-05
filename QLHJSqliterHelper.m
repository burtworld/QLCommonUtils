//
//  QLHJSqliterHelper.m
//  JuYiGo2
//
//  Created by Paramita on 16/3/18.
//  Copyright © 2016年 qlhj. All rights reserved.
//

#import "QLHJSqliterHelper.h"
#import "QLHJAPPManager.h"
#import <SQLCipher/sqlite3.h>
//#import "FMEncryptDatabase.h"
//#import "FMEncryptDatabaseQueue.h"

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
        self.dbName = dbName;
//        self.dbName = [DB_PATH stringByAppendingPathComponent:dbName];
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.dbName];
//        NSLog(@"DB_PATH :%@",[DB_PATH stringByAppendingPathComponent:dbName]);
        [self createTables];
    }
    return self;
}

- (void)createTables {
//    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
//        BOOL suc = [db executeUpdate:@"create table if not exists t_test(uuid text, sm4Key text)"];
//        if (suc) {
//            NSLog(@"suc---");
//        }
//    }];
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


@implementation QLHJSqliterHelper (QLEencrypt)

static NSString *encryptKey_;

+ (void)initialize
{
    [super initialize];
    //初始化数据库加密key，在使用之前可以通过 setEncryptKey 修改
    encryptKey_ = @"FDLSAFJEIOQJR34JRI4JIGR93209T489FR";
}

+ (void)setEncryptKey:(NSString *)encryptKey {
    if (encryptKey != nil) {
        encryptKey_ = encryptKey;
    }
}

//对数据库加密（文件不变）
+ (BOOL)encryptDatabase:(NSString *)path
{
    NSString *sourcePath = path;
    NSString *targetPath = [NSString stringWithFormat:@"%@.tmp.db", path];
    
    if([self encryptDatabase:sourcePath targetPath:targetPath]) {
        NSFileManager *fm = [[NSFileManager alloc] init];
        [fm removeItemAtPath:sourcePath error:nil];
        [fm moveItemAtPath:targetPath toPath:sourcePath error:nil];
        return YES;
    } else {
        return NO;
    }
}

//对数据库解密（文件不变）
+ (BOOL)unEncryptDatabase:(NSString *)path
{
    NSString *sourcePath = path;
    NSString *targetPath = [NSString stringWithFormat:@"%@.tmp.db", path];
    
    if([self unEncryptDatabase:sourcePath targetPath:targetPath]) {
        NSFileManager *fm = [[NSFileManager alloc] init];
        [fm removeItemAtPath:sourcePath error:nil];
        [fm moveItemAtPath:targetPath toPath:sourcePath error:nil];
        return YES;
    } else {
        return NO;
    }
}

/** 对数据库加密 */
+ (BOOL)encryptDatabase:(NSString *)sourcePath targetPath:(NSString *)targetPath
{
    const char* sqlQ = [[NSString stringWithFormat:@"ATTACH DATABASE '%@' AS encrypted KEY '%@';", targetPath, encryptKey_] UTF8String];
    
    sqlite3 *unencrypted_DB;
    if (sqlite3_open([sourcePath UTF8String], &unencrypted_DB) == SQLITE_OK) {
        
        // Attach empty encrypted database to unencrypted database
        sqlite3_exec(unencrypted_DB, sqlQ, NULL, NULL, NULL);
        
        // export database
        sqlite3_exec(unencrypted_DB, "SELECT sqlcipher_export('encrypted');", NULL, NULL, NULL);
        
        // Detach encrypted database
        sqlite3_exec(unencrypted_DB, "DETACH DATABASE encrypted;", NULL, NULL, NULL);
        
        sqlite3_close(unencrypted_DB);
        
        return YES;
    }
    else {
        sqlite3_close(unencrypted_DB);
        NSAssert1(NO, @"Failed to open database with message '%s'.", sqlite3_errmsg(unencrypted_DB));
        
        return NO;
    }
}

/** 对数据库解密 */
+ (BOOL)unEncryptDatabase:(NSString *)sourcePath targetPath:(NSString *)targetPath
{
    const char* sqlQ = [[NSString stringWithFormat:@"ATTACH DATABASE '%@' AS plaintext KEY '';", targetPath] UTF8String];
    
    sqlite3 *encrypted_DB;
    if (sqlite3_open([sourcePath UTF8String], &encrypted_DB) == SQLITE_OK) {
        
        
        sqlite3_exec(encrypted_DB, [[NSString stringWithFormat:@"PRAGMA key = '%@';", encryptKey_] UTF8String], NULL, NULL, NULL);
        
        // Attach empty unencrypted database to encrypted database
        sqlite3_exec(encrypted_DB, sqlQ, NULL, NULL, NULL);
        
        // export database
        sqlite3_exec(encrypted_DB, "SELECT sqlcipher_export('plaintext');", NULL, NULL, NULL);
        
        // Detach unencrypted database
        sqlite3_exec(encrypted_DB, "DETACH DATABASE plaintext;", NULL, NULL, NULL);
        
        sqlite3_close(encrypted_DB);
        
        return YES;
    }
    else {
        sqlite3_close(encrypted_DB);
        NSAssert1(NO, @"Failed to open database with message '%s'.", sqlite3_errmsg(encrypted_DB));
        
        return NO;
    }
}

/** 修改数据库秘钥 */
+ (BOOL)changeKey:(NSString *)dbPath originKey:(NSString *)originKey newKey:(NSString *)newKey
{
    sqlite3 *encrypted_DB;
    if (sqlite3_open([dbPath UTF8String], &encrypted_DB) == SQLITE_OK) {
        
        sqlite3_exec(encrypted_DB, [[NSString stringWithFormat:@"PRAGMA key = '%@';", originKey] UTF8String], NULL, NULL, NULL);
        
        sqlite3_exec(encrypted_DB, [[NSString stringWithFormat:@"PRAGMA rekey = '%@';", newKey] UTF8String], NULL, NULL, NULL);
        
        sqlite3_close(encrypted_DB);
        return YES;
    }
    else {
        sqlite3_close(encrypted_DB);
        NSAssert1(NO, @"Failed to open database with message '%s'.", sqlite3_errmsg(encrypted_DB));
        
        return NO;
    }
}

@end
