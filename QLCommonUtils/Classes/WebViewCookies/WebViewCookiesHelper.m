//
//  WebViewCookiesHelper.m
//  QLCommonUtils
//
//  Created by Paramita on 2018/8/16.
//  Copyright © 2018年 Paramita. All rights reserved.
//

#import "WebViewCookiesHelper.h"
#import "NSString+QLURL.h"

@implementation WebViewCookiesHelper
+ (void)writeCookiesWithCookiesName:(NSString *)cookieName cookieValue:(NSString *)cookieValue domain:(NSString *)urlStr {
    urlStr = [urlStr URLEncodedString];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:cookieName forKey:NSHTTPCookieName];
    [cookieProperties setObject:cookieValue forKey:NSHTTPCookieValue];
    [cookieProperties setObject:url.host forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    NSHTTPCookie *cookie1 = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie1];
    
    NSString *cookieNameAndValue = [NSString stringWithFormat:@"%@=%@",cookieName,cookieValue];
    /// 设置header 否则无效
    NSArray *cookie2 = [NSHTTPCookie cookiesWithResponseHeaderFields:@{@"Set-Cookie":cookieNameAndValue} forURL:[NSURL URLWithString:url.host]];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookie2 forURL:url mainDocumentURL:url];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
}
@end
