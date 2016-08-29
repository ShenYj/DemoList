//
//  JSEmieViewController.m
//  Demos
//
//  Created by ShenYj on 16/8/28.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSEmieViewController.h"
#import "JSNumLabel.h"
#import "JSButton.h"

@interface JSEmieViewController ()

@end

@implementation JSEmieViewController{
    
    NSOperationQueue    *_queue;
    UILabel             *_label_1;
    UILabel             *_label_2;
    UILabel             *_label_3;
    JSButton            *_button;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        [self preapareView];
    }
    return self;
}

- (void)preapareView{
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    _queue = [[NSOperationQueue alloc] init];
    _label_1 = [[JSNumLabel alloc] init];
    _label_2 = [[JSNumLabel alloc] init];
    _label_3 = [[JSNumLabel alloc] init];
    _button = [[JSButton alloc] init];
    
    
    [self.view addSubview:_label_1];
    [self.view addSubview:_label_2];
    [self.view addSubview:_label_3];
    [self.view addSubview:_button];
    
    NSArray *arr = @[_label_1,_label_2,_label_3];
    
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:5 tailSpacing:5];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(300);
        make.height.mas_equalTo(60);
    }];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_label_1.mas_bottom).mas_offset(60);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.mas_equalTo(self.view);
    }];
    
    [_button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _label_1.text = @"0";
    _label_2.text = @"0";
    _label_3.text = @"0";
    
}

- (void)clickButton:(JSButton *)sender{
    
    sender.selected = !sender.isSelected;
    // 开始
    if (sender.isSelected) {
        
        [self getRandomNumber];
        [_queue setSuspended:NO];
        
    }else{// 停止
        
        [_queue setSuspended:YES];
        
    }
    
}

- (void)getRandomNumber{
    
    [_queue addOperationWithBlock:^{
        
        while (!_queue.isSuspended) {
            
            [NSThread sleepForTimeInterval:0.05];
            
            int random_1 = arc4random() % 10;
            int random_2 = arc4random() % 10;
            int random_3 = arc4random() % 10;
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                _label_1.text = @(random_1).description;
                _label_2.text = @(random_2).description;
                _label_3.text = @(random_3).description;
            }];
            
        }
        
    }];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
