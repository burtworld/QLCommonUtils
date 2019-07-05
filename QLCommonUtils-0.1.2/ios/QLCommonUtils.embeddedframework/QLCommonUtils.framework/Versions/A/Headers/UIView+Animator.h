//
//  UIView+Animator.h
//  QLCommonUtils
//
//  Created by Paramita on 2019/4/19.
//  Copyright © 2019 Paramita. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Animator)

- (CATransition *) transitionWithType:(NSString *) type WithSubtype:(NSString *)subtype duraion:(CGFloat)duration removedOnCompletion:(BOOL)remove;
- (CATransition *) transitionWithType:(NSString *) type duraion:(CGFloat)duration;

- (CABasicAnimation *)shake;
- (CABasicAnimation *)shakeWithDuration:(CGFloat)duration count:(NSInteger)count;
@end

