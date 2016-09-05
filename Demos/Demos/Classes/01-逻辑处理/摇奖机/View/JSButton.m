//
//  JSButton.m
//  Demos
//
//  Created by ShenYj on 16/8/28.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSButton.h"

@implementation JSButton

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self setTitle:@"开始" forState:UIControlStateNormal];
        [self setTitle:@"停止" forState:UIControlStateSelected];
        self.layer.borderColor = [UIColor js_randomColor].CGColor;
        self.layer.borderWidth = 2;
        
    }
    return self;
}

@end
