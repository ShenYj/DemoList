//
//  JSEmieViewController.m
//  Demos
//
//  Created by ShenYj on 16/8/28.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSEmieViewController.h"

@interface JSEmieViewController ()

@end

@implementation JSEmieViewController{
    
    UILabel             *label_1;
    UILabel             *label_2;
    UILabel             *label_3;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)preapareView{
    
    label_1 = [[UILabel alloc] init];
    label_2 = [[UILabel alloc] init];
    label_3 = [[UILabel alloc] init];
    
    [self.view addSubview:label_1];
    [self.view addSubview:label_2];
    [self.view addSubview:label_3];
    
    NSArray *arr = @[label_1,label_2,label_3];
    
    
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
