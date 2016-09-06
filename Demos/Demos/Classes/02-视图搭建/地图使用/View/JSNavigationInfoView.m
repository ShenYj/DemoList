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
// 开始导航按钮
@property (nonatomic,strong) UIButton *startNavigationButton;

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
    
    self.backgroundColor = [UIColor js_colorWithHex:0xFFFFFF];
    
    [self addSubview:self.destinationLabel];
    [self addSubview:self.destinationTextField];
    [self addSubview:self.startNavigationButton];
    
    [self.destinationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self).mas_offset(2);
        make.bottom.mas_equalTo(self).mas_offset(-2);
        make.width.mas_equalTo(60);
    }];
    
    [self.destinationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.destinationLabel);
        make.left.mas_equalTo(self.destinationLabel.mas_right).mas_offset(2);
        make.right.mas_equalTo(self.startNavigationButton.mas_left).mas_offset(-2);
    }];
    
    [self.startNavigationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.destinationLabel);
        make.width.mas_offset(60);
        make.right.mas_equalTo(self).mas_offset(-2);
    }];
    
}

#pragma mark - Traget

- (void)clickStartNavigationButton:(UIButton *)sender{
    
    if (!self.destinationTextField.hasText) {
        NSLog(@"目标地址为空!");
        return ;
    }
    
    if ([self.delegate respondsToSelector:@selector(navigationInfoView:withDestinationString:withCompletionHandler:)]) {
        
        [self.delegate navigationInfoView:self withDestinationString:self.destinationTextField.text withCompletionHandler:nil];
    }
    
    self.hidden = YES;
}


#pragma mark - lazy

- (UILabel *)destinationLabel{
    if (_destinationLabel == nil) {
        _destinationLabel = [[UILabel alloc] init];
        _destinationLabel.font = [UIFont systemFontOfSize:11];
        _destinationLabel.text = @"目标地址:";
    }
    return _destinationLabel;
}

- (UITextField *)destinationTextField{
    if (_destinationTextField == nil) {
        _destinationTextField = [[UITextField alloc] init];
        _destinationTextField.backgroundColor = [UIColor js_colorWithHex:0xE6E6FA];
        _destinationTextField.font = [UIFont systemFontOfSize:11];
        _destinationTextField.placeholder = @"请输入目标地址...";
    }
    return _destinationTextField;
}

- (UIButton *)startNavigationButton{
    if (_startNavigationButton == nil) {
        _startNavigationButton = [[UIButton alloc] init];
        _startNavigationButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [_startNavigationButton setTitle:@"开始导航" forState:UIControlStateNormal];
        [_startNavigationButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [_startNavigationButton addTarget:self action:@selector(clickStartNavigationButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startNavigationButton;
}

@end
