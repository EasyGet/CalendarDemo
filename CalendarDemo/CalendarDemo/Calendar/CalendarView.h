//
//  CalendarView.h
//  Tools
//
//  Created by Richie on 16/12/5.
//  Copyright © 2016年 Eties. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalendarView;
typedef void(^CalendarHeightBlock)(CalendarView *calendarView, CGFloat height);
typedef void(^CalendarClickBlock)(CalendarView *calendarView, NSDate *date, BOOL shouldRespond);

typedef void(^CalendarSwipeBlock)(CalendarView *calendarView, UISwipeGestureRecognizerDirection direction);

@interface CalendarView : UIView


/**
 日期
 */
@property (nonatomic, strong) NSDate *date;


/**
 高度如果发生调整
 */
@property (nonatomic, copy) CalendarHeightBlock heightBlock;

/**
 点击时间 获取点击的时间
 */
@property (nonatomic, copy) CalendarClickBlock clickBlock;


/**
 手势滑动时间
 */
@property (nonatomic, copy) CalendarSwipeBlock swipeBlock;


/**
 上一个月
 */
- (void)datePreviousMonth;


/**
 下一个月
 */
- (void)dateNextMonth;

@end
