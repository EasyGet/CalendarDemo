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
 所在月份里面有几周

 @return 周数
 */
- (NSNumber *)weekCountInMonth;

/**
 所在月份有多少天

 @return 天数
 */
- (NSNumber *)daysCountInMonth;

/**
 所在月份的第一天

 @return 1日所在的索引
 */
- (NSNumber *)firstDayInMonth;


/**
 所在月份对应的cache中的key

 @return 根据实际需要来处理
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
