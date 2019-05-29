//
//  NSTimer+Function.h
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/21.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (QLFunction)
- (void)pauseTimer;
- (void)resumeTimer;
- (void)beginToRun;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
