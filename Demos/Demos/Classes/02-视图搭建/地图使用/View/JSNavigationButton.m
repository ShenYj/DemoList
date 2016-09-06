//
//  JSNavigationButton.m
//  Demos
//
//  Created by ShenYj on 16/9/6.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSNavigationButton.h"

@implementation JSNavigationButton

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.layer.borderColor = [UIColor js_colorWithHex:0xFF1493].CGColor;
        self.layer.borderWidth = 2;
        [self setTitleColor:[UIColor js_colorWithHex:0x1E90FF] forState:UIControlStateNormal];
    }
    return self;
}


@end
