//
//  CalendarObject.h
//  TNBPatient
//
//  Created by Richie on 16/12/5.
//  Copyright © 2016年 Eties. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 <#Description#>

 @param firstIndex 1开始的位置index (可以是0)
 @param maxCount   最大的个数
 @param index      目标index

 @return index位置上的数字
 */
extern NSInteger NumberAtIndexFrom(NSInteger firstIndex, NSInteger maxCount, NSInteger index);



@interface CalendarObject : NSObject


/**
 
 */
@property (nonatomic, strong) NSDate *date;

/**
 第一天
 */
@property (nonatomic, strong) NSNumber *firstWeekday;


/**
 一共多少天
 */
@property (nonatomic, strong) NSNumber *totaldays;


/**
 有多少周
 */
@property (nonatomic, strong) NSNumber *weekCount;



/**
 init

 @param date 参数

 @return 创建对象
 */
- (instancetype)initWithDate:(NSDate *)date;


- (NSDate *)dateAtIndex:(NSInteger)index;


@end
