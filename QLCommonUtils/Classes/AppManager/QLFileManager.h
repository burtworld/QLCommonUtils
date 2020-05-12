//
//  QLFileManager.h
//  QLCommonUtils
//
//  Created by Paramita on 2018/8/21.
//  Copyright © 2018年 Paramita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLFileManager : NSObject


/**
 获取路径下的所有文件的完整路径
 
 如果fileNameArray=nil,将不传出文件名
 @also see + (NSArray *)getAllFileInPath:(NSString *)path
 @param path 文件路径
 @param fileNameArray 传入一个数组指针，里面将携带文件名
 @return 文件路径数组
 */
+ (NSArray *_Nullable)getAllFileInPath:(NSString *_Nullable)path fileNameArray:(nullable NSMutableArray *)fileNameArray;

+ (NSArray *_Nullable)getAllFileInPath:(NSString *_Nullable)path;


/// 获取子文件夹
/// @param path 文件路径
+ (NSArray *)getSubFolderInPath:(NSString *)path;

@end
