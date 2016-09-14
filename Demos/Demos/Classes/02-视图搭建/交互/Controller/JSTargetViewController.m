//
//  JSTargetViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/14.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSTargetViewController.h"
#import "MJKWhiteView.h"
#import "MJKRedView.h"
#import "MJKPurpleView.h"
#import "MJKYellowView.h"
#import "MJKOrangeView.h"
#import "MJKGreenView.h"
#import "MJKBlueView.h"



@interface JSTargetViewController ()

@property (nonatomic,strong) MJKRedView *redView;
@property (nonatomic,strong) MJKPurpleView *purpleView;
@property (nonatomic,strong) MJKYellowView *yellowView;
@property (nonatomic,strong) MJKOrangeView *orangeView;
@property (nonatomic,strong) MJKGreenView *greenView;
@property (nonatomic,strong) MJKBlueView *blueView;

@end

@implementation JSTargetViewController

- (void)loadView{
 
    self.view = [[MJKWhiteView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.purpleView];
    [self.view addSubview:self.yellowView];
    [self.yellowView addSubview:self.blueView];
    [self.blueView addSubview:self.redView];
    [self.blueView addSubview:self.orangeView];
    [self.yellowView addSubview:self.greenView];
    
    
    [self.purpleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(74);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 60));
    }];
    
    [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.purpleView.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(400, 400));
    }];
    
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.yellowView).mas_offset(20);
        make.right.mas_equalTo(self.yellowView).mas_offset(-20);
        make.height.mas_equalTo(200);
    }];
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.blueView).mas_offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(120);
    }];
    
    [self.orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.blueView).mas_offset(100);
        make.height.mas_equalTo(200);
        make.left.mas_equalTo(self.redView.mas_right).mas_offset(20);
        make.right.mas_equalTo(self.blueView).mas_offset(-10);
    }];
    
    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.blueView.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.blueView);
        make.bottom.mas_equalTo(self.yellowView).mas_offset(-20);
        make.width.mas_equalTo(100);
    }];
    
    
    
}


//手指按下
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    NSLog(@"%@----touchesBegan", [self class]);
    [super touchesBegan:touches withEvent:event];
}


- (void)btnClick:(id)sender {
    NSLog(@"button click");
}

#pragma mark - lazy



- (MJKRedView *)redView {
    
    if (_redView == nil) {
        _redView = [[MJKRedView alloc] init];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

- (MJKPurpleView *)purpleView {
    
    if (_purpleView == nil) {
        _purpleView = [[MJKPurpleView alloc] init];
        _purpleView.backgroundColor = [UIColor purpleColor];
    }
    return _purpleView;
}

- (MJKYellowView *)yellowView {
    
    if (_yellowView == nil) {
        _yellowView = [[MJKYellowView alloc] init];
        _yellowView.backgroundColor = [UIColor yellowColor];
    }
    return _yellowView;
}

- (MJKOrangeView *)orangeView {
    
    if (_orangeView == nil) {
        _orangeView = [[MJKOrangeView alloc] init];
        _orangeView.backgroundColor = [UIColor orangeColor];
    }
    return _orangeView;
}

- (MJKGreenView *)greenView {
    
    if (_greenView == nil) {
        _greenView = [[MJKGreenView alloc] init];
        _greenView.backgroundColor = [UIColor greenColor];
    }
    return _greenView;
}

- (MJKBlueView *)blueView {
    
    if (_blueView == nil) {
        _blueView = [[MJKBlueView alloc] init];
        _blueView.backgroundColor = [UIColor blueColor];
    }
    return _blueView;
}

@end
