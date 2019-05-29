//
//  QLHJSqliterHelper.h
//  JuYiGo2
//
//  Created by Paramita on 16/3/18.
//  Copyright © 2016年 qlhj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <fmdb/FMDB.h>





@interface QLHJSqliterHelper : NSObject{
    
}

@property (assign, nonatomic) BOOL hasCreatWorkPlatformTable;
@property (nonatomic, retain) FMDatabaseQueue *dbQueue;
+ (instancetype)sqliterHelper;
- (id)initWithDBName:(NSString *)dbName;

/// 子类重写建表方法，初始化时将调用本方法
- (void)createTables;

- (BOOL)openDB;
- (BOOL)existsRecordsInTable:(NSString *)tableName;

//! 判断是否存在表
- (BOOL) isTableOK:(NSString *)tableName;

@end
