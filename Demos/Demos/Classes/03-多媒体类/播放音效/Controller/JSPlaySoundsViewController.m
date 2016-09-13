//
//  JSPlaySoundsViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/13.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSPlaySoundsViewController.h"

@interface JSPlaySoundsViewController ()

@property (nonatomic,strong) UIButton *playButton;

@end

@implementation JSPlaySoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareView];
}

- (void)prepareView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - target 

- (void)clickPlayButton:(UIButton *)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy

- (UIButton *)playButton {
    
    if (_playButton == nil) {
        _playButton = [[UIButton alloc] init];
        [_playButton setTitle:@"播放自定义音效" forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(clickPlayButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

@end
