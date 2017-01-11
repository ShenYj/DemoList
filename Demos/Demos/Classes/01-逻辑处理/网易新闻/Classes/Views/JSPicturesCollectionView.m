//
//  JSPicturesCollectionView.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/5.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSPicturesCollectionView.h"
#import "JSNewsItemCollectionViewFlowLayout.h"
#import "JSADPictureCollectionViewCell.h"

static NSString * const collectionViewReuseIdentifier = @"collectionViewReuseIdentifier";

@interface JSPicturesCollectionView ()

/** 定时器 */
@property (nonatomic) NSTimer *timer;


@end

@implementation JSPicturesCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:[[JSNewsItemCollectionViewFlowLayout alloc] init]];
    if (self) {
        [self preparePicturesCollectionView];
    }
    return self;
}

/** 准备视图 */
- (void)preparePicturesCollectionView {
    self.backgroundColor = [UIColor whiteColor];
    [self registerClass:[JSADPictureCollectionViewCell class] forCellWithReuseIdentifier:collectionViewReuseIdentifier];
    self.dataSource = self;
    self.delegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.datas.count inSection:0];
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    });
    
    
    [self startIimer];
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
    
    NSInteger nextIndex = [self indexPathForCell:self.visibleCells.lastObject].item + 1;
    
    if (nextIndex == [self numberOfItemsInSection:0]) {
        
        nextIndex = self.datas.count;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:nextIndex inSection:0];
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    if (currentIndex == [self numberOfItemsInSection:0] - 1) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.datas.count - 1 inSection:0];
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    if (currentIndex == 0) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.datas.count inSection:0];
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
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
