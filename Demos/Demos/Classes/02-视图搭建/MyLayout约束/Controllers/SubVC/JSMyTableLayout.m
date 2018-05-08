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
//    [self demo];
}

- (void)demo {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = [NSStringFromClass(self.class) substringFromIndex:2];
    
    MyTableLayout *S = [MyTableLayout tableLayoutWithOrientation:MyOrientation_Vert];
    S.wrapContentWidth = YES;
    S.myLeft = 20;
    S.myTop = 100;
    S.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    S.subviewHSpace = 10;
    S.subviewVSpace = 10;
    
    [S addRow:MyLayoutSize.wrap colSize:MyLayoutSize.wrap];
    
    UIView *A = [UIView new];
    A.mySize = CGSizeMake(50,40);
    [S addSubview:A];
    
    UIView *B = [UIView new];
    B.mySize = CGSizeMake(100,40);
    [S addSubview:B];
    
    UIView *C = [UIView new];
    C.mySize = CGSizeMake(30,40);
    [S addSubview:C];
    
    [S addRow:MyLayoutSize.wrap colSize:MyLayoutSize.wrap];
    
    UIView *D = [UIView new];
    D.mySize = CGSizeMake(200,40);
    [S addSubview:D];
    
    [self.view addSubview:S];
    S.backgroundColor = [UIColor redColor];
    A.backgroundColor = [UIColor greenColor];
    B.backgroundColor = [UIColor blueColor];
    C.backgroundColor = [UIColor orangeColor];
    D.backgroundColor = [UIColor cyanColor];
}

- (void)setUpMyTableLayoutView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = [NSStringFromClass(self.class) substringFromIndex:2];
    
    MyTableLayout *tableLayout = [MyTableLayout tableLayoutWithOrientation:MyOrientation_Vert];
    tableLayout.backgroundColor = [UIColor js_randomColor];
    tableLayout.wrapContentWidth = YES;
    tableLayout.myTop = 100;
    tableLayout.myCenterX = 0;
    tableLayout.subviewHSpace = 10;
    tableLayout.subviewVSpace = 10;
    [self.view addSubview:tableLayout];
    
    // row1
    [tableLayout addRow:MyLayoutSize.wrap colSize:MyLayoutSize.wrap];
    
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
    [tableLayout addRow:MyLayoutSize.wrap colSize:MyLayoutSize.wrap];
    
    UIView *greenView = [[UIView alloc] init];
    greenView.backgroundColor = [UIColor greenColor];
    greenView.mySize = CGSizeMake(120, 40);
    [tableLayout addSubview:greenView];
    
    // row3
    [tableLayout addRow:MyLayoutSize.wrap colSize:MyLayoutSize.wrap];
    
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
