//
//  SJFriendsFooterView.m
//  申延杰(UI基础)
//
//  Created by ShenYj on 16/4/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSFooterView.h"
#import "Masonry.h"
#import "JSFriendsModel.h"

@interface JSFooterView ()

@property (nonatomic,weak) UIButton *downLoadBtn;

@end

@implementation JSFooterView


- (instancetype)initWithFrame:(CGRect)frame{
 
    self = [super initWithFrame:frame];
    
    if (self) {
   
#pragma mark -- 下层刷新View
        
        UIView *loadView = [[UIView alloc]init];
        [self addSubview:loadView];

        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]init];
        [activityView startAnimating];
        activityView.color = [UIColor blackColor];
        
        UILabel *loadLabel = [[UILabel alloc]init];
        loadLabel.text = @"正在加载...";
        loadLabel.font = [UIFont systemFontOfSize:13];
        [loadView addSubview:loadLabel];
        [loadView addSubview:activityView];
        
        [loadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerXWithinMargins.mas_offset(0);
            make.centerYWithinMargins.mas_offset(0);
            
        }];
        [activityView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.rightMargin.mas_equalTo(loadLabel.mas_left).mas_offset(-10);
            make.width.height.mas_offset(30);
            make.centerY.mas_offset(0);// make.centerY.mas_equalTo(loadView);
            
        }];
        
        
#pragma mark -- 上层按钮View
        
        UIButton *loadBtn = [[UIButton alloc]init];
        self.downLoadBtn = loadBtn;
        
        loadBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [loadBtn setTitle:@"点击刷新" forState:UIControlStateNormal];
        [loadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        loadBtn.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:loadBtn];
        
        [loadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.right.bottom.mas_equalTo(self);
            
        }];
        
        [self bringSubviewToFront:loadBtn];
        
        [loadView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.right.bottom.mas_equalTo(self).mas_offset(0);
            
        }];
        
        [loadBtn addTarget:self action:@selector(loadBtnClickWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}


- (void)loadBtnClickWithBtn:(UIButton *)btn{
    
#pragma mark -- 随机增加一条消息
   
    btn.hidden = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        if ([self.delegate respondsToSelector:@selector(friendsFooterViewDelegateWithFooterView:)]) {
            
            [self.delegate friendsFooterViewDelegateWithFooterView:self];
            
        }
        btn.hidden = NO;
        
    });
    
}


-(NSArray *)friends{
    
    if (_friends == nil) {
        
        _friends = [JSFriendsModel friendsWithPlistFileName:@"friends"];
        
    }
    return _friends;
}


@end
