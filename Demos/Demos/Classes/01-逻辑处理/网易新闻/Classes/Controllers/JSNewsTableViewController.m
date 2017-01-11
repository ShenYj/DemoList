//
//  JSNewsTableViewController.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/4.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSNewsTableViewController.h"
#import "JSNewsModel.h"
#import "JSADModel.h"
#import "JSNewsNormalTableViewCell.h"
#import "JSNewsImgsTableViewCell.h"
#import "JSNewsBigImgTableViewCell.h"
#import "JSStatusTipCell.h"
#import "JSRefreshControl.h"
#import "JSPicturesCollectionView.h"
#import "MJRefresh.h"

#import "JSNewsItemCollectionViewFlowLayout.h"
#import "JSADPictureCollectionViewController.h"

/** 普通样式的Cell高度 */
CGFloat const kNewsNormalCellHeight = 80.f;
/** 多图样式的Cell高度 */
CGFloat const kNewsImgsCellHeight = 120.f;
/** 大图样式的Cell高度 */
CGFloat const kNewsBigImgCellHeigh = 180.f;
/** 网络状态警示Cell高度 */
CGFloat const kNewsStatusTipCellHeight = 44.f;
/** 轮播器高度 */
static CGFloat const kADPicturesCollectionViewHeight = 200.f;

/** Cell中的间距 */
CGFloat const kNewsCellMargin = 8.f;

/** Cell重用标识 */
static NSString * const newsNormalReuseIdentifier = @"newsNormalReuseIdentifier";
static NSString * const newsImgsReuseIdentifier = @"newsImgsReuseIdentifier";
static NSString * const newsBigImgReuseIdentifier = @"newsBigImgReuseIdentifier";
static NSString * const newsStatusTipReuseIdentifier = @"newsStatusTipReuseIdentifier";

@interface JSNewsTableViewController ()

/** 轮播器 */
//@property (nonatomic) JSPicturesCollectionView *adPicturesView;
@property (nonatomic) JSADPictureCollectionViewController *adPicturesViewController;
/** 新闻数据容器 */
@property (nonatomic) NSArray <JSNewsModel *> *newsList;
/** 下拉刷新控件 */
//@property (nonatomic) JSRefreshControl *js_refreshControl;
/** PageControl */
@property (nonatomic) UIPageControl *pageControl;
/** 头部视图容器 */
@property (nonatomic) UIView *headerView;
@end

@implementation JSNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 监听网络变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkReachabilityDidChanged) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    
    [self.tableView registerClass:[JSNewsNormalTableViewCell class] forCellReuseIdentifier:newsNormalReuseIdentifier];
    [self.tableView registerClass:[JSNewsImgsTableViewCell class] forCellReuseIdentifier:newsImgsReuseIdentifier];
    [self.tableView registerClass:[JSNewsBigImgTableViewCell class] forCellReuseIdentifier:newsBigImgReuseIdentifier];
    [self.tableView registerClass:[JSStatusTipCell class] forCellReuseIdentifier:newsStatusTipReuseIdentifier];
    
    /*
    [self.tableView addSubview:self.js_refreshControl];
    [self.js_refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
   */
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSArray *array = [NSArray arrayWithArray:self.newsList];
            NSArray *moreArray = [self.newsList arrayByAddingObjectsFromArray:array];
            self.newsList = moreArray;
        });
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kADPicturesCollectionViewHeight)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    [JSADModel loadADContentWithCompeletionHandler:^(NSArray<JSADModel *> *responseObject) {
        //weakSelf.adPicturesView.datas = responseObject;
        weakSelf.adPicturesViewController.datas = responseObject;
        [weakSelf addChildViewController:self.adPicturesViewController];
        [weakSelf.headerView addSubview:weakSelf.adPicturesViewController.collectionView];
        
        [weakSelf.headerView addSubview:weakSelf.pageControl];
        [weakSelf.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.headerView);
            make.right.mas_equalTo(weakSelf.headerView).mas_offset(-10);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
        weakSelf.pageControl.numberOfPages = responseObject.count;
        [weakSelf.adPicturesViewController setPageControlIdx:^(NSInteger idx) {
            weakSelf.pageControl.currentPage = idx;
        }];
    }];
    
    self.tableView.tableHeaderView = self.headerView;
    
}

- (void)networkReachabilityDidChanged {
    [self.tableView reloadData];
}

- (void)loadData {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __weak typeof(self) weakSelf = self;
        [JSNewsModel newsListWithUrlString:self.urlString withCompeletionHandler:^(NSArray<JSNewsModel *> *newsList) {
            [weakSelf.tableView.mj_header endRefreshing];
            weakSelf.newsList = newsList;
            if (weakSelf.newsList.count > 0) {
                [weakSelf.tableView reloadData];
            }
        }];
    });
    /*
    [self.js_refreshControl beginRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __weak typeof(self) weakSelf = self;
        [JSNewsModel newsListWithUrlString:self.urlString withCompeletionHandler:^(NSArray<JSNewsModel *> *newsList) {
            [weakSelf.js_refreshControl endRefresh];
            weakSelf.newsList = newsList;
            if (weakSelf.newsList.count > 0) {
                [weakSelf.tableView reloadData];
            }
        }];
    });
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    
    // MJ
    [self.tableView.mj_header beginRefreshing];
    __weak typeof(self) weakSelf = self;
    [JSNewsModel newsListWithUrlString:urlString withCompeletionHandler:^(NSArray<JSNewsModel *> *newsList) {
        weakSelf.newsList = newsList;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
    /* 自定义下拉刷新
    [self.js_refreshControl beginRefresh];
    __weak typeof(self) weakSelf = self;
    [JSNewsModel newsListWithUrlString:urlString withCompeletionHandler:^(NSArray<JSNewsModel *> *newsList) {
        weakSelf.newsList = newsList;
        [weakSelf.tableView reloadData];
        [weakSelf.js_refreshControl endRefresh];
    }];
    */
}

#pragma mark
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [AFNetworkReachabilityManager sharedManager].isReachable ? 0 : 1;
    }
    return self.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JSNewsModel *newsModel = self.newsList[indexPath.row];
    
    if (indexPath.section == 0) {
        return [tableView dequeueReusableCellWithIdentifier:newsStatusTipReuseIdentifier forIndexPath:indexPath];
    }
    
    if (newsModel.cellType == NewsCellTypeNormal) {
        JSNewsNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsNormalReuseIdentifier forIndexPath:indexPath];
        cell.newsModel = newsModel;
        return cell;
    } else if (newsModel.cellType == NewsCellTypeImages) {
        JSNewsImgsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsImgsReuseIdentifier forIndexPath:indexPath];
        cell.newsModel = newsModel;
        return cell;
    } else {
        JSNewsBigImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsBigImgReuseIdentifier forIndexPath:indexPath];
        cell.newsModel = newsModel;
        return cell;
    }
    
}

#pragma mark
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return kNewsStatusTipCellHeight;
    }
    
    JSNewsModel *newsModel = self.newsList[indexPath.row];
    if (newsModel.cellType == NewsCellTypeNormal) {
        return kNewsNormalCellHeight;
    } else if (newsModel.cellType == NewsCellTypeImages) {
        return kNewsImgsCellHeight;
    } else {
        return kNewsBigImgCellHeigh;
    }
}


#pragma mark 
#pragma mark - lazy
/*
- (JSRefreshControl *)js_refreshControl {
    if (!_js_refreshControl) {
        _js_refreshControl = [[JSRefreshControl alloc] init];
    }
    return _js_refreshControl;
}
*/

- (JSADPictureCollectionViewController *)adPicturesViewController {
    if (!_adPicturesViewController) {
        _adPicturesViewController = [[JSADPictureCollectionViewController alloc] initWithCollectionViewLayout:[[JSNewsItemCollectionViewFlowLayout alloc] init]];
        _adPicturesViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, kADPicturesCollectionViewHeight);
    }
    return _adPicturesViewController;
}

/*
- (JSPicturesCollectionView *)adPicturesView {
    if (!_adPicturesView) {
        _adPicturesView = [[JSPicturesCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kADPicturesCollectionViewHeight)];
    }
    return _adPicturesView;
}
 */

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPage = 0;
        //_pageControl.backgroundColor = [UIColor redColor];
        [_pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"_pageImage"];
        [_pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];
    }
    return _pageControl;
}

@end
