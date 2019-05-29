//
//  TestRSA.h
//  TestProject
//
//  Created by Paramita on 16/10/26.
//  Copyright © 2016年 Paramita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLHJRSA : NSObject

/**
 使用文件加密

 @param str 加密串
 @param path 公钥文件路径
 @return 加密后的串
 */
+ (NSString *)encryptString:(NSString *)str publicKeyWithContentsOfFile:(NSString *)path;


/**
 使用文件解密

 @param str 解密串
 @param path 私钥文件路径p12格式
 @param password 密码
 @return 解密后的串
 */
+ (NSString *)decryptString:(NSString *)str privateKeyWithContentsOfFile:(NSString *)path password:(NSString *)password;


/**
 RSA加密

 @param str 加密串
 @param pubKey 公钥串
 @return 解密后的串
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;


/**
 RSA解密

 @param str 解密串
 @param privKey 私钥串
 @return 解密后的串
 */
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;

@end
