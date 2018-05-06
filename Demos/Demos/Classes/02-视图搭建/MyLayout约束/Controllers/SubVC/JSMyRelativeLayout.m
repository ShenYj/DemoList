//
//  JSMyRelativeLayout.m
//  Demos
//
//  Created by ShenYj on 2018/5/6.
//  Copyright © 2018年 ___ShenYJ___. All rights reserved.
//

#import "JSMyRelativeLayout.h"

@interface JSMyRelativeLayout ()

@end

@implementation JSMyRelativeLayout

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpMylinearLayoutView];
}

- (void)setUpMylinearLayoutView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = [NSStringFromClass(self.class) substringFromIndex:2];
    
    MyRelativeLayout *relativeLayout = [[MyRelativeLayout alloc] init];
    relativeLayout.backgroundColor = [UIColor js_randomColor];
    relativeLayout.mySize = CGSizeMake(300, 400);
    relativeLayout.centerXPos.equalTo(@0);
    relativeLayout.centerYPos.equalTo(@0);
    [self.view addSubview:relativeLayout];
    // view1
    UIView *redView = [[UIView alloc] init];
    redView.leftPos.equalTo(relativeLayout).offset(20);
    redView.topPos.equalTo(relativeLayout).offset(20);
    
}

@end
