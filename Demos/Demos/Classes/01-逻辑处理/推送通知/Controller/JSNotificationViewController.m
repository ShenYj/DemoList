//
//  JSNotificationViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/11.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSNotificationViewController.h"

@interface JSNotificationViewController ()

// 本地通知按钮
@property (nonatomic,strong) UIButton *localNotificationButton;

@end

@implementation JSNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - lazy

- (UIButton *)localNotificationButton {
    
    if (_localNotificationButton == nil) {
        _localNotificationButton = [[UIButton alloc ]init];
    }
    return _localNotificationButton;
}


@end
