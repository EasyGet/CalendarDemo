//
//  CalendarObject.m
//  TNBPatient
//
//  Created by Richie on 16/12/5.
//  Copyright © 2016年 Eties. All rights reserved.
//

#import "CalendarObject.h"
#import "NSDate+CountCategory.h"

@implementation CalendarObject

- (instancetype)initWithDate:(NSDate *)date
{
    if (self = [super init]) {
        _date = date;
        _weekCount = [_date weekCountInMonth];
        _totaldays = [_date daysCountInMonth];
        _firstWeekday = [_date firstDayInMonth];
    }
    return self;
}


- (NSDate *)dateAtIndex:(NSInteger)index
{
    NSInteger firstDay = [_firstWeekday integerValue];
    
    NSInteger day = index - firstDay + 1;
    
    NSInteger maxDay = _totaldays.integerValue;
    
    if (day < 1 || day > maxDay) {
        return nil;
    } else {
       return [_date dateInsameMonthWithDay:day];
    }
}

@end
NSInteger NumberAtIndexFrom(NSInteger firstIndex, NSInteger maxCount, NSInteger index)
{
    NSInteger day = index - firstIndex + 1;
    
    if (day < 1 || day > maxCount) {
        return 0;
    } else {
        return day;
    }
}
