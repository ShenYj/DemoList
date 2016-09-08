//
//  AppDelegate.h
//  Demos
//
//  Created by ShenYj on 16/8/27.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件



@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    BMKMapManager           * _mapManager;
}

@property (strong, nonatomic) UIWindow *window;


@end

