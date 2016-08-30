//
//  JSModel.m
//  模型嵌套
//
//  Created by ShenYj on 16/8/30.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSCategoryModel.h"


@implementation JSCategoryModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)categoryWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (void)setDemos:(NSArray<JSDetailModel *> *)demos{
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSDictionary *dict in demos) {
        JSDetailModel *model = [JSDetailModel detailWithDict:dict];
        [tempArr addObject:model];
    }
    _demos = tempArr.copy;
    
}
@end
