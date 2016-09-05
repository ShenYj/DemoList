//
//  JSWebViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/5.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSWebViewController.h"


@interface JSWebViewController () <UIWebViewDelegate>

@property (nonatomic,weak) UIWebView *webView;

@end

@implementation JSWebViewController

- (void)loadView{
    
    self.view = [[UIWebView alloc] init];
    self.view.backgroundColor = [UIColor js_colorWithHex:0xFFF8DC];
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.webView = (UIWebView *)self.view;
    
    // 本地Apache服务器
//    NSString *urlString = @"http://localhost:63342/demo(HTML)/JS与OC交互Demo.html";
//    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    //    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"JS与OC交互Demo.html" ofType:nil];
    //    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    //    [self.webView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
    
    // 项目内资源
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"JS与OC交互Demo.html" withExtension:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.webView.delegate = self;
    
}

@end
