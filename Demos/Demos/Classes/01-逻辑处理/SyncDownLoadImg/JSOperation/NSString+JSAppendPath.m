//
//  NSString+JSAppendPath.m
//  SyncDownLoadImg
//
//  Created by ShenYj on 16/8/25.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "NSString+JSAppendPath.h"

@implementation NSString (JSAppendPath)

// 拼接沙盒存放路径
- (instancetype)js_appendCachePath{
    
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:self.lastPathComponent];
    
}

@end
