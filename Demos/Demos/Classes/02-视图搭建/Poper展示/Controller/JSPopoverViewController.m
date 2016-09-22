//
//  JSPopoverViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/21.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSPopoverViewController.h"
#import "JSMenum.h"


@interface JSPopoverViewController () <UIPopoverPresentationControllerDelegate>

@property (nonatomic,strong) JSMenum *menum;
@property (nonatomic,strong) UIButton *button;

@end

@implementation JSPopoverViewController


/**
 iPhone下Popover默认进行全屏展示,原因iOS系统对modal展示进行了界面自适应
 解决方法: 取消界面自适应,设置代理 <UIAdaptivePresentationControllerDelegate>协议
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareView];
    [self prepareNavigationBarItems];
    
}

//设置导航栏
- (void)prepareNavigationBarItems {
    
    // 右侧导航栏按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"BarButtonItem" style:UIBarButtonItemStylePlain target:self action:@selector(clickButton:)];
    
}

// 设置视图
- (void)prepareView {
    
    self.view.backgroundColor = [UIColor js_randomColor];
    
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view).mas_offset(-200);
        make.centerX.mas_equalTo(self.view);
    }];
    
}



- (void)clickButton:(id)sender {
    
    // 设置modal样式
    self.menum.modalPresentationStyle = UIModalPresentationPopover;
    // 从目标控制器中获取Popover对象
    UIPopoverPresentationController *popover = self.menum.popoverPresentationController;
    
    popover.delegate = self;
    
    // 判断来源视图类型(BarButtonItem类型和非BarButtonItem类型)
    if ([sender isKindOfClass:[UIButton class]]) {
        
        UIButton *button = (UIButton *)sender;
        popover.sourceView = button;
        popover.sourceRect = button.bounds;
        
    } else {
        
        popover.barButtonItem = sender;
    }
    // Popover展示
    [self presentViewController:self.menum animated:YES completion:nil];
    
}

#pragma mark - UIAdaptivePresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    // 取消自适应
    return UIModalPresentationNone;
}


#pragma mark - lazy

- (JSMenum *)menum {
    
    if (_menum == nil) {
        _menum = [[JSMenum alloc] init];
    }
    return _menum;
}

- (UIButton *)button {
    
    if (_button == nil) {
        _button = [[UIButton alloc] init];
        [_button setTitle:@"Button(非BarButtonItem视图)" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor js_randomColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor js_randomColor] forState:UIControlStateHighlighted];
        _button.layer.borderColor = [UIColor js_randomColor].CGColor;
        _button.layer.borderWidth = 2;
        [_button sizeToFit];
        [_button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
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
