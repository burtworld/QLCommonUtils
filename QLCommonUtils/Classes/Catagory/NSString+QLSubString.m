//
//  NSString+QLSubString.m
//  QLCommonUtils
//
//  Created by paramita on 2018/8/30.
//  Copyright © 2018年 Paramita. All rights reserved.
//

#import "NSString+QLSubString.h"

@implementation NSString (QLSubString)

- (NSString *)substringFromString:(NSString *)string {
    if (!self) {
        return nil;
    }
    if (!string.length) {
        return [self mutableCopy];
    }
    NSRange range = [self rangeOfString:string];
    if (range.location != NSNotFound) {
        return [self substringFromIndex:range.location + range.length];
    }
    return [self mutableCopy];
}

- (NSString *)substringToString:(NSString *)string {
    if (!self) {
        return nil;
    }
    if (!string.length) {
        return [self mutableCopy];
    }
    NSRange range = [self rangeOfString:string];
    if (range.location != NSNotFound) {
        return [self substringToIndex:range.location];
    }
    return [self mutableCopy];
}

@end
