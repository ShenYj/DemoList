//
//  JSZoomButton.m
//  Demos
//
//  Created by ShenYj on 16/9/6.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSZoomButton.h"

@implementation JSZoomButton

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.layer.borderColor = [UIColor js_colorWithHex:0x7B68EE].CGColor;
        self.layer.borderWidth = 2;
        [self setTitleColor:[UIColor js_colorWithHex:0x8B658B] forState:UIControlStateNormal];
        
    }
    return self;
}


@end
