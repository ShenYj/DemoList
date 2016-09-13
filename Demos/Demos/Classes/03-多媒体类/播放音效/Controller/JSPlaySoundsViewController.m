//
//  JSPlaySoundsViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/13.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSPlaySoundsViewController.h"
#import "JSPlaySoundButton.h"

@interface JSPlaySoundsViewController ()

@property (nonatomic,strong) JSPlaySoundButton *playButton;

@end

@implementation JSPlaySoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareView];
}

- (void)prepareView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.playButton];
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 44));
    }];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    // 内存紧张时清理音效缓存
    [JSPlaySoundButton didReceiveMemoryWarning];
}

#pragma mark - lazy

- (JSPlaySoundButton *)playButton {
    
    if (_playButton == nil) {
        _playButton = [[JSPlaySoundButton alloc] init];
    }
    return _playButton;
}

@end
