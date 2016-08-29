//
//  SJFriends.h
//  申延杰(UI基础)
//
//  Created by ShenYj on 16/4/21.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JSFriendsModel : NSObject

@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *headImg;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *picture;

@property (nonatomic,strong) UIImage *pictureImage;
@property (nonatomic,strong) UIImage *headImgImage;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)friendsWithDict:(NSDictionary *)dict;

+ (NSArray *)friendsWithPlistFileName:(NSString *)fileName;

@end
