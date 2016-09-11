//
//  JSNotificationViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/11.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSNotificationViewController.h"
#import "JSLocalNotiButton.h"

@interface JSNotificationViewController ()

// 本地通知按钮
@property (nonatomic,strong) JSLocalNotiButton *localNotificationTypeNoneButton;
@property (nonatomic,strong) JSLocalNotiButton *localNotificationTypeBadgeButton;
@property (nonatomic,strong) JSLocalNotiButton *localNotificationTypeSoundButton;
@property (nonatomic,strong) JSLocalNotiButton *localNotificationTypeAlertButton;


@end

@implementation JSNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareView];
}

- (void)prepareView{
    
    self.view.backgroundColor = [UIColor js_randomColor];
    
    [self.view addSubview:self.localNotificationTypeNoneButton];
    [self.view addSubview:self.localNotificationTypeBadgeButton];
    [self.view addSubview:self.localNotificationTypeSoundButton];
    [self.view addSubview:self.localNotificationTypeAlertButton];
    
    NSArray *buttons = @[
                         self.localNotificationTypeNoneButton,
                         self.localNotificationTypeBadgeButton,
                         self.localNotificationTypeSoundButton,
                         self.localNotificationTypeAlertButton
                         ];
    
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:10 tailSpacing:20];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(90);
        make.height.mas_equalTo(44);
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - lazy

- (JSLocalNotiButton *)localNotificationTypeNoneButton {
    
    if (_localNotificationTypeNoneButton == nil) {
        _localNotificationTypeNoneButton = [[JSLocalNotiButton alloc ]init];
        _localNotificationTypeNoneButton.notificationType = JSLocalNotificationTypeNone;
        [_localNotificationTypeNoneButton setTitle:@"None" forState:UIControlStateNormal];
    }
    return _localNotificationTypeNoneButton;
}
- (JSLocalNotiButton *)localNotificationTypeBadgeButton {
    
    if (_localNotificationTypeBadgeButton == nil) {
        _localNotificationTypeBadgeButton = [[JSLocalNotiButton alloc ]init];
        _localNotificationTypeBadgeButton.notificationType = JSLocalNotificationTypeBadge;
        [_localNotificationTypeBadgeButton setTitle:@"Badge" forState:UIControlStateNormal];
    }
    return _localNotificationTypeBadgeButton;
}
- (JSLocalNotiButton *)localNotificationTypeSoundButton {
    
    if (_localNotificationTypeSoundButton == nil) {
        _localNotificationTypeSoundButton = [[JSLocalNotiButton alloc ]init];
        _localNotificationTypeSoundButton.notificationType = JSLocalNotificationTypeSound;
        [_localNotificationTypeSoundButton setTitle:@"Sound" forState:UIControlStateNormal];
    }
    return _localNotificationTypeSoundButton;
}
- (JSLocalNotiButton *)localNotificationTypeAlertButton {
    
    if (_localNotificationTypeAlertButton == nil) {
        _localNotificationTypeAlertButton = [[JSLocalNotiButton alloc ]init];
        _localNotificationTypeAlertButton.notificationType = JSLocalNotificationTypeAlert;
        [_localNotificationTypeAlertButton setTitle:@"Alert" forState:UIControlStateNormal];
    }
    return _localNotificationTypeAlertButton;
}


@end
