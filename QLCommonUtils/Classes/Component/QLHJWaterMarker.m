//
//  QLHJWaterMarker.m
//  TestProject
//
//  Created by Paramita on 2016/12/5.
//  Copyright © 2016年 Paramita. All rights reserved.
//

#import "QLHJWaterMarker.h"
#import "QLHJAPPManager.h"
#import "NSString+QLFunctions.h"
#import "UIImage+QLExtensions.h"
#import "UIColor+QLColor.h"
@implementation QLHJWaterMarker

+ (UIImage *)waterMakerWithRect:(CGRect)rect Text:(NSArray<NSString *>*)texts{
    
    return nil;
}

+ (UIImage *)waterMakerWithRect:(CGRect)rect bgColor:(UIColor *)bgColor Text:(NSArray<NSString *>*)texts{
    if (!texts.count) {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < texts.count; i++) {
        [array addObject:texts[i]];
        [array addObject:@"　　　　"];
    }
    // 将数组的第一个拼到数组的最后一个
    if (!array.count) {
        return nil;
    }
    [array addObject:array[0]];
    
    /* 对文字进行排版
     1.计算几行几列
     2.计算间隔
     */
    // 水印间隔
    CGFloat intervalH = 100;
    // 行数
    NSInteger lines = floor(rect.size.height/intervalH);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    
    CGContextFillRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    UIFont *font = [UIFont systemFontOfSize:14.0f];
    NSDictionary *dictionary = @{
                                 NSForegroundColorAttributeName: [COLOR_OF_HEX(0x888888) colorWithAlphaComponent:50/255.0],
//                                 NSForegroundColorAttributeName: COLOR_OF_HEX(0x888888),
                                 NSFontAttributeName: font
                                 };
    for (int line = 0; line < lines; line++) {
        CGFloat width = 0;
        while (width < rect.size.width) {
            for (int column = 0; column < array.count - 1; column++) {
                NSString *text2 = array[column + line%2];

                CGFloat strWidth = [text2 getWidthWithFont:font andHeight:20];
                CGRect frame = CGRectMake(width, line*intervalH, strWidth, 20);
                width += strWidth;
                [text2 drawInRect:frame withAttributes:dictionary];
            }
        }
    }
    UIImage *watermarkImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return watermarkImage;
}

+ (UIImage *)waterMakerWithRect:(CGRect)rect bgColor:(UIColor *)bgColor degres:(CGFloat)degrees Text:(NSArray<NSString *> *)texts {
    UIImage * img = [self waterMakerWithRect:rect bgColor:bgColor Text:texts];
    UIImage *rotateImg = [img imageRotatedByDegrees:degrees];
    return rotateImg;
//    return img;
}


#define HORIZONTAL_SPACE    50//水平间距
#define VERTICAL_SPACE      80//竖直间距


+ (UIImage *)getWaterMarkImage:(UIImage *)originalImage andTitle: (NSString *)title andMarkFont: (UIFont *)markFont andMarkColor: (UIColor *)markColor {
    
    UIFont *font = markFont;
    if (font == nil) {
        font = [UIFont systemFontOfSize:12.0f];
    }
    UIColor *color = markColor;
    if (color == nil) {
        color = [UIColor clearColor];
    }
    //原始image的宽高
    CGFloat viewWidth = originalImage.size.width;
    CGFloat viewHeight = originalImage.size.height;
    //为了防止图片失真，绘制区域宽高和原始图片宽高一样
    UIGraphicsBeginImageContext(CGSizeMake(viewWidth, viewHeight));
    //先将原始image绘制上
    [originalImage drawInRect:CGRectMake(0, 0, viewWidth, viewHeight)];
    //sqrtLength：原始image的对角线length。在水印旋转矩阵中只要矩阵的宽高是原始image的对角线长度，无论旋转多少度都不会有空白。
    CGFloat sqrtLength = sqrt(viewWidth*viewWidth + viewHeight*viewHeight);
    //文字的属性
    NSDictionary *attr = @{
                           //设置字体大小
                           NSFontAttributeName: font,
                           //设置文字颜色
                           NSForegroundColorAttributeName :color,
                           };
    NSString* mark = title;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:mark attributes:attr];
    //绘制文字的宽高
    CGFloat strWidth = attrStr.size.width;
    CGFloat strHeight = attrStr.size.height;
    
    //开始旋转上下文矩阵，绘制水印文字
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //将绘制原点（0，0）调整到源image的中心
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(viewWidth/2, viewHeight/2));
    //以绘制原点为中心旋转
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(-10.0f * M_PI / 180));
    //将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-viewWidth/2, -viewHeight/2));
    
    //计算需要绘制的列数和行数
    int horCount = sqrtLength / (strWidth + HORIZONTAL_SPACE) + 1;
    int verCount = sqrtLength / (strHeight + VERTICAL_SPACE) + 1;
    
    //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
    CGFloat orignX = -(sqrtLength-viewWidth)/2;
    CGFloat orignY = -(sqrtLength-viewHeight)/2;
    
    //在每列绘制时X坐标叠加
    CGFloat tempOrignX = orignX;
    //在每行绘制时Y坐标叠加
    CGFloat tempOrignY = orignY;
    for (int i = 0; i < horCount * verCount; i++) {
        [mark drawInRect:CGRectMake(tempOrignX, tempOrignY, strWidth, strHeight) withAttributes:attr];
        if (i % horCount == 0 && i != 0) {
            tempOrignX = orignX;
            tempOrignY += (strHeight + VERTICAL_SPACE);
        }else{
            tempOrignX += (strWidth + HORIZONTAL_SPACE);
        }
    }
    //根据上下文制作成图片
    UIImage *finalImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGContextRestoreGState(context);
    return finalImg;
}


+ (UIImage *)getWaterMarkImage:(CGSize )size texts: (NSArray *)texts font: (UIFont *)font textColor: (UIColor *)textColor bgColor:(UIColor *)bgColor {
    
    if (font == nil) {
        font = [UIFont systemFontOfSize:12.0f];
    }
    if (textColor == nil) {
        textColor = [UIColor clearColor];
    }
    if (bgColor == nil) {
        bgColor = [UIColor clearColor];
    }
    //原始image的宽高
    CGFloat viewWidth = size.width;
    CGFloat viewHeight =size.height;
    //为了防止图片失真，绘制区域宽高和原始图片宽高一样
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);

    //sqrtLength：原始image的对角线length。在水印旋转矩阵中只要矩阵的宽高是原始image的对角线长度，无论旋转多少度都不会有空白。
    CGFloat sqrtLength = sqrt(viewWidth*viewWidth + viewHeight*viewHeight);
    //文字的属性
    NSDictionary *attr = @{
                           //设置字体大小
                           NSFontAttributeName: font,
                           //设置文字颜色
                           NSForegroundColorAttributeName :textColor,
                           };
    NSString* mark = [self getMarkTextWithArray:texts];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:mark attributes:attr];
    //绘制文字的宽高
    CGFloat strWidth = attrStr.size.width;
    CGFloat strHeight = attrStr.size.height;
    
    //开始旋转上下文矩阵，绘制水印文字
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    
    //将绘制原点（0，0）调整到源image的中心
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(viewWidth/2, viewHeight/2));
    //以绘制原点为中心旋转
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(-10.0f * M_PI / 180));
    //将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-viewWidth/2, -viewHeight/2));
    
    //计算需要绘制的列数和行数
    int horCount = sqrtLength / (strWidth + HORIZONTAL_SPACE) + 1;
    int verCount = sqrtLength / (strHeight + VERTICAL_SPACE) + 1;
    
    //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
    CGFloat orignX = -(sqrtLength-viewWidth)/2;
    CGFloat orignY = -(sqrtLength-viewHeight)/2;
    
    //在每列绘制时X坐标叠加
    CGFloat tempOrignX = orignX;
    //在每行绘制时Y坐标叠加
    CGFloat tempOrignY = orignY;
    for (int i = 0; i < horCount * verCount; i++) {
        [mark drawInRect:CGRectMake(tempOrignX, tempOrignY, strWidth, strHeight) withAttributes:attr];
        if (i % horCount == 0 && i != 0) {
            tempOrignX = orignX;
            tempOrignY += (strHeight + VERTICAL_SPACE);
        }else{
            tempOrignX += (strWidth + HORIZONTAL_SPACE);
        }
    }
    //根据上下文制作成图片
    UIImage *finalImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGContextRestoreGState(context);
    return finalImg;
}

+ (NSString *)getMarkTextWithArray:(NSArray *)texts {
    if (!texts.count) {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < texts.count; i++) {
        [array addObject:texts[i]];
        [array addObject:@"　　　"];
    }
    // 将数组的第一个拼到数组的最后一个
    if (!array.count) {
        return nil;
    }
    return [array componentsJoinedByString:@""];
}

@end
