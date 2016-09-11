//
//  JSContactLabel.m
//  Demos
//
//  Created by ShenYj on 16/9/11.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

static CGFloat const kFontSize = 16;     //字体大小
static CGFloat const kBorderWidth = 2;   //边框宽度

#import "JSContactLabel.h"

@implementation JSContactLabel

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        self.font = [UIFont systemFontOfSize:kFontSize];
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = kBorderWidth;
        self.textColor = [UIColor js_randomColor];
    }
    return self;
}

@end
