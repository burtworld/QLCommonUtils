//
//  WebViewCookiesHelper.h
//  QLCommonUtils
//
//  Created by Paramita on 2018/8/16.
//  Copyright © 2018年 Paramita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebViewCookiesHelper : NSObject
+ (void)writeCookiesWithCookiesName:(NSString *)cookieName cookieValue:(NSString *)cookieValue domain:(NSString *)urlStr;
@end
