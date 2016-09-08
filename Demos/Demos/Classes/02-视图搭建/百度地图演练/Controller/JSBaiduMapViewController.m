//
//  JSBaiduMapViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/8.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSBaiduMapViewController.h"


// AK:  Ew7oKDgl3PMv1NGm6aaTG8eOhLLiZxkh

@interface JSBaiduMapViewController () <BMKMapViewDelegate>

@property (nonatomic,weak) BMKMapView *mapView;

@end

@implementation JSBaiduMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareView];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
}

- (void)prepareView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.view = mapView;
    self.mapView = mapView;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
