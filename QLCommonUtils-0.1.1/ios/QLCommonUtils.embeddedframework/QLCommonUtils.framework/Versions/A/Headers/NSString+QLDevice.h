//
//  NSString+QLDevice.h
//  QLCommonUtils
//
//  Created by Paramita on 2019/4/15.
//  Copyright © 2019 Paramita. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (QLDevice)

+ (NSString *)platform;

+ (BOOL)judueIPhonePlatformSupportTouchID;

@end

NS_ASSUME_NONNULL_END
