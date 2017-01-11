//
//  JSNewsModel.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/4.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSNewsModel.h"
#import "JSNetworkTool+JSExtension.h"



@implementation JSNewsModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)newsWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

/** 自定义属性 --> 类型名 */
- (NSString *)className {
    if (self.imgextra.count > 0) {
        return @"JSNewsImgsTableViewCell";
    } else if (self.imgType.boolValue) {
        return @"JSNewsBigImgTableViewCell";
    } else {
        return @"JSNewsNormalTableViewCell";
    }}
/** 自定义属性 --> 自定义Cell类型 */
- (NewsCellType)cellType {
    if (self.imgextra.count > 0) {
        return NewsCellTypeImages;
    } else if (self.imgType) {
        return NewsCellTypeBigImg;
    } else {
        return NewsCellTypeNormal;
    }
}

+ (void)newsListWithUrlString:(NSString *)urlString withCompeletionHandler:(void (^)(NSArray <JSNewsModel *>*newsList))compeletionHandler {
    
    [[JSNetworkTool sharedManager] loadNewsListDataWithUrlString:urlString withParameters:nil withCompeletionHandler:^(NSArray *responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *key = dict.keyEnumerator.nextObject;
        NSArray *listArr = dict[key];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in listArr) {
            JSNewsModel *newsModel = [JSNewsModel newsWithDict:dict];
            [tempArr addObject:newsModel];
        }
        compeletionHandler(tempArr.copy);
    }];
    
}

- (NSString *)description {
    NSArray *keys = [JSNewsModel js_objProperties];
    return [self dictionaryWithValuesForKeys:keys].description;
}

@end
