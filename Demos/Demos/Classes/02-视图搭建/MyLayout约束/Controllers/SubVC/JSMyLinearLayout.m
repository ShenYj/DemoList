//
//  MyLinearLayout.m
//  Demos
//
//  Created by ShenYj on 2018/5/1.
//  Copyright © 2018年 ___ShenYJ___. All rights reserved.
//

#import "JSMyLinearLayout.h"


@interface JSMyLinearLayout ()

@end

@implementation JSMyLinearLayout

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpMylinearLayoutView];
}

- (void)setUpMylinearLayoutView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = [NSStringFromClass(self.class) substringFromIndex:2];
    
    MyLinearLayout *linerLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    linerLayout.backgroundColor = [UIColor js_randomColor];
    linerLayout.subviewSpace = 20.0f;
    linerLayout.leftPos.equalTo(@20);
    linerLayout.rightPos.equalTo(@20);
    linerLayout.topPos.equalTo(@100);
    linerLayout.bottomPos.equalTo(@100);
    [self.view addSubview:linerLayout];
    // view1
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.rightPos.equalTo(@10);
    redView.leftPos.equalTo(@10);
    redView.topPos.equalTo(@10);
    redView.heightSize.equalTo(@40);
    [linerLayout addSubview:redView];
    // view2
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.topPos.equalTo(@20);
    blueView.leftPos.equalTo(@20);
    blueView.rightPos.equalTo(@20);
    blueView.heightSize.equalTo(@40);
    [linerLayout addSubview:blueView];
    // view3
    UIView *purpleView = [[UIView alloc] init];
    purpleView.backgroundColor = [UIColor purpleColor];
    purpleView.leftPos.equalTo(@50);
    purpleView.rightPos.equalTo(@5);
    purpleView.topPos.equalTo(@10);
    purpleView.heightSize.equalTo(@80);
    [linerLayout addSubview:purpleView];
    // view4
    UIView *yellowView = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor yellowColor];
    yellowView.leftPos.equalTo(@0);
    yellowView.heightSize.equalTo(@100);
    yellowView.rightPos.equalTo(@60);
    [linerLayout addSubview:yellowView];
    // view5
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.leftPos.equalTo(@60);
    whiteView.rightPos.equalTo(@40);
    whiteView.heightSize.equalTo(@80);
    [linerLayout addSubview:whiteView];
    // view6
    UIView *orangeView = [[UIView alloc] init];
    orangeView.backgroundColor = [UIColor orangeColor];
    orangeView.leftPos.equalTo(@70);
    orangeView.rightPos.equalTo(@20);
    orangeView.heightSize.equalTo(@90);
    [linerLayout addSubview:orangeView];
    
}

@end
