//
//  JSPlayMusicButton.m
//  Demos
//
//  Created by ShenYj on 16/9/14.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSPlayMusicButton.h"

@implementation JSPlayMusicButton

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.layer.borderColor = [UIColor js_colorWithHex:0x8A2BE2].CGColor;
        self.layer.borderWidth = 2;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor js_colorWithHex:0x8A2BE2] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor js_colorWithHex:0xF0FFF0] forState:UIControlStateHighlighted];
        [self setTitle:@"播放自定义音效" forState:UIControlStateNormal];
        [self addTarget:self action:@selector(clickPlayButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)clickPlayButton:(JSPlayMusicButton *)sender {
    
    NSString *fileName = @"小苹果.mp3";
    
    
}

@end
