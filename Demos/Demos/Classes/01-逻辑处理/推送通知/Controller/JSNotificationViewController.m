//
//  JSNotificationViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/11.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSNotificationViewController.h"
#import "JSLocalNotiButton.h"
#import "JSRemoteNotiButton.h"

@interface JSNotificationViewController ()

@property (nonatomic,strong) UILabel *localNotiLabel;
@property (nonatomic,strong) UILabel *localNotiDescriptionLabel;

// 本地通知按钮
@property (nonatomic,strong) JSLocalNotiButton *localNotificationTypeNoneButton;
@property (nonatomic,strong) JSLocalNotiButton *localNotificationTypeBadgeButton;
@property (nonatomic,strong) JSLocalNotiButton *localNotificationTypeSoundButton;
@property (nonatomic,strong) JSLocalNotiButton *localNotificationTypeAlertButton;
@property (nonatomic,strong) JSLocalNotiButton *localNotificationTypeCancelButton;

@property (nonatomic,strong) UILabel *noteLabel;
@property (nonatomic,strong) UIView *seperatorLine;

@property (nonatomic,strong) UILabel *remoteNotiLabel;
@property (nonatomic,strong) UILabel *remoteDescriptionLabel;

// 远程通知按钮

@end

@implementation JSNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLocalNote:) name:@"localNotification" object:nil];
    
    [self prepareView];
}

// 展示本地通知
- (void)showLocalNote:(NSNotification *)notification{
    
    NSString *key = notification.userInfo.keyEnumerator.nextObject;
    
    self.noteLabel.text = [notification.userInfo objectForKey:key];
    
}

- (void)prepareView{
    
    self.view.backgroundColor = [UIColor js_colorWithHex:0xFFE7BA];
    
    [self.view addSubview:self.localNotiLabel];
    [self.view addSubview:self.noteLabel];
    [self.view addSubview:self.localNotiDescriptionLabel];
    [self.view addSubview:self.localNotificationTypeNoneButton];
    [self.view addSubview:self.localNotificationTypeBadgeButton];
    [self.view addSubview:self.localNotificationTypeSoundButton];
    [self.view addSubview:self.localNotificationTypeAlertButton];
    [self.view addSubview:self.localNotificationTypeCancelButton];
    [self.view addSubview:self.seperatorLine];
    [self.view addSubview:self.remoteNotiLabel];
    [self.view addSubview:self.remoteDescriptionLabel];
    
    [self.localNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(90);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(34);
    }];
    
    [self.localNotiDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.localNotiLabel.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    NSArray *buttons = @[
                         self.localNotificationTypeNoneButton,
                         self.localNotificationTypeBadgeButton,
                         self.localNotificationTypeSoundButton,
                         self.localNotificationTypeAlertButton,
                         self.localNotificationTypeCancelButton
                         ];
    
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:10 tailSpacing:20];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.localNotiDescriptionLabel.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(44);
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.localNotificationTypeNoneButton.mas_bottom).mas_offset(20);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    [self.seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.noteLabel.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(2);
    }];
    
    [self.remoteNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.seperatorLine.mas_bottom).mas_offset(20);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(34);
    }];
    
    [self.remoteDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.remoteNotiLabel.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(60);
    }];
    
    
    
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
        _localNotiDescriptionLabel.text = @"本地通知:点击按钮定后5s推送本地通知,请在点击按钮后将应用进入后台";
        _localNotiDescriptionLabel.textAlignment = NSTextAlignmentCenter;
        _localNotiDescriptionLabel.font = [UIFont systemFontOfSize:14];
        _localNotiDescriptionLabel.numberOfLines = 0;
        _localNotiDescriptionLabel.textColor = [UIColor js_colorWithHex:0xFF0000];
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

- (JSLocalNotiButton *)localNotificationTypeCancelButton {
    
    if (_localNotificationTypeCancelButton == nil) {
        _localNotificationTypeCancelButton = [[JSLocalNotiButton alloc] init];
        _localNotificationTypeCancelButton.notificationType = JSLocalNotificationTypeCancel;
        [_localNotificationTypeCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_localNotificationTypeCancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _localNotificationTypeCancelButton;
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

- (UILabel *)noteLabel {
    
    if (_noteLabel == nil) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont systemFontOfSize:16];
        _noteLabel.textColor = [UIColor js_colorWithHex:0xEE00EE];
    }
    return _noteLabel;
}

- (UILabel *)remoteDescriptionLabel{
    
    if (_remoteDescriptionLabel == nil) {
        _remoteDescriptionLabel = [[UILabel alloc ]init];
        _remoteDescriptionLabel.text = @"需要使用付费的开发者账号...";
        _remoteDescriptionLabel.textAlignment = NSTextAlignmentCenter;
        _remoteDescriptionLabel.font = [UIFont systemFontOfSize:14];
        _remoteDescriptionLabel.numberOfLines = 0;
        _remoteDescriptionLabel.textColor = [UIColor js_colorWithHex:0xFF0000];
    }
    return _remoteDescriptionLabel;
}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
