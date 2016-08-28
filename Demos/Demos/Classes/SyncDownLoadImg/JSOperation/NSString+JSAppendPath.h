//
//  NSString+JSAppendPath.h
//  SyncDownLoadImg
//
//  Created by ShenYj on 16/8/25.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSAppendPath)

// 拼接沙盒存放路径
- (instancetype)js_appendCachePath;

@end
