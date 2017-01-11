//
//  JSPicturesCollectionView.h
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/5.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSADModel.h"


@interface JSPicturesCollectionView : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegate>
/** 数据容器 */
@property (nonatomic) NSArray <JSADModel *> *datas;
//- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout datas:( NSArray <JSADModel *> *)datas;

@end
