//
//  JSDownLoadImageOperation.m
//  SyncDownLoadImg
//
//  Created by ShenYj on 16/8/24.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSDownLoadImageOperation.h"
#import "NSString+JSAppendPath.h"

@implementation JSDownLoadImageOperation

- (void)main{
    
    
    NSAssert(self.completeHandler != nil, @"completeHandler == nil");
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlString]];
    
    // 写入沙盒
    [data writeToFile:[self.urlString js_appendCachePath] atomically:YES];
    
    UIImage *image = [UIImage imageWithData:data];
    
    if (self.cancelled) {
        return;
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        self.completeHandler(image);
    }];
    
}

+ (instancetype)downLoadWithImageUrlString:(NSString *)urlString withCompleteHandler:(void (^)(UIImage *))completeHandler{
    
    JSDownLoadImageOperation *operation = [[self alloc] init];
    operation.urlString = urlString;
    operation.completeHandler = completeHandler;
    
    return operation;
}


@end
