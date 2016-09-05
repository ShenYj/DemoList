//
//  UnlockView.m
//  09-手势解锁
//
//  Created by Apple on 16/5/6.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UnlockView.h"

@interface UnlockView()
@property (nonatomic ,strong) NSMutableArray * selectedButtons;

@property (nonatomic,assign) CGPoint currentP;

@end

@implementation UnlockView


- (instancetype)init{
    self = [super init];
    if (self) {
        
        [self prepareView];
    }
    return self;
}


//创建9个按钮
- (void)prepareView{
    
    self.backgroundColor = [UIColor clearColor];
    
    //for循环创建按钮
    for (int i = 0; i < 9; i++){
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //设置按钮的默认图片
        [button setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        
        //设置按钮选中时的图片
        [button setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        
        //添加
        [self addSubview:button];
        
        //禁止与用户交互
        button.userInteractionEnabled = NO;
        
        //设置tag
        button.tag = i;
    }
    
}


//设置frame
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //按钮的宽高
    CGFloat w = 74;
    CGFloat h = 74;
    
    //定义行列
    int totleColume = 3;
    
    //获取俯视图的size
    CGSize superSize = self.frame.size;
    
//    1.子view的横向间距 = (父view的宽度- 3 * 子view的宽度) / 4
    CGFloat magrinX = (superSize.width - totleColume * w) / (totleColume + 1);
    
//    2.子view的纵向间距 = (父view的高度- 3 * 子view的高度) / 4
    CGFloat marginY = (superSize.height - totleColume * h) / (totleColume +1);
    
    for (int i = 0; i < self.subviews.count; i++){
        
        //    3.当前子view的行号 = 当前遍历到得索引值 / 总列数
        int row = i / totleColume;
        
        //    4.当前子view的列号 = 当前遍历到得索引值 % 总列数
        int colume = i % totleColume;
        
        //    5.子view横坐标的公式 = 子view的横向间距 + 列号 * (子view的横向间距+ 子view的宽度)
        CGFloat x = magrinX + colume * (magrinX + w);
        
        //    6.子view纵坐标的公式 = 子view的纵向间距 + 行号 * (子view的纵向间距+ 子view的高度)
        CGFloat y = marginY + row * (marginY + h);
        
        //获取按钮
        UIButton * button = self.subviews[i];
        
        //设置frame
        button.frame = CGRectMake(x, y, w, h);
    }
}

//手指按下
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1.获取触摸对象
    UITouch * touch = touches.anyObject;
    
    //2.根据触摸对象获取点击位置
    CGPoint locP = [touch locationInView:touch.view];
    
    //循环判断点是否在某个按钮里
    for (int i = 0; i < self.subviews.count; i++){
        //获取按钮
        UIButton * button = self.subviews[i];
        
        //判断点是否在某个区域 (被选中的按钮不要再添加)
        if (CGRectContainsPoint(button.frame, locP) && !button.selected){
            //改变按钮的选中状态为yes
            button.selected = YES;
            
            //添加到数组中
            [self.selectedButtons addObject:button];
            
            break;//跳出循环
            
        }
    }
}

//手指移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取触摸对象
    UITouch * touch = touches.anyObject;
    
    //获取点位置
    self.currentP = [touch locationInView:touch.view];
    
    
    //调用手指按下的方法
    [self touchesBegan:touches withEvent:event];
    
    //执行重绘
    [self setNeedsDisplay];
}

//手指抬起
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //设置self.currenP 为数组中最后一个按钮的中心点
//    self.currentP = [[self.selectedButtons lastObject] center];
    UIButton *button = self.selectedButtons.lastObject;
    self.currentP = button.center;
    
    //执行重绘
    [self setNeedsDisplay];
    
    
    //定义可变字符串
    NSMutableString * pwdStr = [NSMutableString string];
    
    //循环数组拼接密码
    for (UIButton * button in self.selectedButtons){
        //拼接字符串
        [pwdStr appendFormat:@"%@",@(button.tag)];
    }
    
    //判断能不能响应方法
    if([self.delegate respondsToSelector:@selector(unlockView:withPwd:)]){
        [self.delegate unlockView:self withPwd:pwdStr];
    }
    
//    NSLog(@"%@",pwdStr);

    //设置所有选中按钮selected为NO
    for (UIButton * button in self.selectedButtons){
        button.selected = NO;
    }
    
    //清空选中按钮的数组
    [self.selectedButtons removeAllObjects];
    
    //执行重绘
    [self setNeedsDisplay];
}

// command + l (定位某一行)
- (void)drawRect:(CGRect)rect{
    
    //判断选中按钮数组的个数
    if (self.selectedButtons.count == 0) return;
    
    // Drawing code
    //1.创建路径
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    //2.设置线宽
    path.lineWidth = 10;
    
    //3.设置颜色
    [[UIColor whiteColor] set];
    
    //4.设置线头样式
    path.lineCapStyle = kCGLineCapRound;
    
    //5.设置连接处样式
    path.lineJoinStyle = kCGLineJoinRound;
    
    //6.设置子路径
    
    //for循环
    for (int i = 0; i < self.selectedButtons.count; i++){
        //获取按钮
        UIButton * button = self.selectedButtons[i];
        
        //获取按钮中心点
        CGPoint centerP = button.center;
        
        //判断是否第一个按钮
        if (i == 0){
            [path moveToPoint:centerP];
        }else{
            [path addLineToPoint:centerP];
        }
    }
    
    //加一根线
    [path addLineToPoint:self.currentP];
    
    //渲染
    [path stroke];
    
}
//懒加载
- (NSMutableArray *)selectedButtons{
    if (_selectedButtons == nil){
        
        _selectedButtons = [NSMutableArray array];
    }
    return _selectedButtons;
}

@end


















