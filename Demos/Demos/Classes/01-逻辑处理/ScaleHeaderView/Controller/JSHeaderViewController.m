//
//  JSHeaderViewController.m
//  HeaderViewScaleByDragging
//
//  Created by ShenYj on 16/8/16.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSHeaderViewController.h"

#define kHeaderHeight 200

@interface JSHeaderViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton *navigationButton;

@end

static NSString * const reuseId = @"Identifier";

@implementation JSHeaderViewController{

    UIView              *_headerView;           // 顶部视图
    UIImageView         *_headerImageView;      // 顶部视图中的UIImageView
    UIView              *_lineView;             // 顶部视图中底部的仿导航栏边线
    UIStatusBarStyle    _statusBarStyle;        // 顶部状态栏状态
}



- (instancetype)init{
    
    // 设置导航栏
    _statusBarStyle = UIStatusBarStyleLightContent;
    return  [super init];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    // 取消添加导航栏后控制器的自动偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 准备TableView
    [self prepareTableView];
    
    // 准备顶部视图
    [self prepareHeaderView];
    
}

#pragma mark - 准备顶部视图
- (void)prepareHeaderView{
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHeaderHeight)];
    
    [self.view addSubview:_headerView];
    
    // 顶部视图添加UIImageView
    _headerImageView = [[UIImageView alloc] initWithFrame:_headerView.bounds];
    
    [_headerView addSubview:_headerImageView];
    
    // 设置顶部视图背景色 等于 导航栏背景色
    _headerView.backgroundColor = [UIColor js_RGBColorWithRed:248 withGreen:248 withBlue:248];
    
    // 设置图像 (使用图片需要考虑性能优化)
    UIImage *image = [UIImage imageNamed:@"headerView"];
    [image js_ImageWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, kHeaderHeight) completion:^(UIImage *img) {
        
        _headerImageView.image = img;
    }];
    
    // 设置等比例拉伸
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    
#pragma mark - 在HeaderView上添加一个Button
    // 设置导航栏按钮视图
    [self prepareNavigationView];
    
#pragma mark - 添加分割线 1个像素点
    
    CGFloat lineHeight = 1 / [UIScreen mainScreen].scale;
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeaderHeight - lineHeight, _headerView.w, lineHeight)];
    
    _lineView.backgroundColor = [UIColor lightGrayColor];
    
    [_headerView addSubview:_lineView];
    
}

#pragma mark - 准备TableView
- (void)prepareTableView{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    // 设置表格的间隔
    tableView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
    
    // 设置滚动指示器的间距
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
    
}

#pragma mark - 添加模拟导航栏处的按钮

- (void)prepareNavigationView{
    
    [_headerView addSubview:self.navigationButton];
    
    [self.navigationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_headerView).mas_offset(-10);
        make.right.mas_equalTo(_headerView).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 36));
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
    }
    
    cell.textLabel.text = @(indexPath.row).description;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offSetY = scrollView.contentOffset.y + scrollView.contentInset.top;

    // 向上拉动表格
    if (offSetY > 0) {

        _headerView.h = kHeaderHeight;
        //_headerImageView.h = _headerView.h;
        
        // _headerView 滚动后的最小y值
        CGFloat minY = kHeaderHeight - 64;
        
        // 设置顶部视图Y轴坐标
        _headerView.y = -MIN(offSetY, minY);
        
        // 计算透明度
        CGFloat alpha = 1 - offSetY / minY;
        
        // 随着顶部视图向上滚动,设置透明度
        _headerImageView.alpha = alpha;
        
        // 显示导航栏的按钮
        if ( alpha <= 0.1) {
            
            self.navigationButton.alpha = 1 - alpha;
            self.navigationButton.userInteractionEnabled = YES;
        }else{
            
            self.navigationButton.alpha = 0.01;
        }
        
        
#pragma mark - 状态栏处理
        
        // 设置状态栏状态
        _statusBarStyle = (alpha < 0.5) ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
        
        // 手动更新状态栏状态
        [self.navigationController setNeedsStatusBarAppearanceUpdate];
        
    } else {  // 向下拉动表格

        // 调整HeaderView和HeaderImageView
        _headerImageView.alpha = 1;
        _headerView.y = 0;
        _headerView.h = kHeaderHeight - offSetY;
        //_headerImageView.h = _headerView.h;
        
        // 设置导航栏按钮透明度
        //self.navigationButton.alpha = 0.01;

    }
    
    // 设置头视图中的UIImageView高度
    _headerImageView.h = _headerView.h;
    
    // 设置分割线的Y轴坐标,随着顶部视图的放大而向下偏移
    _lineView.y = _headerView.h - _lineView.h;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}


#pragma mark - target

- (void)clickNavigationButton:(UIButton *)sender {
    
    NSLog(@"按钮被点击了");
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"点击导航按钮" message:@"这是模拟的导航栏按钮" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       
                                                   }];
    
    UIAlertAction *okay = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:cancel];
    [alertController addAction:okay];
    
    [self presentViewController:alertController animated:YES completion:^{
       
        
    }];
    
}

#pragma mark - 设置导航栏样式
- (UIStatusBarStyle)preferredStatusBarStyle{

    return _statusBarStyle;
}

#pragma mark - lazy

- (UIButton *)navigationButton {
    
    if (_navigationButton == nil) {
        _navigationButton = [[UIButton alloc] init];
        _navigationButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _navigationButton.alpha = 0.01;
        _navigationButton.userInteractionEnabled = NO;
        [_navigationButton setTitle:@"导航按钮" forState:UIControlStateNormal];
        [_navigationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_navigationButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_navigationButton addTarget:self action:@selector(clickNavigationButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _navigationButton;
}

@end
