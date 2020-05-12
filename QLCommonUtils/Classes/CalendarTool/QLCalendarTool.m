//
//  MYCalendarTool.m
//  HYCalendar
//
//  Created by why on 15/2/10.
//  Copyright (c) 2015年 nathan. All rights reserved.
//

#import "QLCalendarTool.h"
@implementation SignDateModel

@end


@implementation QLCalendarTool


+ (NSString *)timeStringWithTimestamp:(NSTimeInterval)timestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    
    NSDateComponents *tsComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    NSDateComponents *nowComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]];
    NSInteger tsYear = [tsComponents year];
    NSInteger tsMonth = [tsComponents month];
    NSInteger tsDay = [tsComponents day];
    NSInteger tsHours = [tsComponents hour];
    NSInteger tsMinuts = [tsComponents minute];
    
    NSInteger nowYear = [nowComponents year];
    NSInteger nowMonth = [nowComponents month];
    NSInteger nowDay = [nowComponents day];
    //    NSInteger nowHours = [nowComponents hour];
    
    if (nowYear - tsYear != 0) {
        return [NSString stringWithFormat:@"%zd/%zd/%zd",tsYear,tsMonth,tsDay];
    }
    NSMutableString *string = [NSMutableString new];
    if (nowMonth - tsMonth == 0) {  // 同一月
        NSInteger minDay = nowDay - tsDay;
        if (minDay == 0) {  // 同一天
            
            if (tsHours < 12) {
                [string appendString:@"上午"];
            }else if (tsHours > 12) {
                [string appendString:@"下午"];
                tsHours -= 12;
            }else{
                [string appendString:@"中午"];
            }
            
            [string appendString:@":"];
            [string appendString:[NSString stringWithFormat:@"%02zd:%02zd",tsHours,tsMinuts]];
            
        }else if (minDay == 1) {
            [string appendString:@"昨天"];
            [string appendFormat:@" %zd:%zd",tsHours,tsMinuts];
            
        }else{
            [string appendFormat:@"%zd月%zd日 %zd:%zd",tsMonth,tsDay,tsHours,tsMinuts];
        }
    }else{
        [string appendFormat:@"%zd月%zd日 %zd:%zd",tsMonth,tsDay,tsHours,tsMinuts];
    }
    return [NSString stringWithFormat:@"%@", string];
}

+ (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay) fromDate:date];
    return [components day];
}


+ (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitMonth) fromDate:date];
    return [components month];
}

+ (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear) fromDate:date];
    return [components year];
}

+ (NSInteger)hours:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitHour) fromDate:date];
    return [components hour];
}

+ (NSString *)dayStatus:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitHour) fromDate:date];
    NSInteger hour = [components hour];
    NSString *status = @"";
    if (hour < 11) {
        status = @"早上";
    } else if (hour < 13) {
        status = @"中午";
    } else if (hour < 18) {
        status = @"下午";
    } else if (hour < 24) {
        status = @"晚上";
    }
    return status;
}

//! 第一周第一天的日期
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

+ (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}

+ (NSInteger)numOfWeekInMonth:(NSDate *)date {
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    NSInteger weeks = ceil(daysInOfMonth.length/7.0);
    return weeks;
}

+ (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

+ (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

//! 传入日期，返回日期所在月所有天数
+ (NSArray *)getAllDaysWithDate:(NSDate *)date {
    NSInteger daysInLastMonth = [QLCalendarTool totaldaysInMonth:[QLCalendarTool lastMonth:date]];
    NSInteger daysInThisMonth = [QLCalendarTool totaldaysInMonth:date];
    NSInteger firstWeekday    = [QLCalendarTool firstWeekdayInThisMonth:date];
    NSInteger weeks = [QLCalendarTool numOfWeekInMonth:date];
    NSMutableArray * totalArray = [NSMutableArray array];
    for (int i = 0; i < weeks * 7; i++) {
        SignDateModel * signDate = [[SignDateModel alloc]init];
        NSInteger day = 0;

        if (i < firstWeekday) {
            // 上个月总天数-第一周第一天
            // 属于上个月的天数
            day = daysInLastMonth - firstWeekday + i + 1;
            signDate.dayBeyondMonth = YES;
        }else if (i > firstWeekday + daysInThisMonth - 1){
            // 下个月的天数
            day = i + 1 - firstWeekday - daysInThisMonth;
            signDate.dayBeyondMonth = YES;
            
        }else{
            // 本月天数
            day = i - firstWeekday + 1;
            signDate.dayBeyondMonth = NO;
        }
        signDate.day  = day;
        NSInteger todayIndex = [QLCalendarTool day:date] + firstWeekday - 1;
        
        if (i < todayIndex && i >= firstWeekday) {
            signDate.dayBeforToday = YES;
        }else if(i ==  todayIndex){
            signDate.isToday = YES;
        }
        NSInteger week = i%7;
        signDate.week = week;
        [totalArray addObject:signDate];
    }
    return totalArray;
}



@end
