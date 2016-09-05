//
//  JSAppsModel.m
//  SyncDownLoadImg
//
//  Created by ShenYj on 16/8/23.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSAppsModel.h"

@implementation JSAppsModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)appWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

- (NSString *)description{
    
    NSArray *keys = @[@"name",@"icon",@"download"];
    
    return [self dictionaryWithValuesForKeys:keys].description;
    
}

+ (NSArray <JSAppsModel *> *)loadAppsData{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"];
    
    NSLog(@"%@",filePath);
    
    NSArray *data = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray *mArr = [NSMutableArray array];
    
    for (NSDictionary *dict in data) {
        
        JSAppsModel *model = [self appWithDict:dict];
        
        [mArr addObject:model];
    }
    
    return mArr.copy;
}


@end
