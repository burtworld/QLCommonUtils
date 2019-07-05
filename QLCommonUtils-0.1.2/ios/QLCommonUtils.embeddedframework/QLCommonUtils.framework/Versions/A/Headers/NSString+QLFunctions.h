//
//  NSString+Functions.h
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/12.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - 字体
#define FONT_28                         [UIFont systemFontOfSize:28.0f]
#define FONT_24                         [UIFont systemFontOfSize:24.0f]
#define FONT_20                         [UIFont systemFontOfSize:20.0f]
#define FONT_16                         [UIFont systemFontOfSize:16.0f]
#define FONT_14                         [UIFont systemFontOfSize:14.0f]
#define FONT_12                         [UIFont systemFontOfSize:12.0f]
#define FONT_10                         [UIFont systemFontOfSize:10.0f]

#pragma mark - 根据版本获取字体大小
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define QLHJ_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;

#define QLHJ_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;

#else

#define QLHJ_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;

#define QLHJ_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif

@interface NSString (QLFunctions)
- (CGFloat)getWidthWithFont:(UIFont *)font andHeight:(CGFloat)heigth;
- (CGFloat)getHeightWithFont:(UIFont *)font andWidth:(CGFloat)width;
- (NSString *)subStringWithFont:(UIFont *)font width:(CGFloat)width;


@end

#pragma mark - NSString (Valid)
@interface NSString (Valid)
- (BOOL)isValidMoney;
- (BOOL)isValidMobileTel;
- (BOOL)isValidateEmail;
- (NSString *)getValidMobileTel;
@end

#pragma mark - NSString (TimeAndDate)
@interface NSString (TimeAndDate)
+ (NSString *)formatterStringWithDate:(NSDate *)date format:(NSString *)formate;
- (NSString *)converTimestampToDate:(NSString *)formate;
- (NSDate *)converStringToDate;

- (NSTimeInterval)getTimestampFromTimeStrWithFormat:(NSString *)format;
+ (NSString *)getNowTimeString;
+ (NSString *)getDateString;
+ (NSString *)getNowTimeString2;
- (NSTimeInterval)getTimeIntervalFormNow;
- (NSString *)dataFormNow:(NSTimeInterval)time formate:(NSString *)timeFormate;
+ (NSString *)getYesterDayString;
- (NSString *)getTimesBeforeNow;
@end




@interface NSString (RandomString)
+ (NSString *)creatRandomString:(int)length;
@end


@interface NSString (MaskTel)
- (NSString *)maskTel;
@end

@interface NSString (GUID)
+ (NSString *)createGUID;
@end
