//
//  UIImage+Extensions.h
//  VCard
//
//  Created by ZAK on 14-1-20.
//  Copyright (c) 2014年 Maya Software. All rights reserved.
//

#import <UIKit/UIKit.h>

//CGFloat DegreesToRadians(CGFloat degrees);

//CGFloat RadiansToDegrees(CGFloat radians);

@interface UIImage (QLExtensions)

- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByZAKScalingProportionallyToSize:(CGSize)targetSize;  //add by ZAK
- (CGRect)fitRectWithDisplayRect:(CGRect)targetRect; //add by ZAK
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;
- (UIImage *) imageWithBackgroundColor:(UIColor *)bgColor
                           shadeAlpha1:(CGFloat)alpha1
                           shadeAlpha2:(CGFloat)alpha2
                           shadeAlpha3:(CGFloat)alpha3
                           shadowColor:(UIColor *)shadowColor
                          shadowOffset:(CGSize)shadowOffset
                            shadowBlur:(CGFloat)shadowBlur;
- (UIImage *)imageWithShadowColor:(UIColor *)shadowColor
                     shadowOffset:(CGSize)shadowOffset
                       shadowBlur:(CGFloat)shadowBlur;
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

///***************** by paramita *********************
/**
 * 根据颜色获得图片
 * @param color 颜色
 * @param size 图片大小
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

//! 当前屏幕
+ (UIImage *)currentScreenImg ;


+ (UIImage *)getImageFromBundle:(NSString *)bundel name:(NSString *)name ;

+ (UIImage *)combinImageInSize:(CGSize)size array:(NSArray<UIImage *>*)imgs;

- (NSData *)compressWithMaxLength:(NSUInteger)maxLength;
@end
