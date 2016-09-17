//
//  JSPlayMusicButton.m
//  Demos
//
//  Created by ShenYj on 16/9/14.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSPlayMusicButton.h"
#import <AVFoundation/AVFoundation.h>


@implementation JSPlayMusicButton

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.layer.borderColor = [UIColor js_colorWithHex:0x8A2BE2].CGColor;
        self.layer.borderWidth = 2;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor js_colorWithHex:0x8A2BE2] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor js_colorWithHex:0xF0FFF0] forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(clickPlayButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}



- (void)clickPlayButton:(JSPlayMusicButton *)sender {
    
    switch (sender.buttonType) {
        case JSPlayButtonTypePlay:
            [self playButtonClick:sender];
            break;
        case JSPlayButtonTypePause:
            [self pauseButtonClick:sender];
            break;
        case JSPlayButtonTypeStop:
            [self stopButtonClick:sender];
            break;
        default:
            break;
    }
    
    
}


// 开始播放
- (void)playButtonClick:(UIButton *)sender {
    
    [self.audioPlayer play];
}
// 暂停播放
- (void)pauseButtonClick:(id)sender {
    
    [self.audioPlayer pause];
    
}
// 停止播放
- (void)stopButtonClick:(id)sender {
    
    [self.audioPlayer stop];
}


@end
