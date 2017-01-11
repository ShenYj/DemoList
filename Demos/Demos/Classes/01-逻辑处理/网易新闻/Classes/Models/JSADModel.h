//
//  JSADModel.h
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/4.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSADModel : NSObject


/** url */
@property (nonatomic,copy) NSString *url;
/** 标题 */
@property (nonatomic,copy) NSString *title;
/** 副标题 */
@property (nonatomic,copy) NSString *subtitle;
/** 标识 */
@property (nonatomic,copy) NSString *tag;
/** 图片地址 */
@property (nonatomic,copy) NSString *imgsrc;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)adWithDict:(NSDictionary *)dict;
+ (void)loadADContentWithCompeletionHandler:(void (^)(NSArray <JSADModel *>*responseObject))compeletionHandler;

@end
