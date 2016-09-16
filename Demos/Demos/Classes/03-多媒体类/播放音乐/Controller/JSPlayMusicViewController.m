//
//  JSPlayMusicViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/14.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSPlayMusicViewController.h"
#import "JSPlayMusicButton.h"
#import "JSMModel.h"
#import "JSMusicListTableViewCell.h"
#import "JSMusciManager.h"
#import <AVFoundation/AVFoundation.h>

static NSString * const reuseId = @"lalalalallalalalala";

@interface JSPlayMusicViewController ()

@property (nonatomic,strong) NSArray <JSMModel *>*dataArr;

@property (nonatomic,strong) JSPlayMusicButton *playLocalMusicButton;

@property (nonatomic,strong) JSPlayMusicButton *playOnlineMusicButton;

@property (nonatomic,strong) AVAudioPlayer *audioPlayer;

@property (nonatomic,copy) NSString *currentMusicName;

@end

@implementation JSPlayMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareView];
}

- (void)prepareView {
    
    // 设置Cell样式
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseId];
//    self.tableView.estimatedRowHeight = 80;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JSMModel *model = self.dataArr[indexPath.row];
    
    JSMusicListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    if (!cell) {
        cell = [[JSMusicListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    // 传递数据
    cell.model = model;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JSMModel *model = self.dataArr[indexPath.row];
    
    // 播放控制 : 开始、暂停和停止播放
    [[JSMusciManager sharedMusicManager] playMusicWithFileName:model.mp3];
    
}




- (void)prepareToPlayMusicPlayerWithIndexPath:(NSIndexPath *)indexPath {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"准备播放音乐:" message:@"点击确定开始播放" preferredStyle:UIAlertControllerStyleAlert];
    
    /*
     UIAlertActionStyleDefault = 0,
     UIAlertActionStyleCancel,
     UIAlertActionStyleDestructive
    */
    UIAlertAction *play = [UIAlertAction actionWithTitle:@"开始" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.audioPlayer play];
        
    }];
    
    UIAlertAction *pause = [UIAlertAction actionWithTitle:@"暂停" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.audioPlayer pause];
    }];
    
    UIAlertAction *stop = [UIAlertAction actionWithTitle:@"停止" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.audioPlayer stop];
    }];
    
    [alertController addAction:play];
    [alertController addAction:pause];
    [alertController addAction:stop];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

#pragma mark - lazy

- (NSArray <JSMModel *>*)dataArr {
    
    if (_dataArr == nil) {
        
        NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mlist" ofType:@"plist"]];
        
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            
            JSMModel *model = [JSMModel yy_modelWithDictionary:dict];
            [mArr addObject:model];
        }
        
        _dataArr = mArr.copy;
    }
    return _dataArr;
}



@end
