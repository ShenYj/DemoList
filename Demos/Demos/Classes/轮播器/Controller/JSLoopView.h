//
//  JSLoopView.h
//  Demos
//
//  Created by ShenYj on 16/8/29.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSLoopView : UICollectionView <UICollectionViewDelegate,UICollectionViewDataSource>
// 回传pageControl索引
@property (nonatomic,copy) void(^currentIndexHandler)(NSInteger index);

- (instancetype)initWithUrlArr:(NSArray <NSURL *> *)urls;
@end
