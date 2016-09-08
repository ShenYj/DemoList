//
//  JSSocialViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/8.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSSocialViewController.h"
#import "UMSocial.h"

//AK: 57d1559e67e58ea10200456a

@interface JSSocialViewController () <UMSocialUIDelegate>

@end

@implementation JSSocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sharedByUMSocial{
    
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"507fcab25270157b37000010"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                       delegate:self];
}

@end
