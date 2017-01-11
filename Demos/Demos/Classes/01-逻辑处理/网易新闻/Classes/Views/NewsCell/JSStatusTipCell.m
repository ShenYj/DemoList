//
//  JSStatusTipCell.m
//  Weibo_Object-C
//
//  Created by ShenYj on 2016/11/7.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSStatusTipCell.h"

@implementation JSStatusTipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self prepareView];
    }
    return self;
}

- (void)prepareView {
    
    self.backgroundColor = [UIColor js_colorWithHex:0xFFFFFF];
    self.textLabel.textColor = [UIColor orangeColor];
    self.textLabel.text = @"世界上最遥远的距离就是没有网络...";
}

@end
