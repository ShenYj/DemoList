//
//  ViewController.m
//  09-时钟
//
//  Created by ShenYj on 16/5/7.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSClockViewController.h"

@interface JSClockViewController ()

@property (nonatomic,weak) CALayer *colockLayer;

@property (nonatomic,weak) UIView *secondHand;
@property (nonatomic,weak) UIView *minuteHand;
@property (nonatomic,weak) UIView *hourHand;

@end

@implementation JSClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建layer
    CALayer *colockLayer = [CALayer layer];
    
    //设置属性
    colockLayer.bounds = CGRectMake(0, 0, 300, 300);
    colockLayer.position = self.view.center;
    colockLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"clock"].CGImage);
    colockLayer.borderWidth = 2.5;
    colockLayer.borderColor = [UIColor magentaColor].CGColor;
    colockLayer.cornerRadius = 150;
    colockLayer.masksToBounds = YES;
    
    //添加到self.view的Layer中
    [self.view.layer addSublayer:colockLayer];
    self.colockLayer = colockLayer;
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    UIView *secondHand = [[UIView alloc]init];
    secondHand.bounds = CGRectMake(0, 0, 1, colockLayer.cornerRadius * 3.5/5);
    secondHand.layer.anchorPoint = CGPointMake(0.5, 1);
    secondHand.center = self.view.center;
    secondHand.backgroundColor = [UIColor redColor];
    [self.view addSubview:secondHand];
    
    UIView *minuteHand = [[UIView alloc]init];
    minuteHand.bounds = CGRectMake(0, 0, 3, colockLayer.cornerRadius * 2/5);
    minuteHand.layer.anchorPoint = CGPointMake(0.5, 1);
    minuteHand.center = self.view.center;
    minuteHand.backgroundColor = [UIColor blueColor];
    [self.view addSubview:minuteHand];
    
    UIView *hourHand = [[UIView alloc]init];
    hourHand.bounds = CGRectMake(0, 0, 3, colockLayer.cornerRadius * 1.5/5);
    hourHand.layer.anchorPoint = CGPointMake(0.5, 1);
    hourHand.center = self.view.center;
    hourHand.backgroundColor = [UIColor blackColor];
    [self.view addSubview:hourHand];
    
    self.secondHand = secondHand;
    self.minuteHand = minuteHand;
    self.hourHand = hourHand;
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(runTime)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    
}


- (void)runTime{
    
    
    NSCalendar *currentCal = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    
    NSInteger currentSecond = [currentCal component:NSCalendarUnitSecond fromDate:currentDate];
    NSInteger currentMinute = [currentCal component:NSCalendarUnitMinute fromDate:currentDate];
    NSInteger currentHour = [currentCal component:NSCalendarUnitHour fromDate:currentDate];
    
    
    CGFloat secondAngle = M_PI * 2 /60 * currentSecond;
    CGFloat minuteAngle = M_PI * 2 /60 * currentMinute;
    CGFloat hourAngle = M_PI * 2 / 12 * currentHour + minuteAngle / 2* M_PI * 1 / 12;
    
    //    NSLog(@"%ld:%ld:%ld",currentHour,(long)currentMinute,(long)currentSecond);
    
    self.secondHand.transform = CGAffineTransformMakeRotation(secondAngle);
    self.minuteHand.transform = CGAffineTransformMakeRotation(minuteAngle);
    self.hourHand.transform = CGAffineTransformMakeRotation(hourAngle);
    
}


@end
