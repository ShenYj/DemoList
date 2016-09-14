//
//  MJKBaseView.m
//  为了演示事件传递过程
//
//  Created by JackMeng on 15/9/21.
//  Copyright (c) 2015年 JackMeng. All rights reserved.
//

#import "MJKBaseView.h"



@implementation MJKBaseView

//手指按下
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    NSLog(@"%@----touchesBegan", [self class]);
    [super touchesBegan:touches withEvent:event];
}

// 用来一层一层递归搜索给定的点在不在某个view的有效范围之内的
//- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
//{
//    NSLog(@"%@----hitTest:", [self class]);
//    return [super hitTest:point withEvent:event];
//}

//// hitTest:方法内部的参考实现
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    NSLog(@"%@----hitTest:", [self class]);
//
//    // 如果控件不允许与用户交互那么返回 nil
//    if (self.userInteractionEnabled == NO || self.alpha <= 0.01 || self.hidden == YES) {
//        return nil;
//    }
//
//    // 如果这个点不在当前控件中那么返回 nil
//    if (![self pointInside:point withEvent:event]) {
//        return nil;
//    }
//
//    // 从后向前遍历每一个子控件
//
//    for (int i = (int)self.subviews.count - 1; i >= 0; i--) {
//        // 获取一个子控件
//        UIView *lastVw = self.subviews[i];
//        // 把当前触摸点坐标转换为相对于子控件的触摸点坐标
//        CGPoint subPoint = [self convertPoint:point toView:lastVw];
//        // 判断是否在子控件中找到了更合适的子控件
//        UIView *nextVw = [lastVw hitTest:subPoint withEvent:event];
//        // 如果找到了返回
//        if (nextVw) {
//            return nextVw;
//        }
//    }
//
//    // 如果以上都没有执行 return, 那么返回自己(表示子控件中没有"更合适"的了)
//    return  self;
//}
//
////- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
////{
////    return NO;
////}
@end
