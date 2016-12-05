//
//  CollectionReusableView.m
//  Tools
//
//  Created by Richie on 16/12/5.
//  Copyright © 2016年 Eties. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self subViewsCreation];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self subViewsCreation];
    }
    return self;
}

- (NSString *)cellIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)subViewsCreation
{
    
}

@end
