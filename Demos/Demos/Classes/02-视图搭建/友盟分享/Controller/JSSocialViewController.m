//
//  JSSocialViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/8.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSSocialViewController.h"
#import "UMSocial.h"

//AK: 57d1559e67e58ea10200456a  (UMengSocialShared)

/* Sina
 App Key：3833247638
 App Secret：5655f7be82f952bab7ab2af537a88358
 */

@interface JSSocialViewController () <UMSocialUIDelegate>

@property (nonatomic,strong) UIButton *sharedButton;

@property (nonatomic,strong) UIButton *loginButton;

@end

@implementation JSSocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareView];
    
}


- (void)prepareView{
    
    self.view.backgroundColor = [UIColor js_randomColor];
    
    [self.view addSubview:self.sharedButton];
    [self.view addSubview:self.loginButton];
    
    [self.sharedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.mas_equalTo(self.sharedButton.mas_bottom).mas_offset(20);
    }];
}


// 分享 (分享到Sina)
- (void)sharedByUMSocial{
    
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57d1559e67e58ea10200456a"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToSina]
                                       delegate:self];
}


// 第三方登录 (Sina)
- (void)singleSignOnBySina{
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        // 获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n ",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId);
            
        }});
    
    
}


#pragma mark - lazy

- (UIButton *)sharedButton{
    if (_sharedButton == nil) {
        _sharedButton = [[UIButton alloc] init];
        _sharedButton.layer.borderColor = [UIColor js_colorWithHex:0xFF1493].CGColor;
        _sharedButton.layer.borderWidth = 2;
        [_sharedButton setTitle:@"系统分享" forState:UIControlStateNormal];
        [_sharedButton setTitleColor:[UIColor js_randomColor] forState:UIControlStateNormal];
        [_sharedButton addTarget:self action:@selector(sharedByUMSocial) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sharedButton;
}

- (UIButton *)loginButton{
    if (_loginButton == nil) {
        _loginButton = [[UIButton alloc] init];
        _loginButton.layer.borderColor = [UIColor js_colorWithHex:0xFF1493].CGColor;
        _loginButton.layer.borderWidth = 2;
        [_loginButton setTitle:@"第三方登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor js_randomColor] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(singleSignOnBySina) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
