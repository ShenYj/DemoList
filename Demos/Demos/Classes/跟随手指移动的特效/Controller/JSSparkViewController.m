//
//  ViewController.m
//  15-多点触摸
//
//  Created by ShenYj on 16/5/5.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSSparkViewController.h"

@interface JSSparkViewController ()

@property (nonatomic,strong) NSArray *imageArray;
@property (nonatomic,assign) NSInteger randomNum;


@end

@implementation JSSparkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];

    //获取随机数,使触摸拖拽时的随机数为一个恒定的值
    self.randomNum = arc4random()%self.imageArray.count;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取触摸对象
    for (UITouch *touch in touches) {
        
        NSInteger randomNum = arc4random()%self.imageArray.count;
        
        //获取当前点
        CGPoint localPoint = [touch locationInView:self.view];
        
        //创建图片框
        UIImageView *imageView = [[UIImageView alloc]initWithImage:self.imageArray[randomNum]];
        
        [self.view addSubview:imageView];
        
        imageView.center = localPoint;
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [imageView removeFromSuperview];
            
        });
        
    }
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //手指离开屏幕重新获取一个随机数
    self.randomNum = arc4random()%self.imageArray.count;
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    NSLog(@"%ld",touches.count);
//    NSLog(@"%ld",(long)self.randomNum);
    
    //获取触摸对象
    for (UITouch *touch in touches) {
        
//        NSInteger randomNum = arc4random()%self.imageArray.count;
        
        //获取当前点
        CGPoint localPoint = [touch locationInView:self.view];
        
        //创建图片框
        UIImageView *imageView = [[UIImageView alloc]initWithImage:self.imageArray[self.randomNum]];
        
        [self.view addSubview:imageView];
        
        imageView.center = localPoint;
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [imageView removeFromSuperview];
            
        });
        
        if ( touches.count > 1) {
            
            if (self.randomNum >= 0 && self.randomNum <= self.imageArray.count - 2) {
                
                self.randomNum ++;
                
            }else{
                
                self.randomNum --;
            }
            
        }
        
    }
    
    
    
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (NSArray *)imageArray{
    
    if ( !_imageArray) {
        
        _imageArray = @[
                        
            [UIImage imageNamed:@"spark_blue"],
            [UIImage imageNamed:@"spark_cyan"],
            [UIImage imageNamed:@"spark_green"],
            [UIImage imageNamed:@"spark_magenta"],
            [UIImage imageNamed:@"spark_red"],
            [UIImage imageNamed:@"spark_yellow"]];
        
    }
    
    return _imageArray;
}

@end
