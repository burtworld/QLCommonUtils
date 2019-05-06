//
//  NSString+Encryption.m
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/12.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import "NSString+QLBase64.h"


@implementation NSString (QLBase64)

- (NSString*)base64Encode{
    //1.将字符串转换成二进制数据
    NSString *string = [self copy];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //2.利用ios7.0的方法，直接 base64 编码
    return [data base64EncodedStringWithOptions:0];
}

- (NSString*)base64Decode {
    //1.将base64编码后的字符串，解码成二进制数据
    NSString *string = [self copy];
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:0];
    //2.返回解码的字符串
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
}



@end
