//
//  JSRemoteNotiButton.m
//  Demos
//
//  Created by ShenYj on 16/9/12.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSRemoteNotiButton.h"

@implementation JSRemoteNotiButton

- (instancetype)init{
    
    self = [super init];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.layer.borderColor = [UIColor js_colorWithHex:0x8A2BE2].CGColor;
        self.layer.borderWidth = 2;
        [self setTitleColor:[UIColor js_colorWithHex:0x8A2BE2] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor js_colorWithHex:0xF0FFF0] forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(clickRemoteNotiButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)clickRemoteNotiButton:(JSRemoteNotiButton *)sender {
    
    
}

@end
