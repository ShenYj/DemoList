//
//  DrawingBoard.h
//  04-小画板
//
//  Created by ShenYj on 16/5/6.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DrawingBoard;

@protocol DrawingBoardDelegate <NSObject>

@optional
- (CGFloat )drawingBoard:(UIView *)drawingBoard withDrawingLineWidth:(CGFloat )lineWidth;

@end

@interface DrawingBoard : UIView

@property (nonatomic,weak) id <DrawingBoardDelegate> delegate;

@property (nonatomic,strong) UIColor *penColour;

- (void)clearScreen;
- (void)backSpace;
- (void)eraser;


@end
