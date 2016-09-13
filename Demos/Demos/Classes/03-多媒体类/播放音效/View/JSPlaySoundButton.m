//
//  JSPlaySoundButton.m
//  Demos
//
//  Created by ShenYj on 16/9/13.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSPlaySoundButton.h"
#import <AVFoundation/AVFoundation.h>

@interface JSPlaySoundButton ()
// 音效缓存
@property (nonatomic,strong) NSMutableDictionary *soundIdCache;
@end

@implementation JSPlaySoundButton

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


#pragma mark - target

- (void)clickPlayButton:(UIButton *)sender {
    
    NSString *fileName = @"buyao.caf";
    
    [self playSystemSoundWithFileName:fileName];
    
}


- (void)playSystemSoundWithFileName:(NSString *)fileName{
    
    // AudioServicesPlayAlertSound(<#SystemSoundID inSystemSoundID#>)  手机设置静音时会震动
    
    // 设置自定义声音文件的路径
    NSString *filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    
    // 从缓存中获取
    SystemSoundID soundID = [[self.soundIdCache objectForKey:fileName] unsignedIntValue];
    // 判断是否存在
    if (soundID == 0) {
        
        // 生成soundID 音效的唯一标识符  (防止每次都去生成(经常使用),消耗性能,所以使用缓存记录)
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(fileUrl), &soundID);
        
        // 添加到缓存中
        [self.soundIdCache setObject:@(soundID) forKey:fileName];
        NSLog(@"添加到缓存");
    }
    
    // AudioServicesPlaySystemSound 播放系统音效
    AudioServicesPlaySystemSound(soundID);
    
}

#pragma mark - 缓存懒加载

- (NSMutableDictionary *)soundIdCache{
    
    if (_soundIdCache == nil) {
        _soundIdCache = [NSMutableDictionary dictionary];
        NSLog(@"生成缓存");
    }
    return _soundIdCache;
}


// 内存紧张时调用
+ (void)didReceiveMemoryWarning{
    
    for (NSNumber *soundIDNumber in self.soundIdCache.allValues) {
        // 销毁内存中的音效
        AudioServicesRemoveSystemSoundCompletion(soundIDNumber.unsignedIntValue);
        NSLog(@"删除内存中的音效");
    }
    // 移除缓存中存放的ID
    // [self.soundIdCache removeAllObjects]; soundIdCache还存在,只清除了内部存放的内容
    self.soundIdCache = nil;
    NSLog(@"清除缓存");
    
}


@end
