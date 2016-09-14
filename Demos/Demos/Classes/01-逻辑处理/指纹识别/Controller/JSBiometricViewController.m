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

// 说明
@property (nonatomic,strong) UILabel *descriptionLabel;
// 按钮
@property (nonatomic,strong) UIButton *biometricButton;

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
    [self.view addSubview:self.biometricButton];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(70);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    
    [self.biometricButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descriptionLabel.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view).mas_offset(60);
        make.right.mas_equalTo(self.view).mas_offset(-60);
        make.height.mas_equalTo(44);
    }];
    
    
}


#pragma mark - target

- (void)clickBiometricButton:(UIButton *)sender {
    
    // 判断系统版本
    if ([[UIDevice currentDevice].systemVersion floatValue] <= 8.0) {
        
        [self showAuthenResult:@"系统没有到达要求"];
        return;
    }
    
    // 创建本地认证上下文
    LAContext *context = [[LAContext alloc] init];
    
    // 进行指纹识别
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"使用指纹进行验证" reply:^(BOOL success, NSError * _Nullable error) {
            
            if (error) {
                
                switch (error.code) {
                    case -2:
                        [self showAuthenResult:@"用户取消"];
                        break;
                    case -1: // 3次错误就会自动停止指纹识别
                        [self showAuthenResult:@"到达尝试错误次数"];
                        break;
                    case -8: // 5次错误就不再使用指纹识别
                        [self showAuthenResult:@"取消指纹识别,使用密码进行验证"];
                        break;
                        
                    default:
                        break;
                }
                
            } else {
                
                [self showAuthenResult:@"识别成功"];
                NSLog(@"识别成功");
                
            }
            
        }];
    }
    
    
    
}

// 展示认证结果
- (void)showAuthenResult:(NSString *)result {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"指纹认证:" message:result preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alertController animated:YES completion:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismissViewControllerAnimated:YES completion:nil];
        });
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
        _descriptionLabel.text = @"演示指纹识别使用:\n点击按钮,进行指纹验证.\n硬件要求:5s及以上\n系统要求:iOS 8.0及以上";
    }
    return _descriptionLabel;
}

- (UIButton *)biometricButton {
    
    if (_biometricButton == nil) {
        _biometricButton = [[UIButton alloc] init];
        _biometricButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _biometricButton.layer.borderColor = [UIColor js_colorWithHex:0xFF69B4].CGColor;
        _biometricButton.layer.borderWidth = 2;
        _biometricButton.backgroundColor = [UIColor js_colorWithHex:0xF0FFFF];
        [_biometricButton setTitleColor:[UIColor js_colorWithHex:0xA020F0] forState:UIControlStateNormal];
        [_biometricButton setTitleColor:[UIColor js_colorWithHex:0xCDC9C9] forState:UIControlStateHighlighted];
        [_biometricButton setTitle:@"开始指纹验证" forState:UIControlStateNormal];
        [_biometricButton addTarget:self action:@selector(clickBiometricButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _biometricButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
