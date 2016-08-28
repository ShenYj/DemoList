//
//  JSAppsModel.h
//  SyncDownLoadImg
//
//  Created by ShenYj on 16/8/23.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JSAppsModel : NSObject

/**
 *  app应用名称
 */
@property (nonatomic,copy) NSString *name;
/**
 *  app应用图标名称
 */
@property (nonatomic,copy) NSString *icon;
/**
 *  app下载次数
 */
@property (nonatomic,copy) NSString *download;

/**
 *  缓存的图片: 收到内存警告时不便于清理
 */
// @property (nonatomic,strong) UIImage *downloadImage;

// 创建模型对象方法
- (instancetype)initWithDict:(NSDictionary *)dict;
// 创建模型类方法
+ (instancetype)appWithDict:(NSDictionary *)dict;
// 获取模型数据类方法
+ (NSArray <JSAppsModel *> *)loadAppsData;

@end
