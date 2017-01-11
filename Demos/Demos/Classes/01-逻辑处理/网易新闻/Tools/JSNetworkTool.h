//
//  JSNetworkTool.h
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/3.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JSRequestMethod) {
    JSRequestMethodGet,
    JSRequestMethodPost
};

@interface JSNetworkTool : AFHTTPSessionManager

/** 单例 */
+ (instancetype)sharedManager;

/** 公共方法 */
- (void)requestMothod:(JSRequestMethod)requestMethod
        withParameter:(NSDictionary *)parameter
        withUrlString:(NSString *)urlString
withCompeletionHandler:(void(^)(id responseObject,NSError *error))compeletionHandler;


@end
