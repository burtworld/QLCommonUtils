//
//  QLUserDefault.h
//  QLCommonUtils
//
//  Created by Paramita on 2018/7/23.
//  Copyright © 2018年 Paramita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLUserDefault : NSObject
+ (id _Nullable )getObjectWithKey:( NSString * _Nonnull )key;
+ (void)setObject:(nullable id)obj forKey:(nonnull NSString *)key;
@end
