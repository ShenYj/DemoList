//
//  JSLoopRootViewController.m
//  Demos
//
//  Created by ShenYj on 16/8/29.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSLoopRootViewController.h"
#import "JSLoopView.h"

@interface JSLoopRootViewController ()

@end

@implementation JSLoopRootViewController{
    
    NSArray <NSURL *>   *_dataArr;
    JSLoopView          *_loopView;        // 无限轮播器视图
    UIPageControl       *_pageControl;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self prepareView];
    
}

- (void)prepareView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _loopView = [[JSLoopView alloc] initWithUrlArr:_dataArr];
    [self.view addSubview:_loopView];
    
    [_loopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(64);
    }];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = _dataArr.count;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [self.view addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.bottom.mas_equalTo(self.view).mas_offset(-40);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(10);
    }];
    
    // 设置PageControl
    __weak typeof(_pageControl) weakPageControl = _pageControl;
    [_loopView setCurrentIndexHandler:^(NSInteger index) {
        __strong typeof(weakPageControl) strongPageControl = weakPageControl;
        if (strongPageControl) {
            
            strongPageControl.currentPage = index;
        }
        
    }];
    
}

- (void)loadData{
    
    NSURL *url_1 = [NSURL URLWithString:@"http://hbimg.b0.upaiyun.com/bce558e7aed0df53ca381d33f004d0e2f282b76b225f0-3PSp5g_fw658"];
    NSURL *url_2 = [NSURL URLWithString:@"http://hbimg.b0.upaiyun.com/ec140e8e2b99cb848acac892a5a4abf2b8d2dc9419f28-PuLofD_fw658"];
    NSURL *url_3 = [NSURL URLWithString:@"http://hbimg.b0.upaiyun.com/24cb525e25897723d1d45c1d4330c43441cea8ce42f23-IQnbmL_fw658"];
    NSURL *url_4 = [NSURL URLWithString:@"http://hbimg.b0.upaiyun.com/c5621f5ef3802176f37701d4c2760d1ecabb90363962b-5b0pYW_fw658"];
    NSURL *url_5 = [NSURL URLWithString:@"http://hbimg.b0.upaiyun.com/bde3d6910d57314bf2a90f2363ca62283d507335372ac-IXz7QC_fw658"];
    
    _dataArr = @[url_1,url_2,url_3,url_4,url_5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
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
