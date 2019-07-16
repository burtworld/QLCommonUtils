//
//  NSString+Functions.m
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/12.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import "NSString+QLFunctions.h"


@implementation NSString (QLFunctions)
- (CGFloat)getWidthWithFont:(UIFont *)font andHeight:(CGFloat)heigth {
    CGSize size = QLHJ_MULTILINE_TEXTSIZE(self, font, CGSizeMake(CGFLOAT_MAX, heigth), QLHJLineBreakModeByCharWrapping);
    return size.width;
}

- (CGFloat)getHeightWithFont:(UIFont *)font andWidth:(CGFloat)width {
    CGSize size = QLHJ_MULTILINE_TEXTSIZE(self, font, CGSizeMake(width, CGFLOAT_MAX), QLHJLineBreakModeByCharWrapping);
    return size.height;
}

- (NSString *)subStringWithFont:(UIFont *)font width:(CGFloat)width {
    NSString * subStr = self;
    NSUInteger index = self.length;
    CGFloat strWidth = [subStr getWidthWithFont:font andHeight:font.pointSize + 2];
    while (strWidth > width) {
        subStr = [self substringToIndex:index];
        strWidth = [subStr getWidthWithFont:font andHeight:font.pointSize + 2];
        index--;
    }
    return subStr;
}

- (NSString *)paddingWithSymbol:(NSString *)symbol left:(BOOL)left lenth:(int)lenth{
    NSString * retuStr = self;
    if (retuStr.length < lenth) {
        if (left) {
            NSString * x = @"";
            for (int i =0; i<lenth - retuStr.length; i++) {
                x = [x stringByAppendingString:symbol];
            }
            retuStr = [x stringByAppendingString:retuStr];
        }else{
            retuStr = [retuStr stringByPaddingToLength:lenth withString:symbol startingAtIndex:0];
        }
    }
    return retuStr;
}
- (NSString *)paddingWithSymbol2:(char *)symbol left:(BOOL)left lenth:(int)lenth{
//    const char *src = [self UTF8String];
//    char *dst = malloc(lenth);
//    memset(dst, symbol, lenth);
//    memcpy(dst, src, lenth);
    return nil;
}

@end


#pragma mark - NSString (Valid)
@implementation NSString (Valid)
- (BOOL)isValidMoney {
    NSString * money = [self copy];
    
    NSString *moneyRegex = @"^[1-9]{1}\\d*(\\.\\d{1,2})?$";
    NSPredicate *moneyTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",moneyRegex];
    return [moneyTest evaluateWithObject:money];
}

-(BOOL)isValidMobileTel{
    NSString * mobile = [self copy];
    if ([mobile hasPrefix:@"+86"]) {
        mobile = [mobile substringFromIndex:3];
    }
    if ([mobile hasPrefix:@" "]) {
        mobile = [mobile substringFromIndex:1];
    }
    if ([mobile rangeOfString:@"-"].location != NSNotFound) {
        mobile = [mobile stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    if ([mobile rangeOfString:@" "].location != NSNotFound) {
        mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    if ([mobile rangeOfString:@" "].location != NSNotFound) {
        mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//! 邮箱验证 MODIFIED BY HELENSONG
-(BOOL)isValidateEmail
{
    NSString * email = [self copy];
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(NSString *)getValidMobileTel{
    NSString * mobile = [self copy];
    if ([mobile hasPrefix:@"+86"]) {
        mobile = [mobile substringFromIndex:3];
    }
    if ([mobile hasPrefix:@" "]) {
        mobile = [mobile substringFromIndex:1];
    }
    if ([mobile rangeOfString:@"-"].location != NSNotFound) {
        mobile = [mobile stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    if ([mobile rangeOfString:@" "].location != NSNotFound) {
        mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    if ([mobile rangeOfString:@" "].location != NSNotFound) {
        mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return mobile;
}
@end

#pragma mark - NSString (TimeAndDate)
@implementation NSString (TimeAndDate)
//!返回字符串类型的时间 formate：时间格式
+ (NSString *)formatterStringWithDate:(NSDate *)date format:(NSString *)formate{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formate];
    NSString * dateStr = [formatter stringFromDate:date];
    return dateStr;
}
//!将时间字符串转化为时间戳 formate：时间格式
- (NSTimeInterval)getTimestampFromTimeStrWithFormat:(NSString *)format {
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSDate * date = [formatter dateFromString:self];
    NSTimeInterval interval = [date timeIntervalSince1970];
    return interval*1000;
}

//!将时间戳转化为时间字符串 formate：时间格式
- (NSString *)converTimestampToDate:(NSString *)formate {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formate];
    NSString * dateStr = [formatter stringFromDate:confromTimesp];
    return dateStr;
}

-(NSDate *)converStringToDate{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [formatter dateFromString:self];
    return date;
}

+ (NSString *)getNowTimeString {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * nowTime = [formatter stringFromDate:[NSDate date]];
    
    return nowTime;
}

+ (NSString *)getNowTimeString2 {
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString * nowTime = [formatter stringFromDate:[NSDate date]];
    
    return nowTime;
}

+ (NSString *)getDateString{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * nowTime = [formatter stringFromDate:[NSDate date]];
    return nowTime;
}

- (NSTimeInterval)getTimeIntervalFormNow {
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startD = [NSDate date];
    NSDate *endD = [date dateFromString:self];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    return value;
}

- (NSString *)dataFormNow:(NSTimeInterval)time formate:(NSString *)timeFormate {
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:timeFormate];
    NSDate * date = [formatter dateFromString:self];
    NSDate * afterDate = [date dateByAddingTimeInterval:time];
    NSString * nowTime = [formatter stringFromDate:afterDate];
    
    return nowTime;
}

+ (NSString *)getYesterDayString{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * nowTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-24*60*60]];
    return nowTime;
}

- (NSString *)getTimesBeforeNow{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:self];
    NSTimeInterval interval = [date timeIntervalSinceNow];
    interval = -interval;
    long temp = 0;
    NSString *result;
    if (interval < 60) {
        result = [NSString stringWithFormat:@"%d秒前",(int)interval];
    }
    else if((temp = interval/60) <60){
        result = [NSString stringWithFormat:@"%d分钟前",(int)temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%d小时前",(int)temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%d天前",(int)temp];
    }
    
    else if((temp = temp/30) < 6){
        result = [NSString stringWithFormat:@"%d月前",(int)temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"半年前"];
    }
    
    return  result;
}

+ (NSString *)getDateStatus {
//    NSDate *date = [NSDate date];
    
    return nil;
}

@end




@implementation NSString (RandomString)

+ (NSString *)creatRandomString:(int)length {
    // 33~126
    char data[length];
    for (int i = 0; i < length; i++) {
        int random = (int)(33 + (arc4random() % (126 - 33 + 1)));
        data[i] = random;
    }
    return [[NSString alloc] initWithBytes:data length:length encoding:NSUTF8StringEncoding];
}

@end

@implementation NSString (MaskTel)

- (NSString *)maskTel {
    
    if (self.length >= 11) {
        NSString *tel = [self copy];
        NSString *starStr = [tel substringWithRange:NSMakeRange(3, 4)];
        tel = [tel stringByReplacingOccurrencesOfString:starStr withString:@"****"];
        return tel;
    }
    return self;
}

@end

@implementation NSString (GUID)
+ (NSString *)createGUID {
    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *cfuuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
    cfuuidString = [cfuuidString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return cfuuidString;
}
@end
