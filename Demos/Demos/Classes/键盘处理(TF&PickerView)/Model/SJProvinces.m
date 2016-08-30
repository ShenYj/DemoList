//
//  SJProvinces.m
//  键盘处理
//
//  Created by ShenYj on 16/4/24.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "SJProvinces.h"

@implementation SJProvinces

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)provincesWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}
+ (NSArray *)provincesWithPlistFileName:(NSString *)fileName{
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileName ofType:@"plist"]];
    
    NSMutableArray *marray = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        
        SJProvinces *provinces = [self provincesWithDict:dict];
        
        [marray addObject:provinces];
        
    }
    
    return marray;
}

@end
