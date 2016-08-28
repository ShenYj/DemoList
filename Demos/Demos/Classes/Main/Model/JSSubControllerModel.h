//
//  JSSubControllerModel.h
//  Demos
//
//  Created by ShenYj on 16/8/28.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSubControllerModel : NSObject

// 目标控制器类型
@property (nonatomic,copy) NSString *targetControllerClass;
// 目标控制器名称
@property (nonatomic,copy) NSString *detail;


// 实例方法
- (instancetype)initWithDict:(NSDictionary *)dict;
// 类方法
+ (instancetype)ModelWithDict:(NSDictionary *)dict;

+ (NSArray <JSSubControllerModel *> *)loadData;

@end
