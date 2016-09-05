//
//  JSLoopViewCell.m
//  Demos
//
//  Created by ShenYj on 16/8/29.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSLoopViewCell.h"

@implementation JSLoopViewCell{
        UIImageView       *_imageView;       // 图片框
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self prepareView];
    }
    return self;
}

- (void)setUrl:(NSURL *)url{
    _url = url;
    
    [_imageView yy_setImageWithURL:url options:YYWebImageOptionShowNetworkActivity|YYWebImageOptionHandleCookies ];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

- (void)prepareView{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageView];
}

@end
