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

static NSString * const reuseId = @"lalalalallalalalala";

@interface JSPlayMusicViewController ()

@property (nonatomic,strong) NSArray <JSMModel *>*dataArr;

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
    
    // 设置Cell样式
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseId];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    cell.textLabel.text = model.name;
    
    cell.detailTextLabel.text = model.singer;
    
    cell.imageView.image = [UIImage imageNamed:model.image];
    
    return cell;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
