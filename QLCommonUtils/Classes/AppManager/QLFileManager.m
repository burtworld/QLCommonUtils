//
//  QLFileManager.m
//  QLCommonUtils
//
//  Created by Paramita on 2018/8/21.
//  Copyright © 2018年 Paramita. All rights reserved.
//

#import "QLFileManager.h"

@implementation QLFileManager
+ (NSArray *)getAllFileInPath:(NSString *)path {
    return  [QLFileManager getAllFileInPath:path fileNameArray:nil];
}

+ (NSArray *)getAllFileInPath:(NSString *)path fileNameArray:(NSMutableArray *)fileNameArray{
    NSMutableArray *fileArray = [NSMutableArray array];
    NSFileManager * fileManger = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManger fileExistsAtPath:path isDirectory:&isDir];
    if (isExist) {
        if (isDir) {
            NSArray * dirArray = [fileManger contentsOfDirectoryAtPath:path error:nil];
            NSString * subPath = nil;
            for (NSString * str in dirArray) {
                subPath  = [path stringByAppendingPathComponent:str];
                BOOL issubDir = NO;
                [fileManger fileExistsAtPath:subPath isDirectory:&issubDir];
                NSArray *subFileArray = [QLFileManager getAllFileInPath:subPath fileNameArray:fileNameArray];
                [fileArray addObjectsFromArray:subFileArray];
            }
        }else{
            NSString *fileName = [[path componentsSeparatedByString:@"/"] lastObject];
            if (fileNameArray) {
                [fileNameArray addObject:fileName];
            }
            [fileArray addObject:path];
        }
    }else{
        NSLog(@"this path is not exist!");
    }
    return  fileArray;
}

@end
