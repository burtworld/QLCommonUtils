//
//  UIView+Animator.m
//  QLCommonUtils
//
//  Created by Paramita on 2019/4/19.
//  Copyright © 2019 Paramita. All rights reserved.
//

#import "UIView+Animator.h"

@implementation UIView (Animator)
#pragma CATransition动画实现

- (CATransition *) transitionWithType:(NSString *) type WithSubtype:(NSString *)subtype duraion:(CGFloat)duration removedOnCompletion:(BOOL)remove{
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.type = type;
    if (subtype != nil) {
        animation.subtype = subtype;
    }
    animation.removedOnCompletion = remove;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.layer addAnimation:animation forKey:@"animation"];
    return animation;
}

- (CATransition *) transitionWithType:(NSString *) type duraion:(CGFloat)duration{
    CATransition *animator = [self transitionWithType:type WithSubtype:nil duraion:duration removedOnCompletion:YES];
    return animator;
}

- (CABasicAnimation *)shake {
    CABasicAnimation*animation = [self shakeWithDuration:0.1 count:4];
    return animation;
}

- (CABasicAnimation *)shakeWithDuration:(CGFloat)duration count:(NSInteger)count {
    CALayer*viewLayer=[self layer];
    CGPoint position = viewLayer.position;
    CGPoint x = CGPointMake(position.x+10, position.y);
    CGPoint y =CGPointMake(position.x-10, position.y);
    CABasicAnimation*animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    // 持续时间
    animation.duration = duration;
    // 抖动次数
    animation.repeatCount = count;
    
    //反极性
    animation.autoreverses=YES;
    animation.removedOnCompletion = YES;
    [viewLayer addAnimation:animation forKey:@"shakeNimation"];
    return animation;
}
@end
