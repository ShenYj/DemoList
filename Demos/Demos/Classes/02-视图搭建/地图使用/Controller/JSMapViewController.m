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
#import "JSAnnotation.h"
#import "JSCoordinateView.h"

static NSString * const reuseIdentifier = @"reuseIdentifier";

@interface JSMapViewController () <MKMapViewDelegate,CLLocationManagerDelegate>

// 位置管理者
@property (nonatomic,strong) CLLocationManager *locationManager;
// 地图
@property (nonatomic,strong) MKMapView *mapView;
// segmentControl
@property (nonatomic,strong) UISegmentedControl *segmentControl;
// 定位按钮
@property (nonatomic,strong) UIButton *trackingButton;
// 是否显示坐标视图按钮
@property (nonatomic,strong) UIButton *showCoordinateViewButton;
// 放大
@property (nonatomic,strong) JSZoomButton *zoomIn;
// 缩小
@property (nonatomic,strong) JSZoomButton *zoomOut;
// 经纬度视图
@property (nonatomic,strong) JSCoordinateView *coordinateView;

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
    [self.view addSubview:self.showCoordinateViewButton];
    [self.view addSubview:self.zoomIn];
    [self.view addSubview:self.zoomOut];
    [self.view addSubview:self.coordinateView];
    
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
    
    [self.showCoordinateViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.trackingButton);
        make.left.mas_equalTo(self.segmentControl.mas_right).mas_offset(5);
        make.right.mas_equalTo(self.view).mas_offset(-5);
        make.bottom.mas_equalTo(self.trackingButton);
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
    
    [self.coordinateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segmentControl.mas_bottom).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(100, 65));
        make.right.mas_equalTo(self.view).mas_offset(-5);
    }];
    
}


// 添加自定义大头针
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
 
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:touch.view];
    
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    if (!self.coordinateView.hidden) {
        
        self.coordinateView.coordinate = coordinate;
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count == 0 || error) {
            NSLog(@"坐标转换失败:%@",error);
            return ;
        }
        
        // 只有在中国区内时,才进行赋值
        CLPlacemark *placeMark = nil;
        
        for (CLPlacemark *obj in placemarks) {
            
            if ([obj.country isEqualToString:@"中国"]) {
                
                placeMark = obj;
            }
        }
        
        if (placeMark == nil) {
            return ;
        }
        
        
        JSAnnotation *annotation = [[JSAnnotation alloc] init];
        annotation.title = placeMark.locality;
        annotation.subtitle = placeMark.name;
        annotation.coordinate = location.coordinate;
        [self.mapView addAnnotation:annotation];
        
        
    }];
    
    
}

#pragma mark - target

// 切换地图点击事件
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

// 定位按钮点击事件
- (void)clickTrackingButton:(UIButton *)sender{
    
    self.mapView.showsUserLocation = YES;
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    //self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
}

// 放大、缩小按钮点击事件
- (void)clickZoomButton:(JSZoomButton *)sender{
    
    NSInteger scale = 0.05 * sender.zoomType;
    
    MKCoordinateSpan zoomSpan = MKCoordinateSpanMake(self.mapView.region.span.latitudeDelta * scale, self.mapView.region.span.longitudeDelta * scale);
    CLLocationCoordinate2D center = self.mapView.region.center;
    
    [self.mapView setRegion:MKCoordinateRegionMake(center, zoomSpan) animated:YES];
    
}

// 显示/隐藏坐标视图按钮点击事件
- (void)clickShowCoordinateViewButton:(UIButton *)sender{
    
    self.showCoordinateViewButton.selected = !sender.isSelected;
    self.coordinateView.hidden = !self.showCoordinateViewButton.isSelected;
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    // 点击定位按钮时刷新坐标视图
    if (!self.coordinateView.hidden) {
        
        self.coordinateView.coordinate = self.mapView.userLocation.coordinate;
    }
    
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

- (UIButton *)showCoordinateViewButton{
    if (_showCoordinateViewButton == nil) {
        _showCoordinateViewButton = [[UIButton alloc] init];
        _showCoordinateViewButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _showCoordinateViewButton.layer.borderColor = [UIColor js_colorWithHex:0x7B68EE].CGColor;
        _showCoordinateViewButton.layer.borderWidth = 2;
        [_showCoordinateViewButton setTitle:@"坐标" forState:UIControlStateNormal];
        [_showCoordinateViewButton setTitleColor:[UIColor js_colorWithHex:0xFF69B4] forState:UIControlStateNormal];
        [_showCoordinateViewButton setTitleColor:[UIColor js_colorWithHex:0xA020F0] forState:UIControlStateSelected];
        [_showCoordinateViewButton addTarget:self action:@selector(clickShowCoordinateViewButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showCoordinateViewButton;
}

- (UIButton *)trackingButton{
    if (_trackingButton == nil) {
        _trackingButton = [[UIButton alloc]init];
        _trackingButton.titleLabel.font = [UIFont systemFontOfSize:12];
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
        _zoomIn.zoomType = ZoomTypeIn;
        [_zoomIn setTitle:@"放大" forState:UIControlStateNormal];
        [_zoomIn addTarget:self action:@selector(clickZoomButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zoomIn;
}

- (JSZoomButton *)zoomOut{
    if (_zoomOut == nil) {
        _zoomOut = [[JSZoomButton alloc] init];
        _zoomOut.zoomType = ZoomTypeOut;
        [_zoomOut setTitle:@"缩小" forState:UIControlStateNormal];
        [_zoomOut addTarget:self action:@selector(clickZoomButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zoomOut;
}

- (JSCoordinateView *)coordinateView{
    if (_coordinateView == nil) {
        _coordinateView = [[JSCoordinateView alloc] init];
        _coordinateView.hidden = YES;
    }
    return _coordinateView;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.mapView.showsUserLocation = NO;
    self.mapView.delegate = nil;
    self.mapView = nil;
    [self.mapView removeFromSuperview];
    
}



@end
