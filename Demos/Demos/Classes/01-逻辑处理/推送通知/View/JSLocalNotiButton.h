//
//  JSLocalNotiButton.h
//  Demos
//
//  Created by ShenYj on 16/9/11.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger,JSLocalNotificationType){
    JSLocalNotificationTypeNone,
    JSLocalNotificationTypeBadge,
    JSLocalNotificationTypeSound,
    JSLocalNotificationTypeAlert,
    JSLocalNotificationTypeCancel
};

@interface JSLocalNotiButton : UIButton
/**
 *  按钮类型
 */
@property (nonatomic,assign) JSLocalNotificationType notificationType;
/**
 *  按钮点击事件回调
 */
@property (nonatomic,copy) void(^targetHandler)(JSLocalNotificationType notificationType);


@end
