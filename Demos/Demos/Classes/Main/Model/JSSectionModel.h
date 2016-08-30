//
//  JSSectionModel.h
//  Demos
//
//  Created by ShenYj on 16/8/30.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSSubControllerModel.h"

@interface JSSectionModel : NSObject

@property (nonatomic,assign,getter=isOpen) BOOL open;
@property (nonatomic,copy) NSString *header;
@property (nonatomic,strong) NSArray <JSSubControllerModel*> *demos;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)sectionWithDict:(NSDictionary *)dict;

+ (NSArray <JSSectionModel *> *)loadData;

@end
