//
//  NSArray+Function.m
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/20.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import "NSArray+QLToJson.h"

@implementation NSArray (QLToJson)
- (NSString *)toJosnString {
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
@end
