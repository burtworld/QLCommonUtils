//
//  NSString+QLURL.m
//  QLCommonUtils
//
//  Created by Paramita on 2018/8/7.
//  Copyright © 2018年 Paramita. All rights reserved.
//

#import "NSString+QLURL.h"
#import "QLHJAPPManager.h"

@implementation NSString (QLURL)
- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

- (NSString *)URLDecodedString
{
    NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


- (NSDictionary*)getUrlQueryWithEncoding:(NSStringEncoding)encoding {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:self];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString* value = [[kvPair objectAtIndex:1]
                               stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }else{
            
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}

- (NSMutableDictionary *)disassembleUrlToDic {
//    NSURL *url = [NSURL URLWithString:self];
//    url.query
    NSArray * urlArray = [self componentsSeparatedByString:@"?"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:urlArray[0] forKey:@"url"];
    if (urlArray.count == 2) {
        NSArray * paramAry = [urlArray[1] componentsSeparatedByString:@"&"];
        for (NSString * param in paramAry) {
            NSArray *keyValues = [param componentsSeparatedByString:@"="];
            if (keyValues.count >= 2) {
                [dic setObject:keyValues[1] forKey:keyValues[0]];
            }
//            NSRange range = [param rangeOfString:@"="];
//            if (range.location != NSNotFound) {
//                NSString *key = [param substringToIndex:range.location];
//                NSString *value = [param substringFromIndex:range.location + range.length];
//                [dic setObject:value forKey:key];
//            }else{
//                NSLog_WARNING(@"查找字符串警告：");
//            }
        }
    }
    return dic;
}
@end
