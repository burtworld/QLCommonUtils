//
//  NSDictionary+Function.h
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/20.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (QLToJson)
/// 使用NSJSONSerialization 直接转换
- (NSString*)toJsonString;

/// 转为json并且去除空格和换行
- (NSString*)toJsonStringWithoutWhiteSpaceAndNewLine;
@end
