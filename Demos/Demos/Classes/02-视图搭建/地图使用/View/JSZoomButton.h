//
//  JSZoomButton.h
//  Demos
//
//  Created by ShenYj on 16/9/6.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZoomTypeIn = 10,
    ZoomTypeOut = 40,
} ZoomType;

@interface JSZoomButton : UIButton

@property (nonatomic,assign) ZoomType zoomType;

@end
