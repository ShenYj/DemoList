//
//  JSMobViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/15.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSMobViewController.h"
#import <SMS_SDK/SMS_SDK.h>

@interface JSMobViewController ()

@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *resultLabel;
@property (nonatomic,strong) UITextField *phoneNumberInputTextField;
@property (nonatomic,strong) UITextField *authenCodeInputTextField;
@property (nonatomic,strong) UIButton *getCodeButton;
@property (nonatomic,strong) UIButton *authenButton;

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
    [self.view addSubview:self.authenCodeInputTextField];
    [self.view addSubview:self.resultLabel];
    [self.view addSubview:self.authenButton];
    [self.view addSubview:self.getCodeButton];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    
    NSArray *textFields = @[self.phoneNumberInputTextField,self.authenCodeInputTextField];
    [textFields mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:20 tailSpacing:30];
    [textFields mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailLabel.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(30);
    }];
    
    
    NSArray *buttons = @[self.getCodeButton,self.authenButton];
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:20 tailSpacing:30];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.phoneNumberInputTextField.mas_bottom).mas_offset(20);
    }];
    
    
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.authenButton.mas_bottom).mas_offset(20);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-100);
    }];
    
    

}

#pragma mark - target

- (void)clickGetCodeButton:(UIButton *)sender {
    
    
    // 1.1.0版本
    [SMS_SDK  getVerificationCodeBySMSWithPhone:self.phoneNumberInputTextField.text zone:@"86" customIdentifier:nil result:^(SMS_SDKError *error) {
        if (!error) {
            NSLog(@"获取验证码成功");
            self.resultLabel.text = @"获取验证码成功";
        } else {
            NSLog(@"错误信息：%@",error);
            self.resultLabel.text = [NSString stringWithFormat:@"获取验证码失败:%@",error];
        }
    }];
    
    /**
     *  @from                    v1.1.1
     *  @brief                   获取验证码(Get verification code)
     *
     *  @param method            获取验证码的方法(The method of getting verificationCode)
     *  @param phoneNumber       电话号码(The phone number)
     *  @param zone              区域号，不要加"+"号(Area code)
     *  @param customIdentifier  自定义短信模板标识 该标识需从官网http://www.mob.com上申请，审核通过后获得。(Custom model of SMS.  The identifier can get it  from http://www.mob.com  when the application had approved)
     *  @param result            请求结果回调(Results of the request)
     */
    
#pragma mark - 2.0.0版本
//    [SMS_SDK getVerificationCodeByMethod:SMSGetCodeMethodVoice phoneNumber:self.phoneNumberInputTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
//        
//        if (error) {
//            
//            NSLog(@"错误信息：%@",error);
//            self.resultLabel.text = @"获取验证码失败";
//            return ;
//        }
//        
//        
//        NSLog(@"获取验证码成功");
//        self.resultLabel.text = @"获取验证码成功,请查看手机";
//        
//    }];
    
    
}

- (void)clickRegisterButton:(UIButton *)sender {
    
    [SMS_SDK commitVerifyCode:self.authenCodeInputTextField.text result:^(enum SMS_ResponseState state) {
        
       
        switch (state) {
            case SMS_ResponseStateFail:
                NSLog(@"验证失败");
                self.resultLabel.text = @"验证失败";
                break;
            case SMS_ResponseStateSuccess:
                NSLog(@"验证陈宫");
                self.resultLabel.text = @"验证成功";
                break;
            default:
                break;
        }
    }];
    
    
#pragma mark - 2.0.0版本
//    [SMS_SDK commitVerificationCode:self.authenCodeInputTextField.text phoneNumber:self.phoneNumberInputTextField.text zone:@"86" result:^(NSError *error) {
//        
//        if (!error) {
//            
//            NSLog(@"验证成功");
//            self.resultLabel.text = @"验证成功";
//        }
//        else
//        {
//            NSLog(@"错误信息:%@",error);
//            self.resultLabel.text =[NSString stringWithFormat:@"获取验证码失败:%@",error];
//        }
//    }];
    
    
}

#pragma mark - lazy

- (UILabel *)detailLabel {
    
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:16];
        _detailLabel.text = @"输入手机号,点击\"短信验证\"按钮进行验证\n注意:\n这里并没有对手机号等逻辑进行处理\n需要填入正确手机号,点击获取验证码后再进行验证";
        _detailLabel.numberOfLines = 0;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.layer.borderColor = [UIColor redColor].CGColor;
        _detailLabel.layer.borderWidth = 2;
        _detailLabel.textColor = [UIColor purpleColor];
    }
    return _detailLabel;
}

- (UILabel *)resultLabel {
    
    if (_resultLabel == nil) {
        _resultLabel = [[UILabel alloc] init];
        _resultLabel.text = @"验证结果...";
        _resultLabel.textAlignment = NSTextAlignmentCenter;
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

- (UITextField *)authenCodeInputTextField {
    
    if (_authenCodeInputTextField == nil) {
        _authenCodeInputTextField = [[UITextField alloc] init];
        _authenCodeInputTextField.placeholder = @"在这里输入验证码...";
        _authenCodeInputTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _authenCodeInputTextField.layer.borderWidth = 2;
    }
    return _authenCodeInputTextField;
}

- (UIButton *)authenButton {
    
    if (_authenButton == nil) {
        _authenButton = [[UIButton alloc] init];
        [_authenButton setTitle:@"短信验证" forState:UIControlStateNormal];
        _authenButton.layer.borderColor = [UIColor js_colorWithHex:0xFFA500].CGColor;
        _authenButton.layer.borderWidth = 1;
        [_authenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_authenButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_authenButton addTarget:self action:@selector(clickRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _authenButton;
    
}

- (UIButton *)getCodeButton {
    
    if (_getCodeButton == nil) {
        _getCodeButton = [[UIButton alloc] init];
        [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeButton.layer.borderColor = [UIColor js_colorWithHex:0xFFA500].CGColor;
        _getCodeButton.layer.borderWidth = 1;
        [_getCodeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_getCodeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_getCodeButton addTarget:self action:@selector(clickGetCodeButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _getCodeButton;
}

@end
