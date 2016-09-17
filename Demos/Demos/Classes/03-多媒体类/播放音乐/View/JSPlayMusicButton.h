//
//  JSPlayMusicButton.h
//  Demos
//
//  Created by ShenYj on 16/9/14.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JSPlayButtonType) {
    JSPlayButtonTypePlay,
    JSPlayButtonTypePause,
    JSPlayButtonTypeStop,
};

@interface JSPlayMusicButton : UIButton

@property (nonatomic,assign) JSPlayButtonType playButtonType;

@property (nonatomic,strong) AVAudioPlayer *audioPlayer;

@end
