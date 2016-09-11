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
    JSLocalNotificationTypeAlert
};

@interface JSLocalNotiButton : UIButton

@property (nonatomic,assign) JSLocalNotificationType notificationType;

@end
