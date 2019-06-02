//
//  QLHJWaterMarker.h
//  TestProject
//
//  Created by Paramita on 2016/12/5.
//  Copyright © 2016年 Paramita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QLHJWaterMarker : UIImage

//! 默认背景色为白色
+ (UIImage *)waterMakerWithRect:(CGRect)rect Text:(NSArray<NSString *> *)texts ;

//! 默认旋转角度为0
+ (UIImage *)waterMakerWithRect:(CGRect)rect bgColor:(UIColor *)bgColor Text:(NSArray<NSString *> *)texts;

/**
 创建水印

 @param rect 大小
 @param bgColor 背景色
 @param degrees 水印旋转角度
 @param texts 添加的文字
 @return 返回添加水印后的图片
 */
+ (UIImage *)waterMakerWithRect:(CGRect)rect bgColor:(UIColor *)bgColor degres:(CGFloat)degrees Text:(NSArray<NSString *> *)texts;


/**
 根据目标图片制作一个盖水印的图片
 
 @param originalImage 源图片
 @param title 水印文字
 @param markFont 水印文字font(如果不传默认为23)
 @param markColor 水印文字颜色(如果不传递默认为源图片的对比色)
 @return 返回盖水印的图片
 */
+ (UIImage *)getWaterMarkImage:(UIImage *)originalImage andTitle: (NSString *)title andMarkFont: (UIFont *)markFont andMarkColor: (UIColor *)markColor;

+ (UIImage *)getWaterMarkImage:(CGSize )size texts: (NSArray *)texts font: (UIFont *)font textColor: (UIColor *)textColor bgColor:(UIColor *)bgColor;
@end
