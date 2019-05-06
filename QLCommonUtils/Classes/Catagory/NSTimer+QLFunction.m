//
//  NSTimer+Function.m
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/21.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import "NSTimer+QLFunction.h"

@implementation NSTimer (QLFunction)
-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}

- (void)beginToRun {
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate distantPast]];//开启
}

-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}
@end
