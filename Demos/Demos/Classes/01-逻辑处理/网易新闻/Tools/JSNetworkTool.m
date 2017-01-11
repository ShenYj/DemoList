//
//  JSNetworkTool.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/3.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSNetworkTool.h"

static NSString * const baseUrlString = @"https://c.m.163.com/nc/";

@implementation JSNetworkTool

+ (instancetype)sharedManager {
    static JSNetworkTool *_instanceType = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [[JSNetworkTool alloc] initWithBaseURL:[NSURL URLWithString:baseUrlString]];
        _instanceType.responseSerializer.acceptableContentTypes = [_instanceType.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        // Https
        _instanceType.securityPolicy.validatesDomainName = NO;
    });
    return _instanceType;
}

- (void)requestMothod:(JSRequestMethod)requestMethod
        withParameter:(NSDictionary *)parameter
        withUrlString:(NSString *)urlString
withCompeletionHandler:(void (^)(id responseObject,NSError *error))compeletionHandler {
    
    if (requestMethod == JSRequestMethodGet) {
        [self GET:urlString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            compeletionHandler(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            compeletionHandler(nil,error);
        }];
    } else {
        [self POST:urlString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            compeletionHandler(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            compeletionHandler(nil,error);
        }];
    }
}

@end
