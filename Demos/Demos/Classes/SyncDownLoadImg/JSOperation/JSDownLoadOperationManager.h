//
//  JSDownLoadOperationManager.h
//  SyncDownLoadImg
//
//  Created by ShenYj on 16/8/25.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JSDownLoadOperationManager : NSObject

/*
 *   1.管理全局下载操作
 *   2.管理全局图片缓存
 */

// 单例
+ (instancetype)sharedManager;

// 图片下载实例方法
- (void)downloadImageWithUrlstring:(NSString *)urlString withCompleteHandler:(void (^)(UIImage *image))completeHandler;

// 取消操作
- (void)cancelOperationWithUrlString:(NSString *)urlString;

@end
