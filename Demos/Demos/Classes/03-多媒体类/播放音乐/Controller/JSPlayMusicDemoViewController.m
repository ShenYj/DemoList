//
//  JSPlayMusicDemoViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/17.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSPlayMusicDemoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "JSPlayMusicButton.h"


@interface JSPlayMusicDemoViewController ()

// 播放器
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;
// 播放按钮
@property (nonatomic,strong) JSPlayMusicButton *startButton;
// 暂停按钮
@property (nonatomic,strong) JSPlayMusicButton *pauseButton;
// 停止按钮
@property (nonatomic,strong) JSPlayMusicButton *stopButton;

@end

@implementation JSPlayMusicDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareView];
    
    // 正常情况下AVAudioPlayer会根据音乐的后缀来进行类型判断  如果类型后缀错误,可以通过设置fileTypeHint类型帮助iOS系统更好的识别文件类型
    //[AVAudioPlayer alloc]initWithData:<#(nonnull NSData *)#> fileTypeHint:<#(NSString * _Nullable)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>]
    
    // 1. 设置播放音乐的路径
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"马克西姆.姆尔维察 - Croatian Rhapsody.mp3" ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    
    // 2. 创建播放器
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:nil];
    
    // 3. 准备播放 (音效可以转换为系统的:AudioServicesCreateSystemSoundID,立即就能播放,音乐需要一个缓冲)
    [self.audioPlayer prepareToPlay];
    
}

// 设置UI
- (void)prepareView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.startButton];
    [self.view addSubview:self.pauseButton];
    [self.view addSubview:self.stopButton];
    
    NSArray *buttons = @[self.startButton,self.pauseButton,self.stopButton];
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    
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


#pragma mark - lazy

- (JSPlayMusicButton *)startButton {
    
    if (_startButton ==  nil) {
        _startButton = [[JSPlayMusicButton alloc] init];
        _startButton.playButtonType = JSPlayButtonTypePlay;
        [_startButton setTitle:@"开始播放" forState:UIControlStateNormal];
        [_startButton addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

- (JSPlayMusicButton *)pauseButton {
    
    if (_pauseButton == nil) {
        _pauseButton = [[JSPlayMusicButton alloc] init];
        _pauseButton.playButtonType = JSPlayButtonTypePause;
        [_pauseButton setTitle:@"暂停播放" forState:UIControlStateNormal];
        [_pauseButton addTarget:self action:@selector(pauseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pauseButton;
}

- (JSPlayMusicButton *)stopButton {
    
    if (_stopButton == nil) {
        _stopButton = [[JSPlayMusicButton alloc] init];
        _stopButton.playButtonType = JSPlayButtonTypeStop;
        [_stopButton setTitle:@"停止播放" forState:UIControlStateNormal];
        [_stopButton addTarget:self action:@selector(stopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopButton;
}

@end
