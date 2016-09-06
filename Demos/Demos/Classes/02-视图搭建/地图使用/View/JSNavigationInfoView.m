//
//  JSNavigationInfoView.m
//  Demos
//
//  Created by ShenYj on 16/9/6.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSNavigationInfoView.h"

@interface JSNavigationInfoView ()

// 目标地址提示Label
@property (nonatomic,strong) UILabel *destinationLabel;
// 目标地址
@property (nonatomic,strong) UITextField *destinationTextField;

@end

@implementation JSNavigationInfoView

- (instancetype)init{
    self = [super init];
    if (self) {
        
        [self prepareView];
    }
    return self;
}

- (void)prepareView{
    
    [self addSubview:self.destinationLabel];
    [self addSubview:self.destinationTextField];
    
    [self.destinationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self).mas_offset(5);
        make.bottom.mas_equalTo(self).mas_offset(-5);
        make.width.mas_equalTo(60);
    }];
    
    [self.destinationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.mas_equalTo(self.destinationLabel);
        make.left.mas_equalTo(self.destinationLabel.mas_right).mas_offset(5);
        make.right.mas_equalTo(self).mas_offset(-5);
    }];
    
    
}

#pragma mark - lazy

- (UILabel *)destinationLabel{
    if (_destinationLabel == nil) {
        _destinationLabel = [[UILabel alloc] init];
        _destinationLabel.text = @"目标地址";
    }
    return _destinationLabel;
}

- (UITextField *)destinationTextField{
    if (_destinationTextField == nil) {
        _destinationTextField = [[UITextField alloc] init];
        _destinationTextField.placeholder = @"请输入目标地址...";
    }
    return _destinationTextField;
}

@end
