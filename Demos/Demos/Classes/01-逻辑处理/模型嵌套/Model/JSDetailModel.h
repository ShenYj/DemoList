//
//  JSDetailModel.h
//  模型嵌套
//
//  Created by ShenYj on 16/8/30.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSDetailModel : NSObject

@property (nonatomic,copy) NSString *targetControllerClass;
@property (nonatomic,copy) NSString *detail;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)detailWithDict:(NSDictionary *)dict;

@end
