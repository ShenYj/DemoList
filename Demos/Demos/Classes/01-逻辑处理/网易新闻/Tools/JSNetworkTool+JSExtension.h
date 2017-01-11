//
//  JSNetworkTool+JSExtension.h
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/3.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSNetworkTool.h"
@class JSNewsModel;

@interface JSNetworkTool (JSExtension)

/** 请求新闻数据 */
- (void)loadNewsListDataWithUrlString:(NSString *)urlString
                       withParameters:(NSDictionary *)parameters
               withCompeletionHandler:(void (^)(NSArray *responseObject))compeletionHandler;

/** 请求ad数据 */
- (void)loadADDataWithCompeletionHandler:(void (^)(NSArray *responseObject))compeletionHandler;

@end
