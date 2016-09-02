//
//  JSSearchTableViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/1.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSSearchTableViewController.h"

static NSString * const reuseIdentifier = @"reuseIdentifier";

@interface JSSearchTableViewController () <UISearchResultsUpdating>

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
    
    // 设置属性
    
    // 默认情况下,UISearchController会暗化前一个视图
    self.searchController.dimsBackgroundDuringPresentation = NO;
    // 保证在UISearchController在激活状态下用户push到下一个view controller之后search bar不会仍留在界面上。
    self.searchController.definesPresentationContext = YES;
    
    
    

}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    NSDictionary *Candy = _data[indexPath.row];
    
    cell.textLabel.text = Candy[@"category"];
    cell.textLabel.textColor = [UIColor js_colorWithHex:0x9370DB];
    cell.detailTextLabel.text = Candy[@"name"];
    cell.detailTextLabel.textColor = [UIColor js_colorWithHex:0x1E90FF];
    
    return cell;
}

#pragma mark - lazy

- (NSMutableArray *)resultArr{
    
    if (!_resultArr) {
        _resultArr = [NSMutableArray array];
    }
    return _resultArr;
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
