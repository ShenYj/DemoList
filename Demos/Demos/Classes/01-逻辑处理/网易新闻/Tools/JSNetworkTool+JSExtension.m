//
//  JSNetworkTool+JSExtension.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/3.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSNetworkTool+JSExtension.h"
#import "JSNewsModel.h"


@implementation JSNetworkTool (JSExtension)

- (void)loadNewsListDataWithUrlString:(NSString *)urlString
                       withParameters:(NSDictionary *)parameters
               withCompeletionHandler:(void (^)(NSArray *))compeletionHandler {
    
    [self GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        compeletionHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求出错:%@",error);
        compeletionHandler(nil);
    }];
}

- (void)loadADDataWithCompeletionHandler:(void (^)(NSArray *))compeletionHandler {
    
    NSString *adUrlString = @"ad/headline/0-4.html";
    [self GET:adUrlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *array = dict[dict.keyEnumerator.nextObject];
        compeletionHandler(array);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求出错:%@",error);
        compeletionHandler(nil);
    }];
}

@end
