//
//  DrawingBoard.m
//  04-小画板
//
//  Created by ShenYj on 16/5/6.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "DrawingBoard.h"
#import "BezierPathWithLIneColour.h"


@interface DrawingBoard ()

@property (nonatomic,assign) CGPoint locPoint;
@property (nonatomic,strong) NSMutableArray *pathMarray;
@property (nonatomic,assign) CGFloat lineWidth;

@end

@implementation DrawingBoard


- (void)clearScreen{
    
    [self.pathMarray removeAllObjects];
    
    [self setNeedsDisplay];
    
}
- (void)backSpace{
    
    [self.pathMarray removeLastObject];
    
    [self setNeedsDisplay];
    
}
- (void)eraser{
    
    self.penColour = self.backgroundColor;
    
//    [self setNeedsDisplay];
    
}


- (NSMutableArray *)pathMarray{
    
    if ( !_pathMarray ) {
        
        _pathMarray = [NSMutableArray array];
    }
    return _pathMarray;
}

//- (void)layoutSubviews{
//    self.pathMarray = [NSMutableArray array];
//}

- (void)drawRect:(CGRect)rect {
    // Drawing code


    for (int i = 0; i<self.pathMarray.count; i++) {
        
        //[self.penColour set]; 获取的并不是当前path的线的颜色
        
        BezierPathWithLIneColour *path = self.pathMarray[i];
        
        [path.lineColour set];
        
        [self.pathMarray[i] stroke];
        
    }
    
//    for (BezierPathWithLIneColour *path in self.pathMarray) {
//        
//        [path.lineColour set];
//        
//        [path stroke];
//        
//    }
 
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //创建触摸对象
    UITouch *touch = touches.anyObject;
    
    //获取最初的点
    CGPoint locPoint = [touch locationInView:touch.view];
    
    //创建路径
    BezierPathWithLIneColour *path = [[BezierPathWithLIneColour alloc]init];

    //移动到当前的点
    [path moveToPoint:locPoint];

    
#pragma mark -- 设置线宽
    
    CGFloat width;
    
    if ([self.delegate respondsToSelector:@selector(drawingBoard:withDrawingLineWidth:)]) {
        
        width = [self.delegate drawingBoard:self withDrawingLineWidth:path.lineWidth];
        
    }
    
    //设置线头样式
    path.lineCapStyle = kCGLineCapRound;
    //设置连接处样式
    path.lineCapStyle = kCGLineCapRound;
    
    //设置线宽
    path.lineWidth = width;

#pragma mark --设置画笔颜色
    
    path.lineColour = self.penColour;

    [self.pathMarray addObject:path];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //创建触摸对象
    UITouch *touch = touches.anyObject;
    
    //获取当前的点
    CGPoint currentPoint = [touch locationInView:touch.view];

    //添加路径
    [[self.pathMarray lastObject] addLineToPoint:currentPoint];
    
    //重绘
    [self setNeedsDisplay];
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}





@end
