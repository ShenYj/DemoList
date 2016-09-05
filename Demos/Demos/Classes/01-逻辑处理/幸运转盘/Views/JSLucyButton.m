//
//  JSLucyButton.m
//  Demos
//
//  Created by ShenYj on 16/8/29.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSLucyButton.h"

@implementation JSLucyButton

- (void)setHighlighted:(BOOL)highlighted{
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake((contentRect.size.width - 40)*0.5, 20, 40, 47);
    
}

@end
