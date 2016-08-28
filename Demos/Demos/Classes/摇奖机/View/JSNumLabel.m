//
//  JSNumLabel.m
//  Demos
//
//  Created by ShenYj on 16/8/28.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSNumLabel.h"

@implementation JSNumLabel

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:32];
        self.layer.borderColor = [UIColor js_randomColor].CGColor;
        self.layer.borderWidth = 2;
        
    }
    return self;
}

@end
