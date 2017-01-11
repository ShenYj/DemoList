//
//  JSADPictureCollectionViewController.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/7.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSADPictureCollectionViewController.h"
#import "JSNewsItemCollectionViewFlowLayout.h"
#import "JSADPictureCollectionViewCell.h"


static NSString * const collectionViewReuseIdentifier = @"collectionViewReuseIdentifier";


@interface JSADPictureCollectionViewController ()

/** 定时器 */
@property (nonatomic) NSTimer *timer;

@end

@implementation JSADPictureCollectionViewController


- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithCollectionViewLayout:[[JSNewsItemCollectionViewFlowLayout alloc] init]];
    if (self) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.datas.count inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        });
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[JSADPictureCollectionViewCell class] forCellWithReuseIdentifier:collectionViewReuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self preparePicturesCollectionView];
}

/** 准备视图 */
- (void)preparePicturesCollectionView {
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[JSADPictureCollectionViewCell class] forCellWithReuseIdentifier:collectionViewReuseIdentifier];
    [self startIimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startIimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoScrollLoopView) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

- (void)stopTimer{
    
    [_timer invalidate];
    _timer = nil;
}

- (void)autoScrollLoopView{
    NSInteger nextIndex = [self.collectionView indexPathForCell:self.collectionView.visibleCells.lastObject].item + 1;
    if (nextIndex == [self.collectionView numberOfItemsInSection:0]) {
        nextIndex = self.datas.count;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:nextIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark
#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count * 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSADPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewReuseIdentifier forIndexPath:indexPath];
    cell.model = self.datas[indexPath.item % self.datas.count];
    return cell;
}


#pragma mark
#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentIdx = (scrollView.contentOffset.x + SCREEN_WIDTH*0.5) / SCREEN_WIDTH;
    if (self.pageControlIdx) {
        self.pageControlIdx(currentIdx%self.datas.count);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    if (currentIndex == [self.collectionView numberOfItemsInSection:0] - 1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.datas.count - 1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    if (currentIndex == 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.datas.count inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    
}

// 停止拖拽时,开启定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startIimer];
}
// 当开始拖拽时,停止停止器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}


@end
