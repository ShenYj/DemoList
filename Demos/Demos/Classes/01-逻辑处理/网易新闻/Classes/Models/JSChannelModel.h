//
//  JSChannelModel.h
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/3.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSChannelModel : NSObject

/** 频道名称*/
@property (nonatomic,copy) NSString *tname;
/** tid */
@property (nonatomic,copy) NSString *tid;
/** 根据tid拼接的URL子串 */
@property (nonatomic,copy,readonly) NSString *subUrlString;

/** 实例方法、静态方法 */
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)channelWithDict:(NSDictionary *)dict;

/** 返回频道模型的数组 */ 
+ (NSArray <JSChannelModel *>*)loadChannelDatas;

@end
