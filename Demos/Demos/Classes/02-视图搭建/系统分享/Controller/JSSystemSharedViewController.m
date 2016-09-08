//
//  JSSystemSharedViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/8.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSSystemSharedViewController.h"
#import <Social/Social.h>


@interface JSSystemSharedViewController ()

@property (nonatomic,strong) UIButton *sharedButton;

@end

@implementation JSSystemSharedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareView];
}

- (void)prepareView{
    
    self.view.backgroundColor = [UIColor js_randomColor];
    
    [self.view addSubview:self.sharedButton];
    
    [self.sharedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
}

#pragma mark - target

- (void)clickSharedButton:(UIButton *)sender{
    
    SLComposeViewController *composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    
    
    UIImage *image = [UIImage imageNamed:@"IMG_3618.jpg"];
    [composeViewController addImage:image];
    
    
    [self presentViewController:composeViewController animated:YES completion:nil];
}

- (void)clickAddImageButton:(UIButton *)sender{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
}


#pragma mark - lazy


- (UIButton *)sharedButton{
    if (_sharedButton == nil) {
        _sharedButton = [[UIButton alloc] init];
        _sharedButton.layer.borderColor = [UIColor js_colorWithHex:0xFF1493].CGColor;
        _sharedButton.layer.borderWidth = 2;
        [_sharedButton setTitle:@"系统分享" forState:UIControlStateNormal];
        [_sharedButton setTitleColor:[UIColor js_randomColor] forState:UIControlStateNormal];
        [_sharedButton addTarget:self action:@selector(clickSharedButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sharedButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
