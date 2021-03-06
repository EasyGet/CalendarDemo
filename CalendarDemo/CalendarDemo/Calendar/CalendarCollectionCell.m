//
//  CalendarCollectionCell.m
//  Tools
//
//  Created by Richie on 16/12/5.
//  Copyright © 2016年 Eties. All rights reserved.
//

#import "CalendarCollectionCell.h"
#import <Masonry/Masonry.h>
#import "CalendarMacro.h"

@implementation CalendarCollectionCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
//    self.layer.cornerRadius = CGRectGetWidth(rect) / 2.0;
    
    
    
}

*/
- (void)subviewsCreation
{
    WeakSelf
    self.backgroundColor = [UIColor whiteColor];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @" ";
    [self addSubview:_titleLabel];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_titleLabel sizeToFit];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.centerY.equalTo(weakSelf);
        make.height.mas_equalTo(CGRectGetHeight(weakSelf.titleLabel.bounds));
    }];
}

@end
