//
//  UIColor+QLColor.h
//  QLCommonUtils
//
//  Created by Paramita on 2018/2/1.
//  Copyright © 2018年 Paramita. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COLOR_OF_HEX(value) COLOR_OF_R_HEX(value,1.0)

#define COLOR_OF_R_HEX(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

@interface UIColor (QLColor)
+ (UIColor *)colorFormString:(NSString *)hexString;
+ (UIColor *)randomColorWithName:(NSString *)name;
+ (UIColor *)randomColor;
@end
