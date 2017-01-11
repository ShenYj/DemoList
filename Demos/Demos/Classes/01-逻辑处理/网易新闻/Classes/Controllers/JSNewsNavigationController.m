//
//  JSNavigationController.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/2.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSNewsNavigationController.h"

@interface JSNewsNavigationController ()

@end

@implementation JSNewsNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor js_colorWithHex:0xFFFAFA]}];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
