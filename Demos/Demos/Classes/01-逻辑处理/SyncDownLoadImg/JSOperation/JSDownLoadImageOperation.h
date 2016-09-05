//
//  JSDownLoadImageOperation.h
//  SyncDownLoadImg
//
//  Created by ShenYj on 16/8/24.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JSDownLoadImageOperation : NSOperation

/**
 *  图片URL
 */
@property (nonatomic,copy) NSString *urlString;
/**
 *  完成回调
 */
@property (nonatomic,copy) void(^completeHandler)(UIImage *image);

/**
 *  类方法
 */
+ (instancetype)downLoadWithImageUrlString:(NSString *)urlString withCompleteHandler:(void(^)(UIImage *image))completeHandler;

@end
