//
//  JSCalendarViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/6.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSCalendarViewController.h"

@interface JSCalendarViewController () <FSCalendarDelegate,FSCalendarDataSource>

@property (nonatomic,strong) FSCalendar *calendar;

@end

@implementation JSCalendarViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self prepareView];
}

- (void)prepareView{
    
    self.view.backgroundColor = [UIColor js_colorWithHex:0xFFA500];
    
    [self.view addSubview:self.calendar];
    
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).mas_offset(UIEdgeInsetsMake(74, 10, 10, 10));
    }];
    
}


#pragma mark - lazy

- (FSCalendar *)calendar{
    if (_calendar == nil) {
        _calendar = [[FSCalendar alloc] init];
        _calendar.backgroundColor = [UIColor js_colorWithHex:0x836FFF];
        _calendar.delegate = self;
        _calendar.dataSource = self;
    }
    return _calendar;
}

@end
