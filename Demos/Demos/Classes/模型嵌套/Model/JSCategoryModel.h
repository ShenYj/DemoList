//
//  JSModel.h
//  模型嵌套
//
//  Created by ShenYj on 16/8/30.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSDetailModel.h"

@interface JSCategoryModel : NSObject

@property (nonatomic,assign,getter=isOpen) BOOL open;
@property (nonatomic,copy) NSString *header;
@property (nonatomic,strong) NSArray <JSDetailModel*> *demos;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)categoryWithDict:(NSDictionary *)dict;

@end
