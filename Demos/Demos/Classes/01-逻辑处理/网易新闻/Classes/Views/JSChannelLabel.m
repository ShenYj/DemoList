//
//  JSChannelLabel.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/3.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSChannelLabel.h"

@implementation JSChannelLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
        self.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

-(void)setScale:(CGFloat)scale {
    _scale = scale;
    CGFloat red = scale;
    CGFloat green = 0.f;
    CGFloat blue = 0.f;
    self.textColor = [UIColor colorWithDisplayP3Red:red green:green blue:blue alpha:1.0];
    self.transform = CGAffineTransformMakeScale( 1 + scale * 0.3, 1 + scale * 0.3 );
    
}

@end
