//
//  JSPopoverViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/21.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSPopoverViewController.h"
#import "JSMenum.h"


@interface JSPopoverViewController ()

@property (nonatomic,strong) JSMenum *menum;

@end

@implementation JSPopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareView];
    
}

- (void)prepareView {
    
    self.view.backgroundColor = [UIColor js_randomColor];
    
    // 右侧导航栏按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Popover" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarButtonItem:)];
    
    
}


- (void)clickRightBarButtonItem:(UIBarButtonItem *)sender {
    
    [self presentViewController:self.menum animated:YES completion:nil];
}


#pragma mark - lazy

- (JSMenum *)menum {
    
    if (_menum == nil) {
        _menum = [[JSMenum alloc] init];
    }
    return _menum;
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
