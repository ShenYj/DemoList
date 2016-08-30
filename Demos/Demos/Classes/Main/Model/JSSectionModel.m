//
//  JSSectionModel.m
//  Demos
//
//  Created by ShenYj on 16/8/30.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSSectionModel.h"

@implementation JSSectionModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)sectionWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


- (void)setDemos:(NSArray<JSSubControllerModel *> *)demos{
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSDictionary *dict in demos) {
        JSSubControllerModel *model = [JSSubControllerModel ModelWithDict:dict];
        [tempArr addObject:model];
    }
    _demos = tempArr.copy;
    
}

+ (NSArray<JSSectionModel *> *)loadData{
    
    NSArray *tmpArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Demos.plist" ofType:nil]];
    
    NSMutableArray *mArr = [NSMutableArray array];
    
    for (NSDictionary *dict in tmpArr) {
        
        JSSectionModel *model = [JSSectionModel sectionWithDict:dict];
        
        [mArr addObject:model];
    }
    
    return mArr.copy;
}

@end
