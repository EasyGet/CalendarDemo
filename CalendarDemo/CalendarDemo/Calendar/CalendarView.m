//
//  CalendarView.m
//  Tools
//
//  Created by Richie on 16/12/5.
//  Copyright © 2016年 Eties. All rights reserved.
//

#import "CalendarView.h"

#import "CalendarObject.h"
#import "CalendarCollectionCell.h"
#import "NSDate+CountCategory.h"
#import "CalendarReusableViewHeader.h"

#import <Masonry/Masonry.h>

@interface CalendarView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;


/**
 星期几 标题 数组
 */
@property (nonatomic, strong) NSArray *weekDayDescs;


/**
 缓存
 */
@property (nonatomic, strong) NSCache *cache;


/**
 适配的model
 */
@property (nonatomic, strong) CalendarObject *calendarObject;

@end

@implementation CalendarView

@synthesize date = _date;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self subviewsCreation];
    }
    return self;
}


/**
 创建subview 添加手势 初始化数组
 */
- (void)subviewsCreation
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    
    [self addSubview:_collectionView];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[CalendarCollectionCell class] forCellWithReuseIdentifier:@"CalendarCollectionCell"];
    [_collectionView registerClass:[CalendarReusableViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self);
    }];
    
    _weekDayDescs = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    
    [self addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGestureRecognizer:)]];
    
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGestureRecognizer:)];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:left];
    UISwipeGestureRecognizer *up = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGestureRecognizer:)];
    up.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:up];
    
    UISwipeGestureRecognizer *down = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGestureRecognizer:)];
    down.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:down];
}

#pragma mark -  Property Method
- (NSCache *)cache
{
    if (!_cache) {
        _cache = [[NSCache alloc] init];
    }
    return _cache;
}


/**
 如果date 没有设置的话 默认的取今天的日期

 @return 返回date
 */
- (NSDate *)date
{
    if (!_date) {
        _date = [NSDate date];
    }
    return _date;
}


/**
 设置date
 
 同时初始化model 数据
 
 @param date 需要设置的日期
 */
- (void)setDate:(NSDate *)date
{
    _date = date;
    NSString *dateDesc = [date cacheDescKey];
    CalendarObject *object = [self.cache objectForKey:dateDesc];
    if (!object) {
        object = [[CalendarObject alloc] initWithDate:_date];
        [self.cache setObject:object forKey:dateDesc];
    }
    _calendarObject = object;
}

- (CalendarObject *)calendarObject
{
    if (!_calendarObject) {
        NSString *dateDesc = [self.date cacheDescKey];
        CalendarObject *object = [self.cache objectForKey:dateDesc];
        if (!object) {
            object = [[CalendarObject alloc] initWithDate:_date];
            [self.cache setObject:object forKey:dateDesc];
        }
        _calendarObject = object;
    }
    return _calendarObject;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return [_weekDayDescs count];
    }
    return [[self.calendarObject weekCount] integerValue] * 7;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarCollectionCell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCollectionCell *calendarCell = (CalendarCollectionCell *)cell;
    
    
    if (indexPath.row % 7 == 0 || indexPath.row % 7 == 6) {
        calendarCell.titleLabel.textColor = [UIColor redColor];
    } else {
        calendarCell.titleLabel.textColor = [UIColor blackColor];
    }
    
    
    if (indexPath.section == 0) {
        calendarCell.titleLabel.text = [_weekDayDescs objectAtIndex:indexPath.row];
    } else {
        NSInteger result = NumberAtIndexFrom(self.calendarObject.firstWeekday.integerValue, self.calendarObject.totaldays.integerValue, indexPath.row);
        if (result) {
            calendarCell.titleLabel.text = [NSString stringWithFormat:@"%@", @(result)];
        } else {
            calendarCell.titleLabel.text = @"";
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemSize = CGRectGetWidth(collectionView.bounds) / 7;
    if (indexPath.section == 0) {
        return (CGSize) { itemSize, 32.0};
    }
    return (CGSize){itemSize, itemSize};
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CalendarReusableViewHeader *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
        reusableView.titleLabel.text = [self.date cacheDescKey];
        reusableView.respondClickActionBlock = ^(RespondForwardType forwardType) {
            [self dateWithForwardType:forwardType];
        };
        return reusableView;
    } else {
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return (CGSize) {CGRectGetWidth(collectionView.bounds), 32.0 };
    }
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickBlock) {
        __weak typeof(self) weakSelf = self;
        self.clickBlock(weakSelf, [_calendarObject dateAtIndex:indexPath.row], (indexPath.section == 1 && NumberAtIndexFrom(self.calendarObject.firstWeekday.integerValue, self.calendarObject.totaldays.integerValue, indexPath.row)) == 1);
    }
}
/*
 如果想要控制响应的话 可以放开下面的程序
 */
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return indexPath.section == 1 && NumberAtIndexFrom(self.calendarObject.firstWeekday.integerValue, self.calendarObject.totaldays.integerValue, indexPath.row);
//}

#pragma mark - 

- (void)swipGestureRecognizer:(UISwipeGestureRecognizer *)swipGestureRecognizer
{
    if (self.swipeBlock) {
        self.swipeBlock(self, swipGestureRecognizer.direction);
    } else {
        switch (swipGestureRecognizer.direction) {
            case UISwipeGestureRecognizerDirectionRight:
            case UISwipeGestureRecognizerDirectionDown: {
                [self datePreviousMonth];
                break;
            }
            case UISwipeGestureRecognizerDirectionLeft:
            case UISwipeGestureRecognizerDirectionUp: {
                
                [self dateNextMonth];
                break;
            }
                
            default:
                break;
        }
    
    }
}



#pragma mark - Public
- (void)dateNextMonth
{
    [self dateWithForwardType:RespondForwardTypeNext];
}

- (void)datePreviousMonth
{
    [self dateWithForwardType:RespondForwardTypePre];
}


- (void)dateWithForwardType:(RespondForwardType)forwardType
{
    switch (forwardType) {
        case RespondForwardTypePre: {
            self.date = [_date preMonth];
            break;
        }
        case RespondForwardTypeNext: {
            self.date = [_date nextMonth];
            break;
        }
        default:
            break;
    }
    if (self.heightBlock) {
        __weak typeof(self) weakSelf = self;
        CGFloat height = CGRectGetWidth(_collectionView.frame) / 7 * (1 + _calendarObject.weekCount.integerValue) + 32.0;
        self.heightBlock(weakSelf, height);
    }
    
    [_collectionView reloadData];
}


@end
