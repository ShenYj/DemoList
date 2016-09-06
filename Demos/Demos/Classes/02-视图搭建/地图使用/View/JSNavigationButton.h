//
//  JSNavigationButton.h
//  Demos
//
//  Created by ShenYj on 16/9/6.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NavigationTypeBySystemMap,
    NavigationTypeByCustomMap,
} NavigationType;

@interface JSNavigationButton : UIButton

// 导航类型
@property (nonatomic,assign) NavigationType navigationType;

@end
