//
//  ViewController.m
//  CalendarDemo
//
//  Created by Richie on 16/12/6.
//  Copyright © 2016年 personal. All rights reserved.
//

#import "ViewController.h"

#import "CalendarView.h"

#import <Masonry/Masonry.h>
#import "Calendar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CalendarView *calendarView = [[CalendarView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:calendarView];
    
    WeakSelf
    [calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.mas_topLayoutGuideBottom).with.offset(30);
        make.bottom.equalTo(weakSelf.mas_bottomLayoutGuideTop);
        
    }];
    calendarView.clickBlock = ^(CalendarView *calendarView, NSDate *date, BOOL shouldRespond) {
        NSLog(@"date is %@", date);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
//    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    
}

//- (void)dismiss
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
