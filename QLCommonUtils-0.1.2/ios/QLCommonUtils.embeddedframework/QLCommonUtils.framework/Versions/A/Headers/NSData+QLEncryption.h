//
//  NSData+Encryption.h
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/12.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSData (QLEncryption)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
- (NSData *)tripleDESDecryptWithkey:(NSData *)key;
- (NSData *)tripleDESEncryptWithkey:(NSData *)key;
@end
