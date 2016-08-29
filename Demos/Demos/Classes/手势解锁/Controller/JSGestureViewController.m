//
//  ViewController.m
//  09-手势解锁
//
//  Created by Apple on 16/5/6.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "JSGestureViewController.h"
#import "UnlockView.h"

@interface JSGestureViewController ()<UnlockViewDelegate>
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UnlockView *unLockView;

@end

@implementation JSGestureViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        [self prepareView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)prepareView{
    
    //设置背景图片
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.unLockView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.top.mas_equalTo(self.view).mas_offset(84);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.unLockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 300));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(50);
    }];
    
    //设置代理
    self.unLockView.delegate = self;
}

//实现代理方法
- (void)unlockView:(UnlockView *)unLockView withPwd:(NSString *)pwd{
    
    //1.开启图形上下文对象
    UIGraphicsBeginImageContextWithOptions(self.unLockView.frame.size, NO, 0.0);
    
    //2.获取图形上下文对象
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //3.renderInContext : 把View中内容渲染到图形上下文中
    [self.unLockView.layer renderInContext:ctx];
    
    //4.从图形上下文中获取图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    //5.结束图形上下文
    UIGraphicsEndImageContext();
    
    //6.使用图片
    self.imageView.image = image;
    
    NSLog(@"%@",pwd);
}

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UnlockView *)unLockView{
    if (_unLockView == nil) {
        _unLockView = [[UnlockView alloc] init];
    }
    return _unLockView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




