//
//  JSBiometricViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/14.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSBiometricViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface JSBiometricViewController ()

@property (nonatomic,strong) UILabel *descriptionLabel;

@end

@implementation JSBiometricViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareView];
}


- (void)prepareView{
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.descriptionLabel];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(70);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    
    
}


#pragma mark - lazy


- (UILabel *)descriptionLabel {
    
    if (_descriptionLabel == nil) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont systemFontOfSize:16];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionLabel.backgroundColor = [UIColor js_colorWithHex:0xFF69B4];
        _descriptionLabel.textColor = [UIColor js_colorWithHex:0x1E90FF];
        _descriptionLabel.text = @"演示指纹识别使用:\n点击按钮,进行指纹验证.";
    }
    return _descriptionLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
