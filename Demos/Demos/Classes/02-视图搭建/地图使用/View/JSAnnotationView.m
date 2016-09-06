//
//  JSAnnotationView.m
//  Demos
//
//  Created by ShenYj on 16/9/6.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSAnnotationView.h"
static NSString * const identifier = @"reuseIdentifier";

@implementation JSAnnotationView

+ (instancetype)annotationWihMapView:(MKMapView *)mapView{
    
    JSAnnotationView *annotationView = (JSAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!annotationView) {
        annotationView = [[JSAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:identifier];
    }
    // 设置颜色需要使用MKPinAnnotationView
    //annotationView.pinTintColor = [UIColor js_colorWithHex:0x8A2BE2];
    
    // 显示标注
    annotationView.canShowCallout = YES;
    // 掉落动画 (MKPinAnnotationView 的属性)
    //annotationView.animatesDrop = YES;
    
    [[UIImage imageNamed:@"LuckyLeftPressed"] js_ImageWithSize:CGSizeMake(30, 30) completion:^(UIImage *img) {
        
        annotationView.image = [UIImage js_imageWithOriginalImage:img];
    }];
    
    return annotationView;
    
}


@end
