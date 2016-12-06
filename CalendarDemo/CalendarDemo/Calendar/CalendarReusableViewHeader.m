//
//  CalendarReusableViewHeader.m
//  Tools
//
//  Created by Richie on 16/12/5.
//  Copyright © 2016年 Eties. All rights reserved.
//

#import "CalendarReusableViewHeader.h"

#import <Masonry/Masonry.h>
#import "Macro.h"


@implementation CalendarReusableViewHeader


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}
-(void)subViewsCreation
{
    WeakSelf
    self.backgroundColor = [UIColor blueColor];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    _preAction = [[UIButton alloc] init];
    [_preAction setImage:[UIImage imageNamed:@"calendar_pre"] forState:UIControlStateNormal];
    [self addSubview:_preAction];

    _nextAction = [[UIButton alloc] init];
    [_nextAction setImage:[UIImage imageNamed:@"calendar_next"] forState:UIControlStateNormal];
    [self addSubview:_nextAction];
    
    [_preAction addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_nextAction addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.preAction.mas_right);
        make.right.equalTo(weakSelf.nextAction.mas_left);
        make.height.equalTo(weakSelf);
    }];
    
    [_preAction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(weakSelf).with.offset(5);
        make.height.equalTo(weakSelf).with.offset(-10);
        make.width.equalTo(weakSelf.preAction.mas_height);
    }];
    
    [_nextAction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(5);
        make.right.equalTo(weakSelf).with.offset(-5);
        make.height.equalTo(weakSelf).with.offset(-10);
        make.width.equalTo(weakSelf.nextAction.mas_height);
    }];
}

- (void)buttonAction:(UIButton *)sender
{
    if (self.respondClickActionBlock) {
        __block RespondForwardType forwardType;
        if (sender == _preAction) {
            forwardType = RespondForwardTypePre;
        } else if (sender == _nextAction) {
            forwardType = RespondForwardTypeNext;
        }
        self.respondClickActionBlock(forwardType);
    }
}

@end
