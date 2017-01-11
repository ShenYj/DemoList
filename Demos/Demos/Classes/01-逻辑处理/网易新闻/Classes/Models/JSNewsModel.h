//
//  JSNewsModel.h
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/4.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NewsCellType) {
    NewsCellTypeNormal,
    NewsCellTypeImages,
    NewsCellTypeBigImg
};

@interface JSNewsModel : NSObject

/** 标题 */
@property (nonatomic,copy) NSString *title;
/** 摘要 */
@property (nonatomic,copy) NSString *digest;
/** 图片 */
@property (nonatomic,copy) NSString *imgsrc;
/** 跟帖数 */
@property (nonatomic) NSNumber *replyCount;
/** 多张配图 */
@property (nonatomic) NSArray *imgextra;
/** 大图标记 */
@property (nonatomic) NSNumber *imgType;
/** Cell样式 */
@property (assign,nonatomic) NewsCellType cellType;
/** Cell类名 */
@property (nonatomic,copy) NSString *className;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)newsWithDict:(NSDictionary *)dict;
+ (void)newsListWithUrlString:(NSString *)urlString
       withCompeletionHandler:(void (^)(NSArray <JSNewsModel *>*newsList))compeletionHandler;

@end
