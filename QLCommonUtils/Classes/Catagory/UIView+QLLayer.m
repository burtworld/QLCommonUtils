//
//  UIView+QLLayer.m
//  QLCommonUtils
//
//  Created by Paramita on 2019/4/9.
//  Copyright © 2019 Paramita. All rights reserved.
//

#import "UIView+QLLayer.h"

@implementation UIView (QLLayer)
//绘制渐变色颜色的方法
- (CAGradientLayer *)getGradualChangingColorFromColor:(UIColor *)fromHexColor toColor:(UIColor *)toHexColor{
    
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.backgroundColor = [UIColor clearColor].CGColor;
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)fromHexColor.CGColor,(__bridge id)toHexColor.CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    //  设置颜色变化点，取值范围 0.0~1.0
    //    gradientLayer.locations = @[@0,@1];
    
    return gradientLayer;
}
@end
