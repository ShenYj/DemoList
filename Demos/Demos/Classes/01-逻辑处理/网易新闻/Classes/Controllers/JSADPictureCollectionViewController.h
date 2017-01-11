//
//  JSADPictureCollectionViewController.h
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/7.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSADModel;

@interface JSADPictureCollectionViewController : UICollectionViewController

@property (nonatomic) NSArray <JSADModel *> *datas;

@property (nonatomic) void (^pageControlIdx)(NSInteger idx);

@end
