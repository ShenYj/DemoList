//
//  JSRotateView.m
//  幸运转盘
//
//  Created by ShenYj on 16/5/9.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//


#define BUTTON_TOTAL_COUNTS 12

#import "JSRotateView.h"
#import "JSLucyButton.h"

@interface JSRotateView ()

@property (weak, nonatomic) IBOutlet UIImageView *luckyRotateWheelView;
@property (nonatomic,strong) UIButton *centerBtn;
@property (nonatomic,weak) JSLucyButton *selectedBtn;
@property (nonatomic,strong) CADisplayLink *displayLink;

@end

@implementation JSRotateView

+ (instancetype)rotateView{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"JSRotateView" owner:nil options:nil]lastObject];
    
}

- (void)awakeFromNib{

    
    //创建抓盘周边按钮
    for (int i = 0; i < BUTTON_TOTAL_COUNTS; i ++) {
        
        //获取需要切割的图片
//        UIImage *originalImage = [UIImage imageNamed:@"LuckyAstrology"];
//        UIImage *originalPressedImage = [UIImage imageNamed:@"LuckyAnimalPressed"];
        
        //切割图片
        UIImage *cellUIImage = [self clipImageWithImage:[UIImage imageNamed:@"LuckyAstrology"] andIndex:i];
        UIImage *cellUIPressedImage = [self clipImageWithImage:[UIImage imageNamed:@"LuckyAstrologyPressed"] andIndex:i];
        
        //计算按钮弧度
        CGFloat angle = M_PI * 2 / 12;
        JSLucyButton *button = [JSLucyButton buttonWithType:UIButtonTypeCustom];
        button.transform = CGAffineTransformMakeRotation(angle * i);
        button.bounds = CGRectMake(0, 0, 68, 143);
        button.center = self.center;
        button.layer.anchorPoint = CGPointMake(0.5, 1);//修改锚点
        button.tag = i;
        
        [button setImage:cellUIImage forState:UIControlStateNormal];
        [button setImage:cellUIPressedImage forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchDown];

        [self.luckyRotateWheelView addSubview:button];

    }
    
    //创建中心选择按钮
    self.centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.centerBtn.bounds = CGRectMake(0, 0, 81, 81);
    self.centerBtn.center = self.center;
    [self.centerBtn setImage:[UIImage imageNamed:@"LuckyCenterButton"] forState:UIControlStateNormal];
    [self.centerBtn setImage:[UIImage imageNamed:@"LuckyCenterButtonPressed"] forState:UIControlStateHighlighted];
    [self addSubview:self.centerBtn];
    
    [self.centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchDown];

    //开启定时器
    [self startDisplayLink];
    
}


/**
 *  开启定时器
 */
- (void)startDisplayLink{
    
    //添加定时器
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(startRotateViewRotate)];
    //将定时器添加到主循环队列
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}

/**
 *  定时器监听事件
 */
- (void)startRotateViewRotate{
    
    self.luckyRotateWheelView.transform = CGAffineTransformRotate(self.luckyRotateWheelView.transform, M_PI_4 * 0.05);

}

/**
 *  关闭定时器
 */
- (void)stopRotateViewRotate{
    
    [self.displayLink invalidate];
    self.displayLink = nil;
    
}

/**
 *  转盘选项按钮点击事件
 *
 *  @param sender 点击的按钮
 */
- (void)selectButtonClick:(JSLucyButton *)sender{
    
    //中间变量(指针)
    self.selectedBtn.selected = NO;
    
    sender.selected = YES;
    
    self.selectedBtn = sender;

}

/**
 *  中心开始按钮点击事件
 *
 *  @param sender 中心按钮
 */
- (void)centerBtnClick:(UIButton *)sender{

    self.luckyRotateWheelView.userInteractionEnabled = NO;
    
    [self stopRotateViewRotate];
    
    //每个button占的弧度
    CGFloat angle = ( M_PI * 2 / 360 * 30 );
    
    CABasicAnimation *basicAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAni.removedOnCompletion = NO;
//    basicAni.fillMode = kCAFillModeForwards;
    basicAni.duration = 3;
    basicAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    basicAni.delegate = self;
    basicAni.toValue = @(M_PI * 2 * 8 - self.selectedBtn.tag * angle);

    
    [self.luckyRotateWheelView.layer addAnimation:basicAni forKey:nil];

    
    
    
}

/**
 *  基本动画动画结束代理方法
 *
 *  @param anim 动画对象
 *  @param flag 索引
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    CGFloat angle = 2 * M_PI / 12;
     
    self.luckyRotateWheelView.transform = CGAffineTransformMakeRotation(M_PI * 2 * 8 - self.selectedBtn.tag * angle);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的幸运号码是:1,3,8" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self startDisplayLink];
        
        self.luckyRotateWheelView.userInteractionEnabled = YES;
        
    }];
    
    [alert addAction:action];
    
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController presentViewController:alert animated:YES completion:nil];
    
}

/**
 *  切割图片
 *
 *  @param originalImage 原始图片
 *  @param index         索引
 *
 *  @return 裁切后的图片
 */
- (UIImage *)clipImageWithImage:(UIImage *)originalImage andIndex:(int)index{

    //获取屏幕的缩放比
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGFloat w = originalImage.size.width / 12;
    CGFloat h = originalImage.size.height;
    CGFloat x = w * index;
    CGFloat y = 0;
    
    //根据索引切割图片
    CGImageRef cellCGImage = CGImageCreateWithImageInRect(originalImage.CGImage, CGRectMake(x*scale, y*scale, w*scale, h*scale));
    
    //转换图片
    UIImage *cellUIImage = [UIImage imageWithCGImage:cellCGImage];
    
//    NSLog(@"%f",scale);
    
    //释放
    CGImageRelease(cellCGImage);
    
    //返回切割的图片
    return cellUIImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
