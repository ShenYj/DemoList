//
//  JSSectionHeaderView.m
//  模型嵌套
//
//  Created by ShenYj on 16/8/30.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSSectionHeadView.h"
#import "Masonry.h"

static NSString * const headerReuseId = @"header";

@interface JSSectionHeadView ()

@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UIImageView *imageV;

@end

@implementation JSSectionHeadView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView{
    
    JSSectionHeadView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseId];
    
    if (!headerView) {
        
        headerView = [[JSSectionHeadView alloc] initWithReuseIdentifier:headerReuseId];
    }
    
    return headerView;
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self prepareView];
    }
    return self;
}

- (void)prepareView{
    
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapContentView:)];
    [self.contentView addGestureRecognizer:tap];
    
    [self.contentView addSubview:self.imageV];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(5);
        make.centerY.mas_equalTo(self.contentView).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
}

- (void)TapContentView:(UITapGestureRecognizer *)sender{
    
    self.model.open = !self.model.isOpen;
    
    if (self.handler) {
        self.handler();
    }
    
}

- (void)setModel:(JSCategoryModel *)model{
    
    _model = model;
    
    self.textLabel.text = model.header;
    
    if (self.model.isOpen) {
        
        self.imageV.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        
        self.imageV.transform = CGAffineTransformIdentity;
    }
    
}



- (UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc] init];
    }
    return _button;
}
- (UIImageView *)imageV{
    if (_imageV == nil) {
        _imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buddy_header_arrow"]];
    }
    return _imageV;
}

@end
