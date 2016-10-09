//
//  JSTableViewController.m
//  Demos
//
//  Created by ShenYj on 16/8/27.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSTableViewController.h"
#import "JSSubControllerModel.h"
#import "JSSectionModel.h"
#import "JSMenumHeader.h"

static NSString * const reuseIdentifier = @"reuseIdentifier";

@interface JSTableViewController ()

@property (nonatomic,strong) NSArray <JSSectionModel *> *datas;

@end

@implementation JSTableViewController

- (instancetype)init{
    
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style{
    
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.automaticallyAdjustsScrollViewInsets= NO;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.backgroundColor = [UIColor whiteColor];
    //self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    [self.tableView setContentInset:UIEdgeInsetsMake(-20, 0, 0, 0)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    JSSectionModel *sectionModel = self.datas[section];
    
    return sectionModel.isOpen ? sectionModel.demos.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    JSSectionModel *category = _datas[indexPath.section];
    JSSubControllerModel *detail = category.demos[indexPath.row];
    
    cell.textLabel.text = @(indexPath.row).description;
    cell.detailTextLabel.text = detail.detail;
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    JSMenumHeader *headerView = [JSMenumHeader headerViewWithTableView:tableView];
    
    headerView.model = self.datas[section];
    [headerView setHandler:^{
        [tableView reloadData];
    }];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JSSectionModel *sectionModel = self.datas[indexPath.section];
    JSSubControllerModel *model = sectionModel.demos[indexPath.row];
    
    Class class = NSClassFromString(model.targetControllerClass);
    
    UIViewController *viewController =  [[class alloc] init];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

- (NSArray<JSSectionModel *> *)datas{
    
    if (_datas == nil) {
        _datas = [JSSectionModel loadData];
    }
    return _datas;
}

@end
