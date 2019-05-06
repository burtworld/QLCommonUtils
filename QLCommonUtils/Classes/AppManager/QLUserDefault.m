//
//  QLUserDefault.m
//  QLCommonUtils
//
//  Created by Paramita on 2018/7/23.
//  Copyright © 2018年 Paramita. All rights reserved.
//

#import "QLUserDefault.h"
@interface QLUserDefault()
@property (nonatomic, strong) NSUserDefaults *userDefault;
@end

@implementation QLUserDefault
+ (instancetype)userDefault{
    static QLUserDefault * manger = nil;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        manger = [QLUserDefault new];
        
    });
    return manger;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userDefault = [NSUserDefaults standardUserDefaults];

    }
    return self;
}

+ (id)getObjectWithKey:(NSString *)key {

    return [[QLUserDefault userDefault].userDefault objectForKey:key];
}

+ (void)setObject:(nullable id)obj forKey:(nonnull NSString *)key {
    [[QLUserDefault userDefault].userDefault setObject:obj forKey:key];
    [[QLUserDefault userDefault].userDefault synchronize];
}

@end
