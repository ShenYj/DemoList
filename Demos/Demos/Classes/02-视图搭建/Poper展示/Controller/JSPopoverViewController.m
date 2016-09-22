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
@property (nonatomic,strong) UILabel *detail;

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
    [self.view addSubview:self.detail];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view).mas_offset(-200);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.button.mas_bottom).mas_offset(10);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
}



- (void)clickButton:(id)sender {
    
    // 设置modal样式
    self.menum.modalPresentationStyle = UIModalPresentationPopover;
    // 设置Popover控制器的尺寸
    self.menum.preferredContentSize = CGSizeMake(100, 200);
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

- (UILabel *)detail {

    if (_detail == nil) {
        _detail = [[UILabel alloc] init];
        _detail.textAlignment = NSTextAlignmentCenter;
        _detail.font = [UIFont systemFontOfSize:16];
        _detail.textColor = [UIColor js_randomColor];
        _detail.numberOfLines = 0;
        _detail.text = @"1.iPhone上设置Modal样式为Popover,系统会自动进行适配\n,需要通过设置代理手动取消系统的自动适配\n设置代理时,需要使用UIPopoverPresentationControllerDelegate的父协议(UIAdaptivePresentationControllerDelegate)中的代理方法\n2.Popover的来源视图控制器分为两种:\nBarButtonItem(设置barButtonItem属性)\n非BarButtonItem(设置sourceView属性)\n3.当来源视图为非BarButtonItem时,参考点默认是来源视图的左上角,设置sourceRect属性为来源视图的bounds后,将以来源视图的中心作为参考点,BarButtonItem不需要设置参考点\n4.获取Popover对象前必须先要设置Modal展示样式为Popover,否则取出值为nil\n";
    }
    return _detail;
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
