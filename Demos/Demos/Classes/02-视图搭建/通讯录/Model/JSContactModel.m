//
//  JSContactModel.m
//  Demos
//
//  Created by ShenYj on 16/9/11.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSContactModel.h"

@implementation JSContactModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)contactModelWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (NSString *)description{
    
    NSArray *keys = [JSContactModel js_objProperties];
    return [self dictionaryWithValuesForKeys:keys].description;
}

@end
