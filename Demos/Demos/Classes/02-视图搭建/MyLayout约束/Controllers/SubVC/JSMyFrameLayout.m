//
//  JSMyFrameLayout.m
//  Demos
//
//  Created by ShenYj on 2018/5/7.
//  Copyright © 2018年 ___ShenYJ___. All rights reserved.
//

#import "JSMyFrameLayout.h"

@interface JSMyFrameLayout ()

@end

@implementation JSMyFrameLayout

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpMyFrameLayoutView];
}

- (void)setUpMyFrameLayoutView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = [NSStringFromClass(self.class) substringFromIndex:2];
    
    MyFrameLayout *frameLayout = [[MyFrameLayout alloc] init];
    frameLayout.backgroundColor = [UIColor js_randomColor];
    frameLayout.topPos.equalTo(@100);
    frameLayout.leftPos.equalTo(@10);
    frameLayout.rightPos.equalTo(@10);
    frameLayout.bottomPos.equalTo(@10);
    [self.view addSubview:frameLayout];
    
    // view1
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.leftPos.equalTo(frameLayout).offset(10);
    redView.mySize = CGSizeMake(100, 30);
    redView.topPos.equalTo(frameLayout).offset(20);
    [frameLayout addSubview:redView];
    
    // view2
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.myTop = 70;
    blueView.myRight = 50;
    blueView.mySize = CGSizeMake(40, 200);
    [frameLayout addSubview:blueView];
    
    // view3
    UIView *yellowView  = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor yellowColor];
    yellowView.myCenter = CGPointMake(10, 10);
    yellowView.mySize = CGSizeMake(100, 100);
    [frameLayout addSubview:yellowView];
    
    // view4
    UIView *orangeView = [[UIView alloc] init];
    orangeView.backgroundColor = [UIColor orangeColor];
    orangeView.mySize = CGSizeMake(70, 50);
    orangeView.myLeft = 100;
    orangeView.myBottom = 40;
    [frameLayout addSubview:orangeView];
    
}

@end
