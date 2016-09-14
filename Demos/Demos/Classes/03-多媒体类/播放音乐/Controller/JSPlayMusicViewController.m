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
#import <AVFoundation/AVFoundation.h>

static NSString * const reuseId = @"lalalalallalalalala";

@interface JSPlayMusicViewController ()

@property (nonatomic,strong) NSArray <JSMModel *>*dataArr;

@property (nonatomic,strong) JSPlayMusicButton *playLocalMusicButton;

@property (nonatomic,strong) JSPlayMusicButton *playOnlineMusicButton;

@property (nonatomic,strong) AVAudioPlayer *audioPlayer;

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
    self.tableView.estimatedRowHeight = 80;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - lazy

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
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
    
    
    [self prepareToPlayMusicPlayerWithIndexPath:indexPath];
}


- (void)prepareToPlayMusicPlayerWithIndexPath:(NSIndexPath *)indexPath {
    
    // 正常情况下AVAudioPlayer会根据音乐的后缀来进行类型判断  如果类型后缀错误,可以通过设置fileTypeHint类型帮助iOS系统更好的识别文件类型
    //[AVAudioPlayer alloc]initWithData:<#(nonnull NSData *)#> fileTypeHint:<#(NSString * _Nullable)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>]
    
    JSMModel *model = self.dataArr[indexPath.row];
    
    // 1. 设置播放音乐的路径
    NSString *filePath = [[NSBundle mainBundle]pathForResource:model.mp3 ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    
    // 2. 创建播放器
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:nil];
    
    // 3. 准备播放 (音效可以转换为系统的:AudioServicesCreateSystemSoundID,立即就能播放,音乐需要一个缓冲)
    [self.audioPlayer prepareToPlay];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"准备播放音乐:" message:@"点击确定开始播放" preferredStyle:UIAlertControllerStyleAlert];
    
    /*
     UIAlertActionStyleDefault = 0,
     UIAlertActionStyleCancel,
     UIAlertActionStyleDestructive
    */
    UIAlertAction *play = [UIAlertAction actionWithTitle:@"开始" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.audioPlayer play];
        });
        
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
