//
//  JSPlayMusicViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/14.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSPlayMusicViewController.h"
#import "JSPlayMusicButton.h"

@interface JSPlayMusicViewController ()

@property (nonatomic,strong) JSPlayMusicButton *playLocalMusicButton;

@property (nonatomic,strong) JSPlayMusicButton *playOnlineMusicButton;

@end

@implementation JSPlayMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareView];
}

- (void)prepareView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.playLocalMusicButton];
    
    [self.playLocalMusicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 44));
    }];
    
}


#pragma mark - lazy

- (JSPlayMusicButton *)playLocalMusicButton {
    
    if (_playLocalMusicButton == nil) {
        _playLocalMusicButton = [[JSPlayMusicButton alloc] init];
    }
    return _playLocalMusicButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
