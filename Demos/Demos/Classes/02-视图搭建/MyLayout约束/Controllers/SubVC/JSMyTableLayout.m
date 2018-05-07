//
//  JSMyTableLayout.m
//  Demos
//
//  Created by ShenYj on 2018/5/7.
//  Copyright © 2018年 ___ShenYJ___. All rights reserved.
//

#import "JSMyTableLayout.h"

@interface JSMyTableLayout ()

@end

@implementation JSMyTableLayout

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpMyTableLayoutView];
}

- (void)setUpMyTableLayoutView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = [NSStringFromClass(self.class) substringFromIndex:2];
    
    MyTableLayout *tableLayout = [MyTableLayout tableLayoutWithOrientation:MyOrientation_Vert];
    tableLayout.backgroundColor = [UIColor js_randomColor];
    tableLayout.wrapContentWidth = YES;
    tableLayout.myHorzMargin = 20;
    tableLayout.myVertMargin = 100;
    tableLayout.subviewHSpace = 10;
    tableLayout.subviewVSpace = 10;
    [self.view addSubview:tableLayout];
    
    // row1
    [tableLayout addRow:80 colSize:40];
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.mySize = CGSizeMake(20, 50);
    [tableLayout addSubview:redView];
    
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.mySize = CGSizeMake(80, 70);
    [tableLayout addSubview:blueView];
    
    UIView *yellowView = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor yellowColor];
    yellowView.mySize = CGSizeMake(80, 60);
    [tableLayout addSubview:yellowView];
    
    // row2
    [tableLayout addRow:50 colSize:150];
    
    UIView *greenView = [[UIView alloc] init];
    greenView.backgroundColor = [UIColor greenColor];
    greenView.mySize = CGSizeMake(120, 40);
    [tableLayout addSubview:greenView];
    
    // row3
    [tableLayout addRow:80 colSize:70];
    
    UIView *cyanView = [[UIView alloc] init];
    cyanView.backgroundColor = [UIColor cyanColor];
    cyanView.mySize = CGSizeMake(50, 40);
    [tableLayout addSubview:cyanView];
    
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.mySize = CGSizeMake(60, 50);
    [tableLayout addSubview:whiteView];
    
}

@end
