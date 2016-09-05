//
//  JSDownLoadOperationManager.m
//  SyncDownLoadImg
//
//  Created by ShenYj on 16/8/25.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSDownLoadOperationManager.h"
#import "JSDownLoadImageOperation.h"
#import "NSString+JSAppendPath.h"

static id _instanceType = nil;

@implementation JSDownLoadOperationManager{
    
    NSOperationQueue             *_queue;             //  队列
    NSMutableDictionary          *_operationCache;    //  操作缓存池
    NSMutableDictionary          *_imageCache;        //  图片缓存池


}

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [[JSDownLoadOperationManager alloc] init];
        // 初始化成员变量
        [_instanceType memberShipInitialization];
    });
    return _instanceType;
}
// 成员变量实例化
- (void)memberShipInitialization{
    
    _queue = [[NSOperationQueue alloc] init];
    _operationCache = [NSMutableDictionary dictionaryWithCapacity:5];
    _imageCache = [NSMutableDictionary dictionaryWithCapacity:5];
}

- (void)downloadImageWithUrlstring:(NSString *)urlString withCompleteHandler:(void (^)(UIImage *image))completeHandler{

    /*  代码抽取
     
    // 从缓存中取出图片
    if ([_imageCache objectForKey:urlString]) {
        
        NSLog(@"从内存图片缓存池中获取图片");
        completeHandler([_imageCache objectForKey:urlString]);
        return ;
    }
    
    // 从沙盒中获取图片
    NSData *data = [NSData dataWithContentsOfFile:[_cachePath stringByAppendingPathComponent:urlString.lastPathComponent]];
    if (data) {
        
        NSLog(@"从本地沙盒获取图片:(%@)",[_cachePath stringByAppendingPathComponent:urlString.lastPathComponent]);
        completeHandler([UIImage imageWithData:data]);
        
        // 进行内存缓存
        [_imageCache setObject:[UIImage imageWithData:data] forKey:urlString];
        
        return ;
    }
     
     */
    
    // 如果缓存中存在图片,直接提取
    if ([self checkCacheWithUrlString:urlString]) {
        
        completeHandler([_imageCache objectForKey:urlString]);
        return;
    }
    
    // 避免重复下载同一张图片
    if ([_operationCache objectForKey:urlString]) {
        NSLog(@"图片正在下载中...");
        return ;
    }
    
    JSDownLoadImageOperation *downLoadImageOperation = [JSDownLoadImageOperation downLoadWithImageUrlString:urlString withCompleteHandler:^(UIImage *image) {
        
        // 完成回调
        completeHandler(image);

        // 进行内存缓存
        [_imageCache setObject:image forKey:urlString];
        
        // 清除操作缓存池中对应的操作
        [_operationCache removeObjectForKey:urlString];

    }];
    
    // 添加到队列中
    [_queue addOperation:downLoadImageOperation];
    
    // 将每一个下载图片的操作都添加到操作缓存池中(如果操作已经存在,就不再重复执行)
    [_operationCache setObject:downLoadImageOperation forKey:urlString];
    
}

// 判断缓存中是否存在要下载的图片(内存和磁盘中)
- (BOOL)checkCacheWithUrlString:(NSString *)urlString{
    
    // 内存缓存池
    if ([_imageCache objectForKey:urlString]) {
        return YES;
    }
    
    // 本地沙盒缓存
    if ([NSData dataWithContentsOfFile:[urlString js_appendCachePath]]) {
        // 进行内存缓存
        [_imageCache setObject:[UIImage imageWithData:[NSData dataWithContentsOfFile:[urlString js_appendCachePath]]] forKey:urlString];
        
        return YES;
    }

    return NO;
}

- (void)cancelOperationWithUrlString:(NSString *)urlString{
    
    // UrlString为nil时的处理,防止remove nil时crash
    if(!urlString){
        return;
    }
    
    // 取消上一个下载操作
    [_operationCache[urlString] cancel];
    
    // 将操作从缓存池中移除
    [_operationCache removeObjectForKey:urlString];
}

@end
