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
#import "UMSocialSinaSSOHandler.h"

NSInteger appBadgeNumber;

@interface AppDelegate  ()

// 记录接收到的通知
@property (nonatomic,strong) NSMutableDictionary *localNotification;

@property (nonatomic,strong) UILabel *noticeLabel;

@end


@implementation AppDelegate


// 应用被杀死后接收通知
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#pragma mark - 远程推送请求授权和注册远程通知
    
    // 请求授权 (与本地通知一样需要获取授权)
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    // 注册远程通知 获取DeviceToken
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    

    // 百度地图
    [self BMKMap];
    
    // 友盟分享
    [self UMShared];
    
    // 设置Window
    [self prepareRootController];
    
    // 接收到本地通知后发送通知(这里因为控制器层级关系的问题,没有做进一步处理,所以杀死应用后暂时无法获取到推送通知)
    UILocalNotification *localNotification = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    NSString *key = localNotification.userInfo.keyEnumerator.nextObject;
    
    // 应用退出时接收到远程推送,和本地通知一样,需要从该方法中获取到通知推送的内容
    NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
     
    
    [self showLocalNote:localNotification];
    
    // 记录收到的推送通知
    [self.localNotification setObject:[localNotification.userInfo objectForKey:key] forKey:key];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"localNotification" object:nil userInfo:localNotification.userInfo];
    
    return YES;
}

/**
 *  已经注册远程推送通知后调用
 *
 *  @param application 应用对象
 *  @param deviceToken 设备令牌  (APNs通过它来找获取远程推送的设备)
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSLog(@"%@",[[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding]);
    
}

/**
 *  展示接收到的通知信息
 *
 *  @param localNotification 接收到的通知
 */
- (void)showLocalNote:(UILocalNotification *)localNotification{
    
    JSNavController *nav = (JSNavController *)self.window.rootViewController;
    [nav.navigationBar addSubview:self.noticeLabel];
    
    NSString *key = localNotification.userInfo.keyEnumerator.nextObject;
    self.noticeLabel.text = [localNotification.userInfo objectForKey:key];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:10 animations:^{
            
            self.noticeLabel.transform = CGAffineTransformMakeTranslation(-SCREEN_SIZE.width, 0);
            
        } completion:^(BOOL finished) {
            
            [self.noticeLabel removeFromSuperview];
        }];
        
    });
    
}

#pragma mark - 设置根视图

- (void)prepareRootController{
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    JSRootViewController *rootVC = [[JSRootViewController alloc] init];
    
    JSNavController *Nav = [[JSNavController alloc] initWithRootViewController:rootVC];
    
    self.window.rootViewController = Nav;
    
    [self.window makeKeyAndVisible];
}

#pragma mark - 友盟分享

- (void)UMShared{
    
    // 友盟
    [UMSocialData setAppKey:@"57d1559e67e58ea10200456a"];
    // SSO
    //    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
    //                                              secret:@"04b48b094faeb16683c32669824ebdad"
    //                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    // 4.2版本
    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

// 当App被其他App打开时会调用此代理方法
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
        
    }
    return result;
}


#pragma mark - 百度地图

- (void)BMKMap{
    
    // 请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"Ew7oKDgl3PMv1NGm6aaTG8eOhLLiZxkh"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
}


#pragma mark - 推送通知(本地推送通知)
/**
 *  当已经接收到本地通知后调用(应用在后台时,点击通知进入应用后调用;应用在前台时,接收到通知直接调用)
 *
 *  @param application  应用对象
 *  @param notification 接收到的本地通知
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    
    /*
     UIApplicationStateActive,//前台
     UIApplicationStateInactive,//中断(电话打断)
     UIApplicationStateBackground//后台

     */
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateBackground ) {
        
        // 接收到本地通知后发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"localNotification" object:nil userInfo:notification.userInfo];
        
    }

}
/**
 *  当已经收到本地通知后调用  (当使用了iOS8动作类别的通知后调用,didReceiveLocalNotification代理方法将不被执行)
 *
 *  @param application       应用对象
 *  @param identifier        动作标识符
 *  @param notification      接收到的本地通知对象
 *  @param __TVOS_PROHIBITED 完成回调
 */
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler {
    
    if ([identifier isEqualToString:@"foreground"]) {
        NSLog(@"点击了前台按钮");
    }
    
    if ([identifier isEqualToString:@"background"]) {
        NSLog(@"点击了后台按钮");
    }
    
    //调用完成回调 (用来更新快照&设置应用的挂起)
    completionHandler();
}

/**
 *  当已经收到本地通知后调用 (当使用了iOS9动作行为(快捷回复)的通知后调用,handleActionWithIdentifier及didReceiveLocalNotification代理方法将不被执行)
 *
 *  @param application       应用对象
 *  @param identifier        动作标识符
 *  @param notification      接收到本地通知对象
 *  @param responseInfo      快速回复的信息
 *  @param __TVOS_PROHIBITED 完成回调
 */
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler NS_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED;{
    
    
    appBadgeNumber--;
    application.applicationIconBadgeNumber = appBadgeNumber;
    
    if ([identifier isEqualToString:@"foreground"]) {
        
        NSLog(@"点击了前台按钮");
        
    }
    
    if ([identifier isEqualToString:@"background"]) {
        
        NSLog(@"%@",responseInfo[UIUserNotificationActionResponseTypedTextKey]);
        
    }
    
    //调用完成回调 (用来更新快照&设置应用的挂起)
    completionHandler();
    
    
}

#pragma mark - 推送通知(远程推送通知)

/**
 *  已经接收到远程通知后调用
 *
 *  @param application 应用对象
 *  @param userInfo    json字符串转成的字典
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
}
/**
 *  已经接收到后台远程通知后调用 (如果实现了该方法,默认的接收通知的方法就不会再被调用didReceiveRemoteNotification↑)
 *
 *  @param application       应用对象
 *  @param userInfo          接收到的后台远程通知传递的信息
 *  @param completionHandler 完成回调(负责更新快照,后台处理有效性的评估)
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    NSLog(@"%@",userInfo);
    
    // 系统会根据UIBackgroundFetchResult来判断后台处理的有效性,如果后台处理效率较低,会延迟发送后台推送通知
    completionHandler(UIBackgroundFetchResultNewData);
    
}

/**
 *  当注册失败后调用 (kdevicenToken没有获取到的原因)
 *
 *  @param application 应用对象
 *  @param error       报错信息
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError:%@",error);
    
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


- (UILabel *)noticeLabel {
    
    if (_noticeLabel == nil) {
        _noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 44)];
        _noticeLabel.textColor = [UIColor blueColor];
        _noticeLabel.font = [UIFont systemFontOfSize:15];
        _noticeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _noticeLabel;
}

@end
