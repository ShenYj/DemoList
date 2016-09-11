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
        
        [self addTarget:self action:@selector(clickLocalNotiButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

// 按钮点击事件
- (void)clickLocalNotiButton:(JSLocalNotiButton *)sender{
    
    
}

@end
