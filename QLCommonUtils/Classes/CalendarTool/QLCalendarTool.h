//
//  MYCalendarTool.h
//  HYCalendar
//
//  Created by why on 15/2/10.
//  Copyright (c) 2015年 nathan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignDateModel : NSObject
@property (assign, nonatomic) BOOL isToday;
@property (assign, nonatomic) BOOL isSigned;
//! 本月无效日期
@property (assign, nonatomic) BOOL dayBeyondMonth;
//! 今天以前的日期
@property (assign, nonatomic) BOOL dayBeforToday;
//! 周几
@property (assign ,nonatomic) NSInteger week;
//! 日期
@property (assign, nonatomic) NSInteger day;
@end


@interface QLCalendarTool : NSObject
//! 传入带有毫秒数的时间戳，计算出时间串
+ (NSString *)timeStringWithTimestamp:(NSTimeInterval)timestamp;

+ (NSInteger)day:(NSDate *)date;
+ (NSInteger)month:(NSDate *)date;
+ (NSInteger)year:(NSDate *)date;
+ (NSInteger)hours:(NSDate *)date;
+ (NSString *)dayStatus:(NSDate *)date;


+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
+ (NSInteger)totaldaysInMonth:(NSDate *)date;

+ (NSInteger)numOfWeekInMonth:(NSDate *)date;

+ (NSDate *)lastMonth:(NSDate *)date;
+ (NSDate*)nextMonth:(NSDate *)date;


+ (NSArray *)getAllDaysWithDate:(NSDate *)date;
@end
