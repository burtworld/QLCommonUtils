//
//  NSData+HEX.h
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/12.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (QLHEX)
- (NSString *)hexString;
+ (NSData *)dataWithHexString:(NSString *)hexStr;
@end
