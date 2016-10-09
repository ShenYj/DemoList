//
//  JSModelsTableViewController.m
//  模型嵌套
//
//  Created by ShenYj on 16/8/30.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSModelsTableViewController.h"
#import "JSSectionHeadView.h"
#import "JSCategoryModel.h"

static NSString * const reuseIdentifier = @"reuseIdentifier";

@interface JSModelsTableViewController ()

@property (nonatomic,strong) NSArray <JSCategoryModel *> *datas;

@end

@implementation JSModelsTableViewController

- (instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView.sectionFooterHeight = 0;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    
}

- (NSArray<JSCategoryModel *> *)datas{
    
    if (_datas == nil) {
        _datas = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"DemoList" ofType:@"plist"]];
        
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dict in _datas) {
            JSCategoryModel *model = [JSCategoryModel categoryWithDict:dict];
            [mArr addObject:model];
        }
        _datas = mArr.copy;
        
    }
    return _datas;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    JSCategoryModel *category = self.datas[section];
    
    return category.isOpen ? category.demos.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    JSCategoryModel *category = self.datas[indexPath.section];
    JSDetailModel *detail = category.demos[indexPath.row];
    
    cell.textLabel.text = detail.detail;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    JSSectionHeadView *headerView = [JSSectionHeadView headerViewWithTableView:tableView];
    
    headerView.model = self.datas[section];
    [headerView setHandler:^{
        [tableView reloadData];
    }];
    
    return headerView;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 44;
//}


- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
