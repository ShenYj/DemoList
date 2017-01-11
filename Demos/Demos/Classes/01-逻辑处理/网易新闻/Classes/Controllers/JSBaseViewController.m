//
//  ViewController.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/1.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSBaseViewController.h"
#import "JSNewsItemCollectionViewFlowLayout.h"
#import "JSChannelModel.h"
#import "JSChannelLabel.h"
#import "JSNewsItemCollectionViewCell.h"



/** 频道滚动条高度 */
static CGFloat const kChannelScrollViewHeight = 44.0f;
/** 导航栏高度 */
static CGFloat const kNavigationBarHeight = 64.0f;
/** 频道Label宽度 */
static CGFloat const kChannelLabelWidth = 60.0f;
/** CollectionView重用ID */
static NSString * const newsItemCollectionViewReuseID = @"newsItemCollectionViewReuseID";
/** TableView重用ID */
static NSString * const newsTableViewViewReuseID = @"newsTableViewViewReuseID";


@interface JSBaseViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

/** 频道列表滚动条 */
@property (nonatomic) UIScrollView *channelScrollView;
/**频道对应的新闻Item*/
@property (nonatomic) UICollectionView *newsItemCollectionView;

/** 频道数据容器 */
@property (nonatomic) NSArray <JSChannelModel *>*channelDatas;
@property (nonatomic) NSMutableArray <JSChannelLabel *>*channelLabels;

@end

@implementation JSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.newsItemCollectionView registerClass:[JSNewsItemCollectionViewCell class] forCellWithReuseIdentifier:newsItemCollectionViewReuseID];
    [self.view addSubview:self.channelScrollView];
    [self.view addSubview:self.newsItemCollectionView];
    [self setUpChannelScrollView];
    
}

- (void)setUpChannelScrollView {
    [self.channelDatas enumerateObjectsUsingBlock:^(JSChannelModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @autoreleasepool {
            JSChannelModel *channelModel = (JSChannelModel *)obj;
            JSChannelLabel *channelLabel = [[JSChannelLabel alloc] init];
            [self.channelScrollView addSubview:channelLabel];
            channelLabel.text = channelModel.tname;
            CGFloat channelLabelX = idx * kChannelLabelWidth;
            channelLabel.frame = CGRectMake(channelLabelX, 0, kChannelLabelWidth, kChannelScrollViewHeight);
            // 点击手势
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickChannelLabel:)];
            channelLabel.idx = idx;
            [channelLabel addGestureRecognizer:tapGestureRecognizer];
            [self.channelLabels addObject:channelLabel];
            if (idx == 0) {
                channelLabel.scale = 1;
            }
             
        }
        
    }];
}

- (void)clickChannelLabel:(UITapGestureRecognizer *)tapGesture {
    JSChannelLabel *label = (JSChannelLabel *)tapGesture.view;
    // 滚动到指定Item
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:label.idx inSection:0];
    [self.newsItemCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.channelScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavigationBarHeight);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kChannelScrollViewHeight);
    }];
    [self.newsItemCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.channelScrollView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
}

- (NSString *)title {
    return @"网易新闻Demo";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channelDatas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JSNewsItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:newsItemCollectionViewReuseID forIndexPath:indexPath];
    JSChannelModel *channelModel = self.channelDatas[indexPath.row];
    cell.urlString = channelModel.subUrlString;
    return cell;
}

#pragma mark
#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    NSInteger leftIdx = (NSInteger)contentOffsetX / SCREEN_WIDTH;
    CGFloat rightCellScale = contentOffsetX / SCREEN_WIDTH - leftIdx;
    
    // 设置Channel视图Label缩放、颜色
    self.channelLabels[leftIdx].scale = 1 - rightCellScale;
    if (leftIdx + 1 > self.channelLabels.count) {
        return;
    }
    self.channelLabels[leftIdx + 1].scale = rightCellScale;
    
    /*  在scrollViewDidScroll:中会不断的进行计算,消耗性能
    if (self.newsItemCollectionView.visibleCells.count > 1) {
        // 滚动Channel视图Label居中
        NSArray <JSNewsItemCollectionViewCell *> *cells = [self.newsItemCollectionView.visibleCells sortedArrayUsingComparator:^NSComparisonResult(JSNewsItemCollectionViewCell *cell1, JSNewsItemCollectionViewCell *cell2 ) {
            return cell1.frame.origin.x > cell2.frame.origin.x ? NSOrderedDescending : NSOrderedDescending;
        }];
        BOOL flag = CGRectContainsPoint(cells.firstObject.frame, CGPointMake(SCREEN_WIDTH * 0.5 + scrollView.contentOffset.x, 0));
        NSInteger item = 0;
        if (flag) {
            item = [self.newsItemCollectionView indexPathForCell:cells.firstObject].item;
        } else {
            item = [self.newsItemCollectionView indexPathForCell:cells.lastObject].item;
        }
        
        JSChannelLabel *currentLabel = self.channelLabels[item];
        CGFloat contentOffsetX = currentLabel.center.x - SCREEN_WIDTH * 0.5;
        if (contentOffsetX < 0) {
            contentOffsetX = 0;
        } else if (contentOffsetX > currentLabel.bounds.size.width * self.channelLabels.count - SCREEN_WIDTH) {
            contentOffsetX = currentLabel.bounds.size.width * self.channelLabels.count - SCREEN_WIDTH;
        }
        [self.channelScrollView setContentOffset:CGPointMake(contentOffsetX, 0) animated:YES];
        self.seletedLabel = currentLabel;
    }
    */
}

/** 以动画的方式手动设置ContentOffset,会调用此代理方法(动画结束后) */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    // 1.设置居中按钮和其他按钮的状态
    NSInteger index = (NSInteger)scrollView.contentOffset.x / SCREEN_WIDTH;
    JSChannelLabel *currentLabel = self.channelLabels[index];
    
    for (JSChannelLabel *channelLabel in self.channelLabels) {
        if (channelLabel == currentLabel) {
            channelLabel.scale = 1;
        } else {
            channelLabel.scale = 0;
        }
    }
    // 2.滚动Channel视图Label居中
    CGFloat contentOffsetX = currentLabel.center.x - SCREEN_WIDTH * 0.5;
    if (contentOffsetX < 0) {
        contentOffsetX = 0;
    } else if (contentOffsetX > currentLabel.bounds.size.width * self.channelLabels.count - SCREEN_WIDTH) {
        contentOffsetX = currentLabel.bounds.size.width * self.channelLabels.count - SCREEN_WIDTH;
    }
    [self.channelScrollView setContentOffset:CGPointMake(contentOffsetX, 0) animated:YES];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}

#pragma mark
#pragma mark - lazy

- (UIScrollView *)channelScrollView {
    if (!_channelScrollView) {
        _channelScrollView = [[UIScrollView alloc] init];
        _channelScrollView.scrollEnabled = YES;
        _channelScrollView.showsVerticalScrollIndicator = NO;
        _channelScrollView.showsHorizontalScrollIndicator = NO;
        _channelScrollView.bounces = YES;
        _channelScrollView.alwaysBounceVertical = NO;
        _channelScrollView.alwaysBounceHorizontal = NO;
        _channelScrollView.contentSize = CGSizeMake(self.channelDatas.count * kChannelLabelWidth, 0);
        _channelScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _channelScrollView;
}

- (UICollectionView *)newsItemCollectionView {
    if (!_newsItemCollectionView) {
        _newsItemCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[JSNewsItemCollectionViewFlowLayout alloc] init]];
        _newsItemCollectionView.dataSource = self;
        _newsItemCollectionView.delegate = self;
        _newsItemCollectionView.backgroundColor = [UIColor js_randomColor];
    }
    return _newsItemCollectionView;
}


- (NSArray<JSChannelModel *> *)channelDatas {
    if (!_channelDatas) {
        _channelDatas = [JSChannelModel loadChannelDatas];
    }
    return _channelDatas;
}

- (NSArray<JSChannelLabel *> *)channelLabels {
    if (!_channelLabels) {
        _channelLabels = [NSMutableArray array];
    }
    return _channelLabels;
}



@end


