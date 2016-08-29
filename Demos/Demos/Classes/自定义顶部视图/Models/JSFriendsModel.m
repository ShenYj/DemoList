//
//  SJFriends.m
//  申延杰(UI基础)
//
//  Created by ShenYj on 16/4/21.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSFriendsModel.h"

@implementation JSFriendsModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    
    if (self) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)friendsWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}

+(NSArray *)friendsWithPlistFileName:(NSString *)fileName{
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileName ofType:@"plist"]];
    
    NSMutableArray *marray = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        
        [marray addObject:[self friendsWithDict:dict]];
    }
    return marray;
}

- (UIImage *)pictureImage{
    
    if (_pictureImage == nil) {
        
        _pictureImage = [UIImage imageNamed:self.picture];
    }
    return _pictureImage;
    
}
- (UIImage *)headImgImage{
    
    if (_headImgImage == nil) {
        
        _headImgImage = [UIImage imageNamed:self.headImg];
    }
    return _headImgImage;
}

@end
