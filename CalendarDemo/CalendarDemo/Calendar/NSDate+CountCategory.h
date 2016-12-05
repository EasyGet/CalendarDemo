//
//  NSDate+CountCategory.h
//  TNBPatient
//
//  Created by Richie on 16/12/5.
//  Copyright © 2016年 Eties. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CountCategory)


/**
 <#Description#>

 @return <#return value description#>
 */
- (NSNumber *)weekCountInMonth;

/**
 <#Description#>

 @return <#return value description#>
 */
- (NSNumber *)daysCountInMonth;

/**
 <#Description#>

 @return <#return value description#>
 */
- (NSNumber *)firstDayInMonth;


/**
 <#Description#>

 @return <#return value description#>
 */
- (NSString *)cacheDescKey;


/**
 下一个月

 @return 下月
 */
- (NSDate *)nextMonth;


/**
 上一个月
 
 @return 上月
 */
- (NSDate *)preMonth;


/**
 判断是否为一天

 @param date 要比较的日期

 @return 如果是同一天返回true 如果不是返回false
 */
- (BOOL)isSameDayWith:(NSDate *)date;

/**
 在同一个月的日期

 @param day 日期

 @return 日期
 */
- (NSDate *)dateInsameMonthWithDay:(NSInteger)day;

@end
