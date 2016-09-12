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
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.layer.borderColor = [UIColor js_colorWithHex:0x8A2BE2].CGColor;
        self.layer.borderWidth = 2;
        [self setTitleColor:[UIColor js_colorWithHex:0x8A2BE2] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor js_colorWithHex:0xF0FFF0] forState:UIControlStateHighlighted];
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
        case JSLocalNotificationTypeCancel:
            // 取消推送通知
            [self cancelLocalNotification];
            NSLog(@"JSLocalNotificationTypeCancel");
            return ;
            break;
            
        default:
            break;
    }
    
    
    // 推送本地通知
    [self postLocalNotificationWithType:0];
    
}

#pragma mark - 推送本地通知

- (void)postLocalNotificationWithType:(UIUserNotificationType)notificationType{
    
    // 设置类别
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    
    // 设置类别的标识符
    category.identifier = @"localNotification";
    
    // 实例化类别动作
    UIMutableUserNotificationAction *foregroundAction = [[UIMutableUserNotificationAction alloc] init];
    UIMutableUserNotificationAction *backgroundAction = [[UIMutableUserNotificationAction alloc] init];
    
    // 设置动作标识符
    foregroundAction.identifier = @"foreground";
    backgroundAction.identifier = @"background";
    
    // 设置动作标题
    foregroundAction.title = @"进入前台";
    backgroundAction.title = @"进入后台";
    
    // 设置动作类型
    foregroundAction.activationMode = UIUserNotificationActivationModeForeground;
    backgroundAction.activationMode = UIUserNotificationActivationModeBackground;
    
    // 设置行为
    foregroundAction.behavior = UIUserNotificationActionBehaviorDefault;
    backgroundAction.behavior = UIUserNotificationActionBehaviorTextInput;
    
    // 设置类别动作          UIUserNotificationActionContextDefault类型下,弹窗型最多可以显示6个按钮
    [category setActions:@[foregroundAction,backgroundAction] forContext:UIUserNotificationActionContextDefault];
    
    // 注册通知
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:self.userNotificationType categories:[NSSet setWithObject:category]];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    // 实例化本地推送通知
    // 默认没有任何效果
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    // 将推送通知的类型与上面设置的类型进行绑定
    localNotification.category = @"localNotification";
    
    // 5s后推送本地通知
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    
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
    
    // 传递信息
    localNotification.userInfo = @{@"message": @"UserInfo: 这是一条推送通知传递的信息"};
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}


#pragma mark - 取消所以本地推送通知

- (void)cancelLocalNotification{
    
    // 取消了所有的推送通知
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}



@end
