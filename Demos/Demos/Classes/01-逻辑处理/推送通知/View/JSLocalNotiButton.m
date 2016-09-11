//
//  JSLocalNotiButton.m
//  Demos
//
//  Created by ShenYj on 16/9/11.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSLocalNotiButton.h"

@interface JSLocalNotiButton ()

/**
 *  通知类型
 */
@property (nonatomic,assign) UIUserNotificationType userNotificationType;


@end

@implementation JSLocalNotiButton

- (instancetype)init{
    
    self = [super init];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.layer.borderColor = [UIColor js_colorWithHex:0x8A2BE2].CGColor;
        self.layer.borderWidth = 2;
        [self setTitleColor:[UIColor js_colorWithHex:0x8A2BE2] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(clickLocalNotiButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

// 按钮点击事件
- (void)clickLocalNotiButton:(JSLocalNotiButton *)sender{
    
    switch (sender.notificationType) {
        case JSLocalNotificationTypeNone:
            self.userNotificationType = UIUserNotificationTypeNone;
            NSLog(@"UIUserNotificationTypeNone");
            break;
        case JSLocalNotificationTypeBadge:
            self.userNotificationType = UIUserNotificationTypeBadge;
            NSLog(@"UIUserNotificationTypeBadge");
            break;
        case JSLocalNotificationTypeSound:
            self.userNotificationType = UIUserNotificationTypeSound;
            NSLog(@"UIUserNotificationTypeSound");
            break;
        case JSLocalNotificationTypeAlert:
            self.userNotificationType = UIUserNotificationTypeAlert;
            NSLog(@"UIUserNotificationTypeAlert");
            break;
            
        default:
            break;
    }
    
    // 注册通知
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:self.userNotificationType categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    // 实例化本地推送通知
    // 默认没有任何效果
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
    
    // 通知含有角标
    if (self.userNotificationType == UIUserNotificationTypeBadge) {
        
        localNotification.applicationIconBadgeNumber = 1;
    }
    // 通知带有声音
    if (self.userNotificationType == UIUserNotificationTypeSound) {
        
        localNotification.soundName = @"buyao.wav";
    }
    // 提示文字
    if (self.userNotificationType == UIUserNotificationTypeAlert) {
        
        localNotification.alertBody = @"这是一条以Alert方式提示的本地推送通知";
    }
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
}

@end
