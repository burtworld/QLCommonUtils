//
//  UIView+QLLayer.h
//  QLCommonUtils
//
//  Created by Paramita on 2019/4/9.
//  Copyright © 2019 Paramita. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (QLLayer)
- (CAGradientLayer *)getGradualChangingColorFromColor:(UIColor *)fromHexColor toColor:(UIColor *)toHexColor;
@end

NS_ASSUME_NONNULL_END
