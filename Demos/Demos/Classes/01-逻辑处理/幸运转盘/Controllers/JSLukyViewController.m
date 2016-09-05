//
//  ViewController.m
//  幸运转盘
//
//  Created by ShenYj on 16/5/9.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//



#import "JSLukyViewController.h"
#import "JSRotateView.h"

@interface JSLukyViewController ()

@end

@implementation JSLukyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置Controller内最外层View的Layer内容
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"LuckyBackground"].CGImage);
    
    //通过自定义的类方法实例化转盘View对象,并设置其属性
    JSRotateView *rotateView = [JSRotateView rotateView];
    rotateView.center = self.view.center;
    rotateView.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    //添加到Controller的View中
    [self.view addSubview:rotateView];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
