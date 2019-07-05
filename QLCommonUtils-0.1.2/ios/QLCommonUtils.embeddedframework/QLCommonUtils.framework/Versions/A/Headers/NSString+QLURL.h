//
//  NSString+QLURL.h
//  QLCommonUtils
//
//  Created by Paramita on 2018/8/7.
//  Copyright © 2018年 Paramita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QLURL)

/// url编码
- (NSString *)URLEncodedString;


/**
 将url的参数全部提取出来 key为url的为字符 串
 
 e.g. {@"url": "http://www.baidu.com:8080",@"param1": @"value"}

 @return a dic include host with key:url and other params
 */
- (NSMutableDictionary *)disassembleUrlToDic;
@end
