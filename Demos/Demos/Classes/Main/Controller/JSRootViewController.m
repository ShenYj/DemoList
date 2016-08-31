//
//  RootViewController.m
//  Demos
//
//  Created by ShenYj on 16/8/27.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSRootViewController.h"
#import "JSTableViewController.h"

@interface JSRootViewController ()

@end

@implementation JSRootViewController{
    
    JSTableViewController               *_RootTableViewController;              // 子视图控制器
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self prepareView];
    }
    return self;
}

- (NSString *)title{
    return @"Demos";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)prepareView{
    
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    _RootTableViewController = [[JSTableViewController alloc] init];
    [self addChildViewController:_RootTableViewController];
    [self.view addSubview:_RootTableViewController.tableView];
    
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
