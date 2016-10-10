//
//  UIImage+JSSkin.h
//  Demos
//
//  Created by ShenYj on 2016/10/10.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//



@interface UIImage (JSSkin)

// 根据皮肤设置图片
+ (UIImage *)jsImageNamed:(NSString *)name;

// 记录皮肤
+ (void)saveSkinModeWithNight:(BOOL)night;

// 获取皮肤设置
+ (BOOL)isNight;

// 在当前皮肤下,根据颜色的key取出对应的颜色
+ (UIColor *)loadColorWithKey:(NSString *)key;


@end
