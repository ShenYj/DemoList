//
//  JSNewsItemCollectionViewFlowLayout.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/3.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSNewsItemCollectionViewFlowLayout.h"

@implementation JSNewsItemCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize = self.collectionView.bounds.size;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
}

@end
