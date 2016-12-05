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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CalendarView *calendarView = [[CalendarView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:calendarView];
    
    
    [calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom).with.offset(30);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        
    }];
    
    calendarView.clickBlock = ^(CalendarView *calendarView, NSDate *date, BOOL shouldRespond) {
        
    };
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
