//
//  JSSocialViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/8.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSSocialViewController.h"
#import "UMSocial.h"

//AK: 57d1559e67e58ea10200456a

@interface JSSocialViewController () <UMSocialUIDelegate>

@property (nonatomic,strong) UIButton *sharedButton;

@end

@implementation JSSocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareView];
    
}


- (void)prepareView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.sharedButton];
    
    [self.sharedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
}


- (void)sharedByUMSocial{
    
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57d1559e67e58ea10200456a"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToSina]
                                       delegate:self];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
