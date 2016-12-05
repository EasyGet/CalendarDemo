//
//  NSDate+CountCategory.m
//  TNBPatient
//
//  Created by Richie on 16/12/5.
//  Copyright © 2016年 Eties. All rights reserved.
//

#import "NSDate+CountCategory.h"


static NSDateFormatter *dateFormatter = nil;

@implementation NSDate (CountCategory)

- (NSNumber *)daysCountInMonth
{
    NSCalendarUnit dayUnit;
    NSCalendarUnit monthUnit;
#if defined(__IPHONE_8_0) || defined(__MAC_10_10)
    
    dayUnit = NSCalendarUnitDay;
    monthUnit = NSCalendarUnitMonth;
#else
    dayUnit = NSDayCalendarUnit;
    monthUnit = NSMonthCalendarUnit;
#endif
    
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:dayUnit inUnit:monthUnit forDate:self];
    return @(daysInLastMonth.length);
}

- (NSNumber *)weekCountInMonth
{
    NSCalendarUnit weekdayUnit;
    NSCalendarUnit monthUnit;
#if defined(__IPHONE_8_0) || defined(__MAC_10_10)
    weekdayUnit = NSCalendarUnitWeekOfMonth;
    monthUnit = NSCalendarUnitMonth;
#else
    weekdayUnit = NSWeekdayCalendarUnit;
    monthUnit = NSMonthCalendarUnit;
#endif
    
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:weekdayUnit inUnit:monthUnit forDate:self];
    return @(daysInLastMonth.length);
}


- (NSNumber *)firstDayInMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    
#if defined(__IPHONE_8_0) || defined(__MAC_10_10)
    NSUInteger flags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    NSUInteger weekFlag = NSCalendarUnitWeekday;
    NSUInteger monthFlag = NSCalendarUnitWeekOfMonth;
#else
    NSUInteger flags = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
    NSUInteger weekFlag = NSWeekCalendarUnit;
    NSUInteger monthFlag = NSMonthCalendarUnit;
#endif
    
    NSDateComponents *comp = [calendar components:flags fromDate:self];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:weekFlag inUnit:monthFlag forDate:firstDayOfMonthDate];
    return @(firstWeekday - 1);
}


- (NSString *)cacheDescKey
{
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"YYYY-MM";
    }
    return [dateFormatter stringFromDate:self];
}


- (NSDate *)nextMonth
{
    NSUInteger flags;
#if defined(__IPHONE_8_0) || defined(__MAC_10_10)
    flags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
#else
    flags = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
#endif
    static NSDateComponents *dateComponents = nil;
    
    if (!dateComponents) {
        dateComponents = [[NSDateComponents alloc] init];
        dateComponents.year = 0;
        dateComponents.month = 1;
        dateComponents.day = 0;
    }
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:flags];
}

- (NSDate *)preMonth
{
    NSUInteger flags;
#if defined(__IPHONE_8_0) || defined(__MAC_10_10)
    flags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
#else
    flags = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
#endif
    static NSDateComponents *dateComponents = nil;
    
    if (!dateComponents) {
        dateComponents = [[NSDateComponents alloc] init];
        dateComponents.year = 0;
        dateComponents.month = -1;
        dateComponents.day = 0;
    }
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:flags];
}

- (BOOL)isSameDayWith:(NSDate *)date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSCalendarUnit flags;
#if defined(__IPHONE_8_0) || defined(__MAC_10_10)
    flags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
#else
    flags = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
#endif
    
    NSDateComponents* components1 = [calendar components:flags fromDate:self];
    NSDateComponents* components2 = [calendar components:flags fromDate:date];
    
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day]);
}

- (NSDate *)dateInsameMonthWithDay:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSCalendarUnit flag;
    
#if defined(__IPHONE_8_0) || defined(__MAC_10_10)
    flag = (NSCalendarUnitYear | NSCalendarUnitMonth);
#else
    flag = NSYearCalendarUnit | NSMonthCalendarUnit;
#endif
    
    NSDateComponents *comp = [calendar components:flag fromDate:self];
    comp.day = day;
    [comp setHour:0];
    [comp setMinute:0];
    [comp setSecond:0];
    [comp setNanosecond:0];
    return [calendar dateFromComponents:comp];
}
@end
