//
//  JSChangeSkinViewController.m
//  Demos
//
//  Created by ShenYj on 2016/10/10.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

/*
 http://hbimg.b0.upaiyun.com/f4b2f8d83014dd460cdb4d0712210f5fbb5caf211e424-z32BlP_fw658
 http://hbimg.b0.upaiyun.com/4225f0168f6b9b54d771a042606010efbd5de19f9be28-t8umOo_fw658
 */


#import "JSChangeSkinViewController.h"

@interface JSChangeSkinViewController ()

// 演示图片框
@property (nonatomic) UIImageView *picImageView;
// 切换开关
@property (nonatomic) UISwitch *isNightSwitch;
// 描述信息
@property (nonatomic) UILabel *detailLabel;

@property (nonatomic) NSMutableDictionary *imageCache;

@end

@implementation JSChangeSkinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.isNightSwitch.on = [userDefault boolForKey:@"isNight"];
    
    // 准备视图
    [self prepareView];
    
    // 设置图片
    [self downImageWithFlag:self.isNightSwitch.isOn];
    
    
}

- (void)prepareView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.picImageView];
    [self.view addSubview:self.isNightSwitch];
    [self.view addSubview:self.detailLabel];
    
    
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(74);
        make.size.mas_equalTo(CGSizeMake(380, 560));
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.isNightSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.picImageView.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self.picImageView);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.isNightSwitch.mas_bottom).mas_offset(10);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    
}

- (void)downImageWithFlag:(BOOL)isNight {
    
    [[NSUserDefaults standardUserDefaults] setBool:isNight forKey:@"isNight"];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURL *url_Night = [NSURL URLWithString:@"http://hbimg.b0.upaiyun.com/f4b2f8d83014dd460cdb4d0712210f5fbb5caf211e424-z32BlP_fw658"];
        NSURL *url_Light = [NSURL URLWithString:@"http://hbimg.b0.upaiyun.com/4225f0168f6b9b54d771a042606010efbd5de19f9be28-t8umOo_fw658"];
        NSData *imageData = nil;
        
        if (isNight) {
            
            imageData = [NSData dataWithContentsOfURL:url_Night];
            
        } else {
            
            imageData = [NSData dataWithContentsOfURL:url_Light];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 设置图片
            self.picImageView.image = [UIImage imageWithData:imageData];
        });
        
        
    });
    
    
}




#pragma mark 
#pragma mark - target

- (void)clickIsNightSwitch:(UISwitch *)isNight {
    
    [[NSUserDefaults standardUserDefaults] setBool:isNight.isOn forKey:@"isNight"];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURL *url_Night = [NSURL URLWithString:@"http://hbimg.b0.upaiyun.com/f4b2f8d83014dd460cdb4d0712210f5fbb5caf211e424-z32BlP_fw658"];
        NSURL *url_Light = [NSURL URLWithString:@"http://hbimg.b0.upaiyun.com/4225f0168f6b9b54d771a042606010efbd5de19f9be28-t8umOo_fw658"];
        NSData *imageData = nil;
        
        if (isNight.isOn) {
            
            imageData = [NSData dataWithContentsOfURL:url_Night];
            
        } else {
            
            imageData = [NSData dataWithContentsOfURL:url_Light];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 设置图片
            self.picImageView.image = [UIImage imageWithData:imageData];
        });
        
        
    });

    
}

#pragma mark 
#pragma mark - lazy

- (UILabel *)detailLabel {
    
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.font = [UIFont systemFontOfSize:15];
        _detailLabel.textColor = [UIColor purpleColor];
        _detailLabel.text = @"通过运行时实现换肤功能\n";
    }
    return _detailLabel;
}

- (UISwitch *)isNightSwitch {
    
    if (_isNightSwitch == nil) {
        _isNightSwitch = [[UISwitch alloc] init];
        [_isNightSwitch addTarget:self action:@selector(clickIsNightSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _isNightSwitch;
}

- (UIImageView *)picImageView {
    
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc] init];
        _picImageView.contentMode = UIViewContentModeScaleAspectFill;
        _picImageView.clipsToBounds = YES;
        //[_picImageView yy_setImageWithURL:[NSURL URLWithString:@"http://hbimg.b0.upaiyun.com/f4b2f8d83014dd460cdb4d0712210f5fbb5caf211e424-z32BlP_fw658"] options:0];
        
    }
    return _picImageView;
}

- (NSMutableDictionary *)imageCache {
    
    if (_imageCache == nil) {
        _imageCache = [NSMutableDictionary dictionaryWithCapacity:5];
    }
    return _imageCache;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    NSLog(@"%s",__func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
