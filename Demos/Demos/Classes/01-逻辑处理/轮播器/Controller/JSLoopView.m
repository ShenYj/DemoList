//
//  JSLoopView.m
//  Demos
//
//  Created by ShenYj on 16/8/29.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSLoopView.h"
#import "JSLayout.h"
#import "JSLoopViewCell.h"

static NSString * const reuseIdentifier = @"reuseIdentifier";

@implementation JSLoopView{

    NSArray <NSURL *> *_data;           // 数据
    NSTimer           *_timer;           // 定时器
}

- (instancetype)initWithUrlArr:(NSArray <NSURL *> *)urls{
    self = [super initWithFrame:CGRectZero collectionViewLayout:[[JSLayout alloc] init]];
    if (self) {
        
        _data = urls;
        [self prepareView];
        
        self.delegate = self;
        self.dataSource = self;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_data.count inSection:0];
            [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        });
        
        
        [self startIimer];
    }
    
    return self;
}



- (void)startIimer{
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoScrollLoopView) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}
- (void)stopTimer{
    
    [_timer invalidate];
    _timer = nil;
    
}
- (void)autoScrollLoopView{

    NSInteger nextIndex = [self indexPathForCell:self.visibleCells.lastObject].item + 1;
    
    if (nextIndex == [self numberOfItemsInSection:0]) {
        
        nextIndex = _data.count;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:nextIndex inSection:0];
    
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark - 设置视图
- (void)prepareView{
    
    self.backgroundColor = [UIColor whiteColor];
    [self registerClass:[JSLoopViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
}

#pragma mark = UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _data.count * 100;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JSLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.url = _data[indexPath.item % _data.count];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger currentPageIndex = (NSInteger)( (offsetX + self.bounds.size.width*0.5) / self.bounds.size.width ) % _data.count;
    
    if (self.currentIndexHandler) {
        
        self.currentIndexHandler(currentPageIndex);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger currentIndex = scrollView.contentOffset.x / SCREEN_SIZE.width;
    
    if (currentIndex == [self numberOfItemsInSection:0] - 1) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_data.count - 1 inSection:0];
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    
    if (currentIndex == 0) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_data.count inSection:0];
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
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
    [_timer invalidate];
    _timer = nil;
}

@end
