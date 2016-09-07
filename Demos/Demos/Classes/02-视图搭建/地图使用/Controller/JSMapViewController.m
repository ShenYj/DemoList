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
#import "JSNavigationButton.h"
#import "JSCoordinateView.h"
#import "JSAnnotationView.h"
#import "JSNavigationInfoView.h"

@interface JSMapViewController () <MKMapViewDelegate,CLLocationManagerDelegate,JSNavigationInfoViewDelegate>

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
// 导航(使用系统内置地图)
@property (nonatomic,strong) JSNavigationButton *navigationBySystemMapButton;
// 导航(使用自定义地图)
@property (nonatomic,strong) JSNavigationButton *navigationByCustomMapButton;
// 导航信息视图 (填写目标地址)
@property (nonatomic,strong) JSNavigationInfoView *navigationInputView;
// 移除所有大头针
@property (nonatomic,strong) UIButton *removeAnnotationButton;

@end

@implementation JSMapViewController

#pragma mark - ViewControllerMethods



- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self prepareView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.mapView.showsUserLocation = NO;
    self.mapView.delegate = nil;
    self.mapView = nil;
    [self.mapView removeFromSuperview];
    
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
    [self.view addSubview:self.navigationBySystemMapButton];
    [self.view addSubview:self.navigationByCustomMapButton];
    [self.view addSubview:self.navigationInputView];
    [self.view addSubview:self.removeAnnotationButton];
    
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
    
    [self.navigationBySystemMapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.zoomIn);
        make.right.mas_equalTo(self.view).mas_offset(-5);
        make.size.mas_equalTo(CGSizeMake(80, 34));
        make.centerY.mas_equalTo(self.view);
    }];
    
    [self.navigationByCustomMapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.zoomOut);
        make.size.mas_equalTo(CGSizeMake(80, 34));
        make.right.mas_equalTo(self.navigationBySystemMapButton);
    }];
    
    [self.navigationInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).mas_offset(-150);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(300);
    }];
    
    [self.removeAnnotationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.view).mas_offset(-5);
        make.size.mas_equalTo(CGSizeMake(80, 30));
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

// 导航按钮点击事件
- (void)clickNavigationButton:(JSNavigationButton *)sender{
    
    // 显示目标地点录入视图
    self.navigationInputView.hidden = NO;
    
    switch (sender.navigationType) {
            
        case NavigationTypeBySystemMap:
            NSLog(@"NavigationTypeBySystemMap");
            self.navigationInputView.inputViewType = JSNavigationInputViewTypeSystemType;
            break;
        case NavigationTypeByCustomMap:
            NSLog(@"NavigationTypeByCustomMap");
            self.navigationInputView.inputViewType = JSNavigationInputViewTypeCustomType;
            break;
            
        default:
            break;
    }
}

// 显示/隐藏坐标视图按钮点击事件
- (void)clickShowCoordinateViewButton:(UIButton *)sender{
    
    self.showCoordinateViewButton.selected = !sender.isSelected;
    self.coordinateView.hidden = !self.showCoordinateViewButton.isSelected;
}

// 移除地图中的所有大头针
- (void)clickRemoveAllAnnotationButton:(UIButton *)sender{
    
    [self.mapView removeAnnotations:self.mapView.annotations];
}


#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    // 排除定位大头针
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    JSAnnotationView *annotationView = [JSAnnotationView annotationWihMapView:mapView];
    
    return annotationView;
}

// 设置地图覆盖物样式
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
    MKPolylineRenderer *polylineRender = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    // 设置样式
    polylineRender.strokeColor = [UIColor purpleColor];
    polylineRender.lineWidth = 2;
    
    return polylineRender;
    
}

// 已经添加大头针时调用
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views{
    
    for (MKAnnotationView *annoV in views) {
        
        if ([annoV.annotation isKindOfClass:[MKUserLocation class]]) {
            return ;
        }
        CGRect frame = annoV.frame;
        annoV.frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
        
        [UIView animateWithDuration:0.5 animations:^{
            annoV.frame = frame;
        }];
    }
}

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

#pragma mark - JSNavigationInfoViewDelegate

- (void)navigationInfoView:(JSNavigationInfoView *)navigationInfoView withDestinationString:(NSString *)destinationString withCompletionHandler:(void (^)())completionHandler{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:destinationString completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error || placemarks.count == 0 ) {
            NSLog(@"地标转换失败:%@",error);
            return ;
        }
        
        // 当前地图项目
        MKMapItem *currentMapItem = [MKMapItem mapItemForCurrentLocation];
        
        // 目标地图项目
        CLPlacemark *placeMark_cl = [[CLPlacemark alloc] initWithPlacemark:placemarks.lastObject];
        MKPlacemark *placeMark_mk = [[MKPlacemark alloc] initWithPlacemark:placeMark_cl];
        MKMapItem *destinationMapItem = [[MKMapItem alloc] initWithPlacemark:placeMark_mk];
        
        
        // 打开内置地图进行导航
        if (navigationInfoView.inputViewType == JSNavigationInputViewTypeSystemType) {
            
            
            [MKMapItem openMapsWithItems:@[currentMapItem,destinationMapItem] launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving}];
            
            return;
            
        }
        
        // 使用自定义的地图进行导航  (JSNavigationInputViewTypeCustomType)
        MKDirectionsRequest *directionRequest = [[MKDirectionsRequest alloc] init];
        directionRequest.source = currentMapItem;
        directionRequest.destination = destinationMapItem;
        MKDirections *direction = [[MKDirections alloc] initWithRequest:directionRequest];
        
        [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
           
            if (error || response == nil) {
                NSLog(@"导航失败:%@",error);
                return ;
            }
            
            for (MKRoute *route in response.routes) {
                
                // 添加地图覆盖物到地图上 (需要提前设置样式)
                [self.mapView addOverlay:route.polyline];
                
                for (MKRouteStep *routeStep in route.steps) {
                    
                    // 每一步路线
                    NSLog(@"%@",routeStep.instructions);
                    
                }
            }
            
            
        }];
        
    }];
    
    
    
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

- (JSNavigationButton *)navigationBySystemMapButton{
    if (_navigationBySystemMapButton == nil) {
        _navigationBySystemMapButton = [[JSNavigationButton alloc] init];
        _navigationBySystemMapButton.navigationType = NavigationTypeBySystemMap;
        [_navigationBySystemMapButton setTitle:@"系统地图" forState:UIControlStateNormal];
        [_navigationBySystemMapButton addTarget:self action:@selector(clickNavigationButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navigationBySystemMapButton;
}

- (JSNavigationButton *)navigationByCustomMapButton{
    if (_navigationByCustomMapButton == nil) {
        _navigationByCustomMapButton = [[JSNavigationButton alloc] init];
        _navigationByCustomMapButton.navigationType = NavigationTypeByCustomMap;
        [_navigationByCustomMapButton setTitle:@"自定义导航" forState:UIControlStateNormal];
        [_navigationByCustomMapButton addTarget:self action:@selector(clickNavigationButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navigationByCustomMapButton;
}

- (JSNavigationInfoView *)navigationInputView{
    if (_navigationInputView == nil) {
        _navigationInputView = [[JSNavigationInfoView alloc] init];
        _navigationInputView.delegate = self;
        _navigationInputView.hidden = YES;
    }
    return _navigationInputView;
}

- (UIButton *)removeAnnotationButton{
    if (_removeAnnotationButton == nil) {
        _removeAnnotationButton = [[UIButton alloc] init];
        _removeAnnotationButton.layer.borderColor = [UIColor js_colorWithHex:0xFF1493].CGColor;
        _removeAnnotationButton.layer.borderWidth = 2;
        _removeAnnotationButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_removeAnnotationButton setTitleColor:[UIColor js_colorWithHex:0x363636] forState:UIControlStateNormal];
        [_removeAnnotationButton setTitle:@"移除大头针" forState:UIControlStateNormal];
        [_removeAnnotationButton addTarget:self action:@selector(clickRemoveAllAnnotationButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeAnnotationButton;
}





@end
