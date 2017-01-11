//
//  JSChannelModel.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/3.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSChannelModel.h"

@implementation JSChannelModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)channelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NSArray <JSChannelModel *>*)loadChannelDatas {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"解析失败:%@",error);
    }
    NSArray *tListArr = dict[@"tList"];
    NSMutableArray <JSChannelModel *>*tempArr = [NSMutableArray array];
    for (NSDictionary *dict in tListArr) {
        JSChannelModel *channelModel = [self channelWithDict:dict];
        [tempArr addObject:channelModel];
    }
    [tempArr sortUsingComparator:^NSComparisonResult(JSChannelModel *obj1, JSChannelModel *obj2) {
        return [obj1.tid compare:obj2.tid options:NSNumericSearch];
    }];
    return tempArr.copy;
}

- (void)setTid:(NSString *)tid {
    _tid = tid;
    _subUrlString = [NSString stringWithFormat:@"article/list/%@/0-20.html",tid];
}

- (NSString *)description {
    NSArray *keys = [JSChannelModel js_objProperties];
    return [self dictionaryWithValuesForKeys:keys].description;
}

@end
