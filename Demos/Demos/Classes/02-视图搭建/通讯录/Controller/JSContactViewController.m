//
//  JSContactViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/11.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSContactViewController.h"
#import <ContactsUI/ContactsUI.h>

@interface JSContactViewController ()

@property (nonatomic,strong) UIButton *contactButton;

@end

@implementation JSContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareView];
}

- (void)prepareView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.contactButton];
    
    [self.contactButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
}

#pragma mark - target 

- (void)clickContactButton:(UIButton *)sender{
    
    CNContactPickerViewController *picterViewController = [[CNContactPickerViewController alloc] init];
    
    [self presentViewController:picterViewController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy

- (UIButton *)contactButton {
    
    if (_contactButton == nil) {
        _contactButton = [[UIButton alloc] init];
        [_contactButton setTitle:@"打开通讯录" forState:UIControlStateNormal];
        [_contactButton setTitleColor:[UIColor js_randomColor] forState:UIControlStateNormal];
        [_contactButton addTarget:self action:@selector(clickContactButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactButton;
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
