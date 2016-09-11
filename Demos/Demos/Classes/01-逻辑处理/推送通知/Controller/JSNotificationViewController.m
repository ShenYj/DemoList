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

@property (nonatomic,strong) UILabel *localNotiLabel;
@property (nonatomic,strong) UILabel *localNotiDescriptionLabel;

// 本地通知按钮
@property (nonatomic,strong) JSLocalNotiButton *localNotificationTypeNoneButton;
@property (nonatomic,strong) JSLocalNotiButton *localNotificationTypeBadgeButton;
@property (nonatomic,strong) JSLocalNotiButton *localNotificationTypeSoundButton;
@property (nonatomic,strong) JSLocalNotiButton *localNotificationTypeAlertButton;

@property (nonatomic,strong) UIView *seperatorLine;

@property (nonatomic,strong) UILabel *remoteNotiLabel;

// 远程通知按钮

@end

@implementation JSNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareView];
}

- (void)prepareView{
    
    
    self.view.backgroundColor = [UIColor js_randomColor];
    
    [self.view addSubview:self.localNotiLabel];
    [self.view addSubview:self.localNotiDescriptionLabel];
    [self.view addSubview:self.localNotificationTypeNoneButton];
    [self.view addSubview:self.localNotificationTypeBadgeButton];
    [self.view addSubview:self.localNotificationTypeSoundButton];
    [self.view addSubview:self.localNotificationTypeAlertButton];
    [self.view addSubview:self.seperatorLine];
    [self.view addSubview:self.remoteNotiLabel];
    
    [self.localNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(90);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(34);
    }];
    
    [self.localNotiDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.localNotiLabel.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    
    NSArray *buttons = @[
                         self.localNotificationTypeNoneButton,
                         self.localNotificationTypeBadgeButton,
                         self.localNotificationTypeSoundButton,
                         self.localNotificationTypeAlertButton
                         ];
    
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:10 tailSpacing:20];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.localNotiDescriptionLabel.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(44);
    }];
    
    [self.seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.localNotificationTypeNoneButton.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(2);
    }];
    
    [self.remoteNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.seperatorLine.mas_bottom).mas_offset(20);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(34);
    }];
    
#pragma mark - target
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - lazy

- (UILabel *)localNotiLabel {
    
    if (_localNotiLabel == nil) {
        _localNotiLabel = [[UILabel alloc] init];
        _localNotiLabel.text = @"本地通知";
        _localNotiLabel.textAlignment = NSTextAlignmentCenter;
        _localNotiLabel.font = [UIFont systemFontOfSize:16];
        _localNotiLabel.textColor = [UIColor js_colorWithHex:0x8B7765];
    }
    return _localNotiLabel;
}

- (UILabel *)localNotiDescriptionLabel {
    
    if (_localNotiDescriptionLabel == nil) {
        _localNotiDescriptionLabel = [[UILabel alloc] init];
        _localNotiDescriptionLabel.text = @"本地通知:点击按钮定时3s推送本地通知,请在点击按钮后将应用进入后台";
        _localNotiDescriptionLabel.textAlignment = NSTextAlignmentCenter;
        _localNotiDescriptionLabel.font = [UIFont systemFontOfSize:14];
        _localNotiDescriptionLabel.textColor = [UIColor js_colorWithHex:0xFFA500];
    }
    return _localNotiDescriptionLabel;
}

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

- (UIView *)seperatorLine {
    
    if (_seperatorLine == nil) {
        _seperatorLine = [[UIView alloc] init];
        _seperatorLine.backgroundColor = [UIColor blackColor];
    }
    return _seperatorLine;
}

- (UILabel *)remoteNotiLabel {
    
    if (_remoteNotiLabel == nil) {
        _remoteNotiLabel = [[UILabel alloc] init];
        _remoteNotiLabel.text = @"远程通知";
        _remoteNotiLabel.textAlignment = NSTextAlignmentCenter;
        _remoteNotiLabel.font = [UIFont systemFontOfSize:16];
        _remoteNotiLabel.textColor = [UIColor js_colorWithHex:0x8B7765];
    }
    return _remoteNotiLabel;
}

@end
