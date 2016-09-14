//
//  JSBiometricViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/14.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSBiometricViewController.h"

@interface JSBiometricViewController ()

@property (nonatomic,strong) UILabel *decriptionLabel;

@end

@implementation JSBiometricViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareView];
}


- (void)prepareView{
    
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - lazy


- (UILabel *)decriptionLabel {
    
    if (_decriptionLabel == nil) {
        _decriptionLabel = [[UILabel alloc] init];
    }
    return _decriptionLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
