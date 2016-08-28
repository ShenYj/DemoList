//
//  UIImageView+JSWebCache.h
//  SyncDownLoadImg
//
//  Created by ShenYj on 16/8/25.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSDownLoadOperationManager.h"

@interface UIImageView (JSWebCache)

- (void)js_imageUrlString:(NSString *)urlString withPlaceHolderImage:(NSString *)placeHolderImage;

@end
