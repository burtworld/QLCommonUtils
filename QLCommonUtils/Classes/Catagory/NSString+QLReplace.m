//
//  NSString+Replace.m
//  YRCollaborativeOA
//
//  Created by Paramita on 2016/12/1.
//  Copyright © 2016年 Paramita. All rights reserved.
//

#import "NSString+QLReplace.h"
#import "QLHJDataModel.h"

@implementation NSString (QLReplace)


- (NSString *)foundSymbol:(NSString *)symbol replace:(id)replaceItem {
    return [self foundSymbol:symbol replaceWithUrlItem:replaceItem otherItem:nil];
}


/**
 查找到一对标识符以内的字符，并使用提供的对象的相应字段替换，用于对url的拼接

 @param symbol 标识符
 @param urlItem host
 @param oterhItem 对象的值
 @return 返回替换好的url
 */
- (NSString *)foundSymbol:(NSString *)symbol replaceWithUrlItem:(QLHJDataModel *)urlItem otherItem:(QLHJDataModel *)oterhItem {
    if (symbol.length != 2) {
        return nil;
    }
    NSString *action = [self copy];
    if ([action rangeOfString:@"URL:"].location != NSNotFound) {
        action = [action stringByReplacingOccurrencesOfString:@"URL:" withString:@""];
    }
    NSRange range1 = NSMakeRange(0, 0);
    NSRange range2 = NSMakeRange(0, 0);
    NSString *symbole1 = [symbol substringToIndex:1];
    NSString *symbole2 = [symbol substringFromIndex:1];
    do {
        range1 = [self rangeOfString:symbole1 options:NSCaseInsensitiveSearch range:NSMakeRange(range1.location + range1.length, self.length - range1.location - range2.length)];
        
        if (range1.location != NSNotFound) {
            range2 = [self rangeOfString:symbole2 options:NSCaseInsensitiveSearch range:NSMakeRange(range2.location + range2.length, self.length - range2.location - range2.length)];
            NSString *match = [self substringWithRange:NSMakeRange(range1.location + range1.length, range2.location - range1.location - range1.length)];

            if (match) {
                if ([match containsString:@"SYSURL"]) {
                    NSDictionary *dic = urlItem.orgDic;
                    NSString *host = [dic valueForKey:match];
                    if (host != nil) {
                        action = [action stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@%@%@",symbole1,match,symbole2] withString:host];
                    }
                }else if ([match containsString:@"contextPath"]) {
                    NSString *host = urlItem.orgDic[@"SYSURL_mobile"];
                    if (host != nil) {
                        action = [action stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@%@%@",symbole1,match,symbole2] withString:host];
                    }
                }else{
                    if (oterhItem) {
                        NSDictionary *dic = oterhItem.orgDic;
                        NSString *value = [dic valueForKey:match];
                        if (value != nil) {
                            action = [action stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@%@%@",symbole1,match,symbole2] withString:value];
                        }
                    }
                }
            }
        }
    } while (range1.location != NSNotFound && range2.location != NSNotFound);
    return action;
}

- (NSString *)foundSymbol:(NSString *)symbol replaceWithUrlItem:(NSDictionary *)dic {
    if (symbol.length != 2) {
        return nil;
    }
    NSString *action = [self copy];
    if ([action rangeOfString:@"URL:"].location != NSNotFound) {
        action = [action stringByReplacingOccurrencesOfString:@"URL:" withString:@""];
    }
    NSRange range1 = NSMakeRange(0, 0);
    NSRange range2 = NSMakeRange(0, 0);
    NSString *symbole1 = [symbol substringToIndex:1];
    NSString *symbole2 = [symbol substringFromIndex:1];
    do {
        range1 = [self rangeOfString:symbole1 options:NSCaseInsensitiveSearch range:NSMakeRange(range1.location + range1.length, self.length - range1.location - range2.length)];
        
        if (range1.location != NSNotFound) {
            range2 = [self rangeOfString:symbole2 options:NSCaseInsensitiveSearch range:NSMakeRange(range2.location + range2.length, self.length - range2.location - range2.length)];
            NSString *match = [self substringWithRange:NSMakeRange(range1.location + range1.length, range2.location - range1.location - range1.length)];
            
            if (match) {
                NSString *value = [dic valueForKey:match];
                if (value != nil) {
                    action = [action stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@%@%@",symbole1,match,symbole2] withString:value];
                }
            }
        }
    } while (range1.location != NSNotFound && range2.location != NSNotFound);
    return action;
}

- (NSMutableDictionary *)configUrl {
    if (self == nil) {
        NSLog(@"your input string is nil");
        return nil;
    }
    NSArray * urlArray = [self componentsSeparatedByString:@"?"];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:urlArray[0] forKey:@"url"];
    if (urlArray.count == 2) {
        NSArray * paramAry = [urlArray[1] componentsSeparatedByString:@"&"];
        for (NSString * param in paramAry) {
            NSArray * ary = [param componentsSeparatedByString:@"="];
            if (ary.count == 2) {
                // 创建文件名称
  
                if ([ary[1] containsString:@"{fname}"]) {
                    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
                    [formatter setDateFormat:@"yyyyMMddHHmmss"];
                    NSString * nowTime = [formatter stringFromDate:[NSDate date]];
                    [dic setObject:nowTime forKey:ary[0]];
                }else if ([ary[1] containsString:@"{ftype}"]) {
                    [dic setObject:@"jpg" forKey:ary[0]];
                }else{
                    [dic setObject:ary[1] forKey:ary[0]];
                }
            }
        }
    }
    return dic;
}

- (NSString *)addFromApp {
    NSString * fromApp = [self copy];
    if ([fromApp rangeOfString:@"?"].location != NSNotFound) {
        fromApp = [self stringByAppendingString:@"&FromApp=1"];
    }else{
        fromApp = [self stringByAppendingString:@"?FromApp=1"];
    }
    return fromApp;
}

//去掉html标签
- (NSString *)flattenHTML {
    if (self == nil) {
        return nil;
    }
    NSScanner *theScanner;
    NSString *text = nil;
    NSString * html = [self copy];
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html=[html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    return html;
}

@end
