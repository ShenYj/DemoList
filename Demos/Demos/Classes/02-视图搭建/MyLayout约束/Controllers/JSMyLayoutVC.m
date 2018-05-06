//
//  JSMyLayoutVC.m
//  Demos
//
//  Created by ShenYj on 2018/5/1.
//  Copyright © 2018年 ___ShenYJ___. All rights reserved.
//

#import "JSMyLayoutVC.h"
#import "JSMyLinearLayout.h"

static NSString * const kReusedID = @"kReusedID";

@interface JSMyLayoutVC () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray     *_datas;
    UITableView *_tableView;
}

@end

@implementation JSMyLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self MyLayoutDemo1];
}

- (void)MyLayoutDemo1 {
    _datas = @[
               @{@"title":@"线性布局", @"type":@"MyLinearLayout"},
               @{@"title":@"相对布局", @"type":@"MyRelativeLayout"},
               @{@"title":@"框架布局", @"type":@"MyFrameLayout"},
               @{@"title":@"表格布局", @"type":@"MyTableLayout"},
               @{@"title":@"流式布局", @"type":@"MyFlowLayout"},
               @{@"title":@"浮动布局", @"type":@"MyFloatLayout"},
               @{@"title":@"路径布局", @"type":@"MyPathLayout"},
               @{@"title":@"栅格布局", @"type":@"MyGridLayout"},
               ];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    _tableView.rowHeight  = 45;
    [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kReusedID];
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell     = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kReusedID];
    cell.accessoryType        = UITableViewCellStyleSubtitle;
    cell.textLabel.text       = [_datas[indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [_datas[indexPath.row] objectForKey:@"type"];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *classStr = [_datas[indexPath.row] objectForKey:@"type"];
    NSString *classEx  = [NSString stringWithFormat:@"JS%@",classStr];
    Class  class       = NSClassFromString(classEx);
    id VC              = [class new];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
