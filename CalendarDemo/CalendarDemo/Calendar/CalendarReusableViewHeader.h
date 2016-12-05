//
//  CalendarReusableViewHeader.h
//  Tools
//
//  Created by Richie on 16/12/5.
//  Copyright © 2016年 Eties. All rights reserved.
//

#import "CollectionReusableView.h"

typedef NS_ENUM(NSInteger, RespondForwardType) {
    RespondForwardTypeDefault,
    RespondForwardTypePre,
    RespondForwardTypeNext
};


/**
 @param forwardType 是前进还是后退
 */
typedef void(^RespondClickBlock)(RespondForwardType forwardType);
@interface CalendarReusableViewHeader : CollectionReusableView
/**
 标题
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 前一页
 */
@property (nonatomic, strong) UIButton *preAction;

/**
 后一页
 */
@property (nonatomic, strong) UIButton *nextAction;


/**
 相应操作
 */
@property (nonatomic, copy) RespondClickBlock respondClickActionBlock;

@end
