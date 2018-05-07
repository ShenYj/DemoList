//
//  JSMyRelativeLayout.m
//  Demos
//
//  Created by ShenYj on 2018/5/6.
//  Copyright © 2018年 ___ShenYJ___. All rights reserved.
//

#import "JSMyRelativeLayout.h"

@interface JSMyRelativeLayout ()

@end

@implementation JSMyRelativeLayout

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpMyRelativeLayoutView];
}

- (void)setUpMyRelativeLayoutView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = [NSStringFromClass(self.class) substringFromIndex:2];
    
    MyRelativeLayout *relativeLayout = [[MyRelativeLayout alloc] init];
    relativeLayout.backgroundColor = [UIColor js_randomColor];
    relativeLayout.mySize = CGSizeMake(300, 400);
    relativeLayout.centerXPos.equalTo(@0);
    relativeLayout.centerYPos.equalTo(@0);
    [self.view addSubview:relativeLayout];
    // view1
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.leftPos.equalTo(relativeLayout).offset(20);
    redView.topPos.equalTo(relativeLayout).offset(20);
    redView.heightSize.equalTo(@80);
    redView.widthSize.equalTo(redView.heightSize);
    [relativeLayout addSubview:redView];
    // view2
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.leftPos.equalTo(redView).offset(20);
    blueView.topPos.equalTo(redView.bottomPos).offset(10);
    blueView.widthSize.equalTo(@50);
    blueView.heightSize.equalTo(blueView.widthSize);
    [relativeLayout addSubview:blueView];
    // view3
    UIView *yellowView = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor yellowColor];
    yellowView.topPos.equalTo(redView.bottomPos).offset(-25);
    yellowView.leftPos.equalTo(blueView.rightPos).offset(20);
    yellowView.heightSize.equalTo(@80);
    yellowView.widthSize.equalTo(@100);
    [relativeLayout addSubview:yellowView];
    // view4
    UIView *purpleView = [[UIView alloc] init];
    purpleView.backgroundColor = [UIColor purpleColor];
    purpleView.topPos.equalTo(blueView.bottomPos).offset(10);
    purpleView.leftPos.equalTo(relativeLayout).offset(50);
    purpleView.rightPos.equalTo(relativeLayout).offset(70);
    purpleView.bottomPos.equalTo(relativeLayout).offset(20);
    [relativeLayout addSubview:purpleView];
    
}

@end
