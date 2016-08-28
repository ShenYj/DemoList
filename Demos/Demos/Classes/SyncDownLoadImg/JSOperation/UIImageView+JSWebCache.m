//
//  UIImageView+JSWebCache.m
//  SyncDownLoadImg
//
//  Created by ShenYj on 16/8/25.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "UIImageView+JSWebCache.h"
#import "JSDownLoadOperationManager.h"
#import <objc/runtime.h>

@interface UIImageView ()

// 记录当前图片UrlString
@property (nonatomic,copy) NSString *currentIconString;

@end


@implementation UIImageView (JSWebCache)


- (void)js_imageUrlString:(NSString *)urlString withPlaceHolderImage:(NSString *)placeHolderImage{
    
    self.image = [UIImage imageNamed:placeHolderImage];
    
    // 取消之前图片的下载操作
    if ( ![urlString isEqualToString:self.currentIconString] ) {
        
        [[JSDownLoadOperationManager sharedManager] cancelOperationWithUrlString:self.currentIconString];
    }
    self.currentIconString = urlString;
    
    [[JSDownLoadOperationManager sharedManager] downloadImageWithUrlstring:urlString withCompleteHandler:^(UIImage *image) {
        
        self.image = image;
        
    }];
}

- (void)setCurrentIconString:(NSString *)currentIconString{
    
    objc_setAssociatedObject(self, "currentIconString", currentIconString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)currentIconString{
    
    return objc_getAssociatedObject(self, "currentIconString");
}

@end
