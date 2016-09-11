//
//  JSContactModel.h
//  Demos
//
//  Created by ShenYj on 16/9/11.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSContactModel : NSObject


// Contact的部分属性
@property (nonatomic, copy) NSString *namePrefix;
@property (nonatomic, copy) NSString *givenName;
@property (nonatomic, copy) NSString *middleName;
@property (nonatomic, copy) NSString *familyName;
@property (nonatomic, copy) NSString *previousFamilyName;
@property (nonatomic, copy) NSString *nameSuffix;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *phoneticGivenName;
@property (nonatomic, copy) NSString *phoneticMiddleName;
@property (nonatomic, copy) NSString *phoneticFamilyName;
@property (nonatomic, copy) NSString *organizationName;
@property (nonatomic, copy) NSString *departmentName;
@property (nonatomic, copy) NSString *jobTitle;
@property (nonatomic, copy) NSString *note;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)contactModelWithDict:(NSDictionary *)dict;

@end
