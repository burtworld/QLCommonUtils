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
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    
    CGContextFillRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    UIFont *font = [UIFont systemFontOfSize:12.0f];
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


@end
