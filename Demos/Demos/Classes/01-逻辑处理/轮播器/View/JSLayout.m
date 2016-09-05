//
//  JSLayout.m
//  Demos
//
//  Created by ShenYj on 16/8/29.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSLayout.h"

@implementation JSLayout

- (void)prepareLayout{
    [super prepareLayout];
    
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

@end
