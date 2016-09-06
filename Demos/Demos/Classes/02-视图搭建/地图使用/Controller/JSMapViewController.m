//
//  JSMapViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/5.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSMapViewController.h"
#import <MapKit/MapKit.h>

@interface JSMapViewController () <MKMapViewDelegate,CLLocationManagerDelegate>

// 位置管理者
@property (nonatomic,strong) CLLocationManager *locationManager;
// 地图
@property (nonatomic,strong) MKMapView *mapView;
// segmentControl
@property (nonatomic,strong) UISegmentedControl *segmentControl;

@end

@implementation JSMapViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self prepareView];
}

- (void)prepareView{
    
    self.view.backgroundColor = [UIColor js_colorWithHex:0xFFF0F5];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.segmentControl];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(84);
        make.size.mas_equalTo(CGSizeMake(300, 34));
    }];
    
    
    self.mapView.showsUserLocation = YES;
    
    
}



#pragma mark - target

- (void)clickSegment:(UISegmentedControl *)sender{
    
    //MKMapTypeSatelliteFlyover(卫星鸟瞰)与MKMapTypeHybridFlyover(混合鸟瞰)中国暂不支持
    switch (sender.selectedSegmentIndex) {
            
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        case 3:
            self.mapView.mapType = MKMapTypeSatelliteFlyover;
            break;
        case 4:
            self.mapView.mapType = MKMapTypeHybridFlyover;
            break;
        default:
            break;
    }
    
}



#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"%f--%f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    NSLog(@"%f--%f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
    
}

//- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//
//    [self.mapView removeFromSuperview];
//    [self.view addSubview:mapView];
//}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //CLLocation 位置对象
    CLLocation *location = locations.lastObject;
    //打印坐标(经纬度)
    NSLog(@"%f, %f", location.coordinate.latitude, location.coordinate.longitude);
    //[manager stopUpdatingLocation];停止定位(一次性定位)

}

#pragma mark - lazy

- (CLLocationManager *)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.distanceFilter = 10;// 距离筛选器
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;// 期望精确度
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (MKMapView *)mapView{
    if (_mapView == nil) {
        _mapView = [[MKMapView alloc] init];
        _mapView.userTrackingMode = MKUserTrackingModeFollow;
        _mapView.delegate = self;
    }
    return _mapView;
}

- (UISegmentedControl *)segmentControl{
    if (_segmentControl == nil) {
        NSArray *items = @[@"标准",@"卫星",@"混合",@"卫星鸟瞰",@"混合鸟瞰",];
        _segmentControl = [[UISegmentedControl alloc] initWithItems:items];
        _segmentControl.selectedSegmentIndex = 0;
        [_segmentControl addTarget:self action:@selector(clickSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.mapView removeFromSuperview];
    
}



@end
