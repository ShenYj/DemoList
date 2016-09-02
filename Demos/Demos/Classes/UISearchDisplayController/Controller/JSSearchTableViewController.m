//
//  JSSearchTableViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/1.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSSearchTableViewController.h"

static NSString * const reuseIdentifier = @"reuseIdentifier";

@interface JSSearchTableViewController () <UISearchResultsUpdating,UISearchBarDelegate>

// 搜索控制器
@property (nonatomic,strong) UISearchController *searchController;
// 保存搜索结果
@property (nonatomic,strong) NSMutableArray *resultArr;

@end

@implementation JSSearchTableViewController{
    
    NSArray *_data;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _data = @[
              @{@"category":@"Chocolate", @"name":@"Chocolate Bar1"},
              @{@"category":@"Chocolate", @"name":@"Chocolate Chip1"},
              @{@"category":@"Chocolate", @"name":@"Dark Chocolate1"},
              @{@"category":@"Hard", @"name":@"Lollipop1"},
              @{@"category":@"Hard", @"name":@"Candy Cane1"},
              @{@"category":@"Hard", @"name":@"Jaw Breaker1"},
              @{@"category":@"Other", @"name":@"Caramel1"},
              @{@"category":@"Other", @"name":@"Sour Chew1"},
              @{@"category":@"Other", @"name":@"Gummi Bear"},
              @{@"category":@"Chocolate", @"name":@"Chocolate Bar2"},
              @{@"category":@"Chocolate", @"name":@"Chocolate Chip2"},
              @{@"category":@"Chocolate", @"name":@"Dark Chocolate2"},
              @{@"category":@"Hard", @"name":@"Lollipop2"},
              @{@"category":@"Hard", @"name":@"Candy Cane2"},
              @{@"category":@"Hard", @"name":@"Jaw Breaker2"},
              @{@"category":@"Other", @"name":@"Caramel2"},
              @{@"category":@"Other", @"name":@"Sour Chew2"},
              @{@"category":@"Other", @"name":@"Gummi Bear2"},
              @{@"category":@"Chocolate", @"name":@"Chocolate Bar3"},
              @{@"category":@"Chocolate", @"name":@"Chocolate Chip3"},
              @{@"category":@"Chocolate", @"name":@"Dark Chocolate3"},
              @{@"category":@"Hard", @"name":@"Lollipop3"},
              @{@"category":@"Hard", @"name":@"Candy Cane3"},
              @{@"category":@"Hard", @"name":@"Jaw Breaker3"},
              @{@"category":@"Other", @"name":@"Caramel3"},
              @{@"category":@"Other", @"name":@"Sour Chew3"},
              @{@"category":@"Other", @"name":@"Gummi Bear3"}
              ];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    
    self.navigationItem.titleView = self.searchController.searchBar;
    
    
    // 设置代理
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    
    // 设置属性
    
    // 默认情况下,UISearchController会暗化前一个视图
    self.searchController.dimsBackgroundDuringPresentation = NO;
    // 保证在UISearchController在激活状态下用户push到下一个view controller之后search bar不会仍留在界面上。
    self.searchController.definesPresentationContext = YES;
    // 是否隐藏导航栏
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    // 设置占位文字
    self.searchController.searchBar.placeholder = @"Search here...";
    
    __weak typeof(self) weakSelf = self;
    // 设置下拉刷新 - 1 Normal
    
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//        NSMutableArray *moreData = [NSMutableArray arrayWithArray:_data];
//        _data = [moreData arrayByAddingObjectsFromArray:_data];
//        [weakSelf.tableView reloadData];
//        [weakSelf.tableView.mj_header endRefreshing];
//    }];
    
    // 设置下拉刷新 - 2 Gif
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        NSMutableArray *moreData = [NSMutableArray arrayWithArray:_data];
        _data = [moreData arrayByAddingObjectsFromArray:_data];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
//    header.lastUpdatedTimeLabel.hidden = YES;
//    header.stateLabel.hidden = YES;
    
    NSArray *arr = @[
                     [UIImage imageNamed:@"AppIcon40x40"]
                     ];
    NSArray *arr2 = @[[UIImage imageNamed:@"channel_song_list_play_btn"]];
    
    [header setImages:arr forState:MJRefreshStateIdle];
    [header setImages:arr2 forState:MJRefreshStateRefreshing];
    
    
    self.tableView.mj_header = header;
    
    
    // 下拉刷新
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        
//        [self.tableView.mj_footer endRefreshingWithNoMoreData];
//    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
}


#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString *searchString = self.searchController.searchBar.text;
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    
    if (self.resultArr != nil) {
        [self.resultArr removeAllObjects];
    }
    
    // 过滤数据
    self.resultArr = [NSMutableArray arrayWithArray:[_data filteredArrayUsingPredicate:preicate]];
    // 刷新表格
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    if (self.searchController.isActive) {
        
        return self.resultArr.count;
    }else{
        
        return _data.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    
    NSDictionary *Candy = nil;
    
    if (self.searchController.isActive) {
        
        Candy = self.resultArr[indexPath.row];
        
    }else{
        
        Candy = _data[indexPath.row];
    }
    
    cell.textLabel.text = Candy[@"category"];
    cell.textLabel.textColor = [UIColor js_colorWithHex:0x9370DB];
    cell.detailTextLabel.text = Candy[@"name"];
    cell.detailTextLabel.textColor = [UIColor js_colorWithHex:0x1E90FF];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"Section:%ld,Row:%ld",indexPath.section,indexPath.row);
}


- (NSArray <UITableViewRowAction *>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *mDataArr = [NSMutableArray arrayWithArray:_data];
    
    NSString *cureHistoryDeleteBtnString = @"删除";
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:cureHistoryDeleteBtnString handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"删除本行");
        
         // 1.删除数据源
        [mDataArr removeObjectAtIndex:indexPath.row];
        _data = mDataArr;
         // 2.删除数据库
         
         // 3.更新UI
        [tableView reloadData];
         
    }];
    return @[deleteRowAction];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
