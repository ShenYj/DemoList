//
//  AppDelegate.m
//  Demos
//
//  Created by ShenYj on 16/8/27.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "AppDelegate.h"
#import "JSNavController.h"
#import "JSRootViewController.h"
#import "UMSocial.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    // 百度地图
    [self BMKMap];
    // 友盟分享
    [self UMShared];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    JSRootViewController *rootVC = [[JSRootViewController alloc] init];
    
    JSNavController *Nav = [[JSNavController alloc] initWithRootViewController:rootVC];
    
    self.window.rootViewController = Nav;
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)UMShared{
    
    // 友盟
    [UMSocialData setAppKey:@"57d1559e67e58ea10200456a"];
}

- (void)BMKMap{
    
    // 请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"Ew7oKDgl3PMv1NGm6aaTG8eOhLLiZxkh"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    //NSLog(@"%s",__func__);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //NSLog(@"%s",__func__);
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //NSLog(@"%s",__func__);
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //NSLog(@"%s",__func__);
}

- (void):(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //NSLog(@"%s",__func__);
}

@end
