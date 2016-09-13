//
//  JSPlayMusicButton.m
//  Demos
//
//  Created by ShenYj on 16/9/14.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSPlayMusicButton.h"
#import <AVFoundation/AVFoundation.h>


@implementation JSPlayMusicButton{
    
    AVAudioPlayer *_audioPlayer;
}

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
    
    // 正常情况下AVAudioPlayer会根据音乐的后缀来进行类型判断  如果类型后缀错误,可以通过设置fileTypeHint类型帮助iOS系统更好的识别文件类型
    //[AVAudioPlayer alloc]initWithData:<#(nonnull NSData *)#> fileTypeHint:<#(NSString * _Nullable)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>]
    
    // 1. 设置播放音乐的路径
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"马克西姆.姆尔维察 - Croatian Rhapsody.mp3" ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    
    // 2. 创建播放器
//    _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:nil];
    
    // 3. 准备播放 (音效可以转换为系统的:AudioServicesCreateSystemSoundID,立即就能播放,音乐需要一个缓冲)
    [_audioPlayer prepareToPlay];
    
    
    
}

@end
