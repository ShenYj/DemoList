//
//  SJProvinces.h
//  键盘处理
//
//  Created by ShenYj on 16/4/24.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJProvinces : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSArray *cities;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)provincesWithDict:(NSDictionary *)dict;
+ (NSArray *)provincesWithPlistFileName:(NSString *)fileName;
@end
