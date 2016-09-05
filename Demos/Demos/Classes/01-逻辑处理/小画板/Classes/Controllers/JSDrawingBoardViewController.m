//
//  ViewController.m
//  04-小画板
//
//  Created by ShenYj on 16/5/6.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSDrawingBoardViewController.h"
#import "DrawingBoard.h"



@interface JSDrawingBoardViewController () <DrawingBoardDelegate>

@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (weak, nonatomic) IBOutlet DrawingBoard *drawingBoardView;

@end

@implementation JSDrawingBoardViewController

- (void)loadView{
    
    self.view = [[NSBundle mainBundle] loadNibNamed:@"DrawingBoardView" owner:self options:nil].lastObject;
}


- (IBAction)clearScreenButton:(UIBarButtonItem *)sender {
    
    [self.drawingBoardView clearScreen];
    
}

- (IBAction)backSpaceButton:(UIBarButtonItem *)sender {
    
    [self.drawingBoardView backSpace];
}

- (IBAction)eraserButton:(UIBarButtonItem *)sender {
    
    [self.drawingBoardView eraser];
}

- (IBAction)saveButton:(UIBarButtonItem *)sender {
    
    
    //开启图形上下文对象
    UIGraphicsBeginImageContextWithOptions(self.drawingBoardView.bounds.size, NO, 0.0);
    
    //获取图形上下文对象
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //将当前view的layer添加到图形上下文对象
    [self.drawingBoardView.layer renderInContext:ctx];
    
    //从当前图形上下文获取图片
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束图形上下文对象
    UIGraphicsEndImageContext();
    
    //使用图片(保存到相册)
    UIImageWriteToSavedPhotosAlbum(getImage, self, @selector(image:didFinishSavingWithError:contextInfo:), @"get");
    
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;{
    
    if (!error) {
        
//        NSLog(@"成功");
        
    }else{
        
        NSLog(@"失败");
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.drawingBoardView.delegate = self;
    
    //添加监听事件
    [self.redButton addTarget:self action:@selector(selectColour:) forControlEvents:UIControlEventTouchUpInside];
    [self.greenButton addTarget:self action:@selector(selectColour:) forControlEvents:UIControlEventTouchUpInside];
    [self.blueButton addTarget:self action:@selector(selectColour:) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

//按钮的点击事件
- (void)selectColour:(UIButton *)sender{

    
    self.drawingBoardView.penColour = sender.backgroundColor;
    
}

- (CGFloat)drawingBoard:(UIView *)drawingBoard withDrawingLineWidth:(CGFloat)lineWidth{
    
    return self.slider.value;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}


@end
