//
//  JSMobViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/15.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSMobViewController.h"

@interface JSMobViewController ()

@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *resultLabel;
@property (nonatomic,strong) UITextField *phoneNumberInputTextField;
@property (nonatomic,strong) UIButton *registerButton;

@end

@implementation JSMobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareView];
}



- (void)prepareView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.detailLabel];
    [self.view addSubview:self.phoneNumberInputTextField];
    [self.view addSubview:self.resultLabel];
    [self.view addSubview:self.registerButton];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(80);
        make.left.right.mas_equalTo(self.view);
    }];
    
    [self.phoneNumberInputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailLabel.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneNumberInputTextField.mas_bottom).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 44));
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.registerButton.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];

}

#pragma mark - target

- (void)clickRegisterButton:(UIButton *)sender {
 
    
}


#pragma mark - lazy

- (UILabel *)detailLabel {
    
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:16];
        _detailLabel.text = @"输入手机号,点击\"短信验证\"按钮进行验证";
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _detailLabel.layer.borderWidth = 2;
        _detailLabel.textColor = [UIColor js_colorWithHex:0x90EE90];
    }
    return _detailLabel;
}

- (UILabel *)resultLabel {
    
    if (_resultLabel == nil) {
        _resultLabel = [[UILabel alloc] init];
        _resultLabel.font = [UIFont systemFontOfSize:18];
        _resultLabel.layer.borderColor = [UIColor redColor].CGColor;
        _resultLabel.layer.borderWidth = 2;
        _resultLabel.textColor = [UIColor redColor];
    }
    return _resultLabel;
}

- (UITextField *)phoneNumberInputTextField {
    
    if (_phoneNumberInputTextField == nil) {
        _phoneNumberInputTextField = [[UITextField alloc] init];
        _phoneNumberInputTextField.placeholder = @"在这里输入手机号...";
        _phoneNumberInputTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _phoneNumberInputTextField.layer.borderWidth = 2;
    }
    return _phoneNumberInputTextField;
}

- (UIButton *)registerButton {
    
    if (_registerButton == nil) {
        _registerButton = [[UIButton alloc] init];
        [_registerButton setTitle:@"短信验证" forState:UIControlStateNormal];
        _registerButton.layer.borderColor = [UIColor blackColor].CGColor;
        _registerButton.layer.borderWidth = 1;
        [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_registerButton addTarget:self action:@selector(clickRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
    
}

@end
