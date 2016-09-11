//
//  JSLocalNotiButton.m
//  Demos
//
//  Created by ShenYj on 16/9/11.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSLocalNotiButton.h"

@implementation JSLocalNotiButton

- (instancetype)init{
    
    self = [super init];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:12];
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
            NSLog(@"1");
            break;
        case JSLocalNotificationTypeBadge:
            NSLog(@"2");
            break;
        case JSLocalNotificationTypeSound:
            NSLog(@"3");
            break;
        case JSLocalNotificationTypeAlert:
            NSLog(@"4");
            break;
            
        default:
            break;
    }
    
    
}

@end
