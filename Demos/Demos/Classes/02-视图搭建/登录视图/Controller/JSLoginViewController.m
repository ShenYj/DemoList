//
//  JSLoginViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/23.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSLoginViewController.h"
#import "Masonry.h"
#import "LeftView.h"
#import "UserNameListTableViewController.h"



@interface JSLoginViewController () <UITextFieldDelegate>

@property (nonatomic) UITextField *userName_TF;
@property (nonatomic) UITextField *password_TF;
@property (nonatomic) LeftView *leftView_UN;
@property (nonatomic) LeftView *leftView_PW;
@property (nonatomic) UIButton *userNameListButton; // 显示账号列号
@property (nonatomic) UIButton *showPassWordButton; // 显示密码明文
@property (nonatomic) UserNameListTableViewController *nameList;
@property (nonatomic) UILabel *detailLabel;
@property (nonatomic) UIView *border_UN;
@property (nonatomic) UIView *border_PW;

@end

@implementation JSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self prepareView];
}

- (void)prepareView {
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.userName_TF.borderStyle = UITextBorderStyleNone;
    self.userName_TF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userName_TF.secureTextEntry = NO;
    self.password_TF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.password_TF.borderStyle = UITextBorderStyleNone;
    self.password_TF.secureTextEntry = YES;
    
    // 设置TextField的左右视图
    self.userName_TF.leftView = self.leftView_UN;
    self.userName_TF.leftViewMode = UITextFieldViewModeAlways;
    self.password_TF.leftView = self.leftView_PW;
    self.password_TF.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.userName_TF];
    [self.view addSubview:self.password_TF];
    [self.view addSubview:self.leftView_UN];
    [self.view addSubview:self.leftView_PW];
    [self.view addSubview:self.detailLabel];
    
    [self.userName_TF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view).mas_offset(-16);
        make.top.mas_equalTo(self.view).mas_offset(120);
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(30);
    }];
    [self.password_TF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userName_TF.mas_bottom).mas_offset(20);
        make.left.right.mas_equalTo(self.userName_TF);
        make.height.mas_equalTo(30);
    }];
    
    [self.leftView_UN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [self.leftView_PW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];

    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    
    [self.view insertSubview:self.border_UN belowSubview:self.userName_TF];
    [self.view insertSubview:self.border_PW belowSubview:self.password_TF];
    
    [self.border_UN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.userName_TF).mas_offset(-2);
        make.bottom.mas_equalTo(self.userName_TF).mas_offset(2);
        make.right.mas_equalTo(self.userName_TF).mas_offset(32);
    }];
    
    [self.border_PW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.password_TF).mas_offset(-2);
        make.bottom.mas_equalTo(self.password_TF).mas_offset(2);
        make.right.mas_equalTo(self.password_TF).mas_offset(32);
    }];
    
    [self.border_UN addSubview:self.userNameListButton];
    [self.border_PW addSubview:self.showPassWordButton];
    
    [self.userNameListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(self.border_UN);
        make.width.mas_equalTo(30);
    }];
    [self.showPassWordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(self.border_PW);
        make.width.mas_equalTo(30);
    }];
    
    self.nameList.tableView.hidden = YES;
    [self addChildViewController:self.nameList];
    [self.view addSubview:self.nameList.tableView];
    [self.nameList.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userName_TF.mas_bottom).mas_offset(1);
        make.left.mas_equalTo(self.border_UN).mas_offset(1);
        make.right.mas_equalTo(self.border_UN).mas_offset(-1);
        make.height.mas_offset(60);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.nameList setSelectedHandler:^(NSString *userName) {
        
        weakSelf.userName_TF.text = userName;
        weakSelf.userNameListButton.selected = NO;
        weakSelf.nameList.tableView.hidden = YES;
    }];
    
}


#pragma mark - target

- (void)clickButton:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    
    if (sender.tag == 1001) {
        
        // password
        self.password_TF.secureTextEntry = !sender.selected;
        
    } else {
        
        // username
        self.nameList.tableView.hidden = !sender.isSelected;
        
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if ([textField isEqual:self.userName_TF]) {
        
        if (range.location > 9) {
            return NO;
        }
        
    } else {
        
        if (range.location > 11) {
            return NO;
        }
    }
    
    
    return YES;
    
}

#pragma mark - lazy

- (UITextField *)userName_TF {
    
    if (_userName_TF == nil) {
        _userName_TF = [[UITextField alloc] init];
        _userName_TF.delegate = self;
    }
    return _userName_TF;
}

- (UITextField *)password_TF {
    
    if (_password_TF == nil) {
        _password_TF = [[UITextField alloc] init];
        _password_TF.delegate = self;
    }
    return _password_TF;
}

- (LeftView *)leftView_UN {
    
    if (_leftView_UN == nil) {
        _leftView_UN = [[LeftView alloc] init];
        _leftView_UN.title = @"账号:";
        _leftView_UN.imageName = @"v2_my";
    }
    return _leftView_UN;
}

- (LeftView *)leftView_PW {
    
    if (_leftView_PW == nil) {
        _leftView_PW = [[LeftView alloc] init];
        _leftView_PW.title = @"密码:";
        _leftView_PW.imageName = @"v2_order";
    }
    return _leftView_PW;
}

- (UIButton *)userNameListButton {
    
    if (_userNameListButton == nil) {
        _userNameListButton = [[UIButton alloc] init];
        _userNameListButton.tag = 1002;
        [_userNameListButton setImage:[UIImage imageNamed:@"cell_arrow_down_accessory"] forState:UIControlStateNormal];
        [_userNameListButton setImage:[UIImage imageNamed:@"cell_arrow_up_accessory"] forState:UIControlStateSelected];
        [_userNameListButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userNameListButton;
}

- (UIButton *)showPassWordButton {
    
    if (_showPassWordButton == nil) {
        _showPassWordButton = [[UIButton alloc] init];
        _showPassWordButton.tag = 1001;
        [_showPassWordButton setImage:[UIImage imageNamed:@"icon_black_scancode"] forState:UIControlStateNormal];
        [_showPassWordButton setImage:[UIImage imageNamed:@"scanicon"] forState:UIControlStateSelected];
        [_showPassWordButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showPassWordButton;
}

- (UserNameListTableViewController *)nameList {
    
    if (_nameList == nil) {
        _nameList = [[UserNameListTableViewController alloc] init];
    }
    return _nameList;
}

- (UIView *)border_UN {
    
    if (_border_UN == nil) {
        _border_UN = [[UIView alloc] init];
        _border_UN.layer.borderWidth = 1;
        _border_UN.backgroundColor = [UIColor whiteColor];
        _border_UN.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return _border_UN;
}

- (UIView *)border_PW {
    
    if (_border_PW == nil) {
        _border_PW = [[UIView alloc] init];
        _border_PW.layer.borderWidth = 1;
        _border_PW.backgroundColor = [UIColor whiteColor];
        _border_PW.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return _border_PW;
}

- (UILabel *)detailLabel {
    
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:13];
        _detailLabel.textColor = [UIColor purpleColor];
        _detailLabel.numberOfLines = 0;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.text = @"自定义UITextField的LeftView和RightView\n没有对应的图片所以随便设置的\n账号列表使用的是Popover进行实现";
    }
    return _detailLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
