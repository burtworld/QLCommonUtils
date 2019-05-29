//
//  NSString+QLSubString.h
//  QLCommonUtils
//
//  Created by paramita on 2018/8/30.
//  Copyright © 2018年 Paramita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QLSubString)

/**
 截取子串

 @param string 标识串
 @return 从开头到这个串的子串（不包含）
 */
- (NSString *)substringFromString:(NSString *)string;


/**
 截取子串

 @param string 标识串
 @return 从子串结束到这个串的末尾（不包含）
 */
- (NSString *)substringToString:(NSString *)string;
@end
