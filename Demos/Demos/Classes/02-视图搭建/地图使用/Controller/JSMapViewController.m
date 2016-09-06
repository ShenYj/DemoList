//
//  JSMapViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/5.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSMapViewController.h"
#import <MapKit/MapKit.h>
#import "JSZoomButton.h"


@interface JSMapViewController () <MKMapViewDelegate,CLLocationManagerDelegate>

// 位置管理者
@property (nonatomic,strong) CLLocationManager *locationManager;
// 地图
@property (nonatomic,strong) MKMapView *mapView;
// segmentControl
@property (nonatomic,strong) UISegmentedControl *segmentControl;
// 定位按钮
@property (nonatomic,strong) UIButton *trackingButton;
// 放大
@property (nonatomic,strong) JSZoomButton *zoomIn;
// 缩小
@property (nonatomic,strong) JSZoomButton *zoomOut;

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
    [self.view addSubview:self.trackingButton];
    [self.view addSubview:self.zoomIn];
    [self.view addSubview:self.zoomOut];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).mas_offset(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(84);
        make.size.mas_equalTo(CGSizeMake(300, 34));
    }];
    
    [self.trackingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(5);
        make.right.mas_equalTo(self.segmentControl.mas_left).mas_offset(-5);
        make.top.mas_equalTo(self.segmentControl);
        make.height.mas_equalTo(34);
    }];
    
    [self.zoomIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 34));
        make.centerY.mas_equalTo(self.view).mas_offset(0);
    }];
    
    [self.zoomOut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 34));
        make.top.mas_equalTo(self.zoomIn.mas_bottom).mas_offset(5);
    }];
    
    
    
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

- (void)clickTrackingButton:(UIButton *)sender{
    
    self.mapView.showsUserLocation = YES;
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    //self.mapView.userTrackingMode = MKUserTrackingModeFollow;
}

- (void)clickZoomButton:(JSZoomButton *)sender{
    
    switch (sender.zoomType) {
        case ZoomTypeIn:
            
            break;
        case ZoomTypeOut:
            
            break;
        default:
            break;
    }
}


#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:self.mapView.userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count == 0 || error) {
            
            return ;
        }
        
        CLPlacemark *placeMark = placemarks.lastObject;
        
        self.mapView.userLocation.title = placeMark.locality;
        self.mapView.userLocation.subtitle = placeMark.name;
        
    }];
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //CLLocation 位置对象
    //CLLocation *location = locations.lastObject;
    //打印坐标(经纬度)
    // NSLog(@"%f, %f", location.coordinate.latitude, location.coordinate.longitude);
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
        _mapView.delegate = self;
    }
    return _mapView;
}

- (UISegmentedControl *)segmentControl{
    if (_segmentControl == nil) {
        NSArray *items = @[@"标准",@"卫星",@"混合",@"卫星鸟瞰",@"混合鸟瞰"];
        _segmentControl = [[UISegmentedControl alloc] initWithItems:items];
        _segmentControl.selectedSegmentIndex = 0;
        [_segmentControl addTarget:self action:@selector(clickSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}

- (UIButton *)trackingButton{
    if (_trackingButton == nil) {
        _trackingButton = [[UIButton alloc]init];
        [_trackingButton setTitle:@"定位" forState:UIControlStateNormal];
        _trackingButton.layer.borderColor = [UIColor js_colorWithHex:0x7B68EE].CGColor;
        _trackingButton.layer.borderWidth = 2;
        [_trackingButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_trackingButton addTarget:self action:@selector(clickTrackingButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _trackingButton;
}

- (JSZoomButton *)zoomIn{
    if (_zoomIn == nil) {
        _zoomIn = [[JSZoomButton alloc] init];
        [_zoomIn setTitle:@"放大" forState:UIControlStateNormal];
    }
    return _zoomIn;
}

- (JSZoomButton *)zoomOut{
    if (_zoomOut == nil) {
        _zoomOut = [[JSZoomButton alloc] init];
        [_zoomOut setTitle:@"缩小" forState:UIControlStateNormal];
    }
    return _zoomOut;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.mapView removeFromSuperview];
    
}



@end
