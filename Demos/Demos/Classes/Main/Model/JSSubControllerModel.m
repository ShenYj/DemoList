//
//  JSSubControllerModel.m
//  Demos
//
//  Created by ShenYj on 16/8/28.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSSubControllerModel.h"

@implementation JSSubControllerModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)ModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray<JSSubControllerModel *> *)loadData{
    
    NSArray *tmpArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Property List.plist" ofType:nil]];
    
    NSMutableArray *mArr = [NSMutableArray array];
    
    for (NSDictionary *dict in tmpArr) {
        
        JSSubControllerModel *model = [JSSubControllerModel ModelWithDict:dict];
        
        [mArr addObject:model];
    }
    
    return mArr.copy;
}

@end
