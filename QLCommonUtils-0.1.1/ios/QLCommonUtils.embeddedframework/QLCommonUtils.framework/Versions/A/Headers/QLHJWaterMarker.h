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
+ (UIImage *)waterMakerWithRect:(CGRect)rect Text:(NSArray<NSString *> *)texts;

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


@end
