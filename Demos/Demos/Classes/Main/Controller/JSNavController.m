//
//  JSNavController.m
//  Demos
//
//  Created by ShenYj on 16/8/27.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSNavController.h"

@interface JSNavController ()

@end

@implementation JSNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // self.navigationBar.translucent = NO;
    
    self.navigationBar.barTintColor = [UIColor js_colorWithHex:0xE6E6FA];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor js_RGBColorWithRed:132 withGreen:112 withBlue:255]};
    
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
