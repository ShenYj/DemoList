//
//  JSDetailModel.m
//  模型嵌套
//
//  Created by ShenYj on 16/8/30.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSDetailModel.h"

@implementation JSDetailModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)detailWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
