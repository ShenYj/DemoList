//
//  JSADModel.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/4.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSADModel.h"
#import "JSNetworkTool+JSExtension.h"


@implementation JSADModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)adWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

+ (void)loadADContentWithCompeletionHandler:(void (^)(NSArray<JSADModel *> *))compeletionHandler {
    [[JSNetworkTool sharedManager] loadADDataWithCompeletionHandler:^(NSArray *responseObject) {
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            JSADModel *adModel = [JSADModel adWithDict:dict];
            [tempArr addObject:adModel];
        }
        compeletionHandler(tempArr.copy);
    }];
}

- (NSString *)description {
    NSArray *keys = [JSADModel js_objProperties];
    return [self dictionaryWithValuesForKeys:keys].description;
}



@end
