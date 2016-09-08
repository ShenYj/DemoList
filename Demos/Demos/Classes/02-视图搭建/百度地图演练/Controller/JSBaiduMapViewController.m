//
//  JSBaiduMapViewController.m
//  Demos
//
//  Created by ShenYj on 16/9/8.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSBaiduMapViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

// AK:  Ew7oKDgl3PMv1NGm6aaTG8eOhLLiZxkh

@interface JSBaiduMapViewController () <BMKMapViewDelegate,BMKPoiSearchDelegate,BMKLocationServiceDelegate>

@property (nonatomic,strong) UIButton *poiButton;
@property (nonatomic,strong) UIButton *trackingButton;

@property (nonatomic,strong) BMKLocationService *locationService;
@property (nonatomic,weak) BMKMapView *mapView;
@property (nonatomic,strong) BMKPoiSearch *searcher;

@end

@implementation JSBaiduMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareView];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    self.searcher.delegate = nil;
}

- (void)setupUI {
    
    [self.view addSubview:self.poiButton];
    [self.view addSubview:self.trackingButton];
    
    [self.trackingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(5);
        make.top.mas_equalTo(self.view).mas_offset(69);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    [self.poiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(69);
        make.right.mas_equalTo(self.view).mas_offset(-5);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
}

- (void)prepareView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    BMKMapView* mapView = [[BMKMapView alloc]init];
    self.view = mapView;
    self.mapView.delegate = self;
    self.mapView = mapView;
    
    //初始化BMKLocationService
    self.locationService = [[BMKLocationService alloc]init];
    self.locationService.delegate = self;

    //启动LocationService
    [self.locationService startUserLocationService];
    self.locationService.distanceFilter = 100;
    
}

#pragma mark - target

- (void)clickTrackingButton:(UIButton *)sender{
    
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(self.locationService.userLocation.location.coordinate.latitude, self.locationService.userLocation.location.coordinate.longitude);
//    self.mapView.showsUserLocation = NO;//先关闭显示的定位图层
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    self.mapView.showsUserLocation = YES;//显示定位图层
    self.mapView.zoomLevel = 16;
    
    
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.locationService.userLocation.location.coordinate.latitude, self.locationService.userLocation.location.coordinate.longitude);
    annotation.coordinate = coordinate;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error || placemarks.count == 0) {
            NSLog(@"坐标转换失败:%@",error);
            return ;
        }
        
        annotation.title = placemarks.lastObject.name;
        [self.mapView addAnnotation:annotation];
        
    }];

}

- (void)clickPoiButton:(UIButton *)sender {
    
    
    //初始化检索对象
    self.searcher =[[BMKPoiSearch alloc]init];
    self.searcher.delegate = self;
    
    //发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = 0;
    option.pageCapacity = 10;
    option.location = CLLocationCoordinate2DMake(self.mapView.region.center.latitude, self.mapView.region.center.longitude);
    option.keyword = @"酒店";
    
    BOOL flag = [_searcher poiSearchNearBy:option];
    if(flag){
        NSLog(@"周边检索发送成功");
    }else{
        NSLog(@"周边检索发送失败");
    }
    // 查询时保证地图初始化完成
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}

#pragma mark - BMKLocationServiceDelegate

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    //NSLog(@"heading is %@",userLocation.heading);
    
    
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    //NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

/**
 *在将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser{
    
}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser{
    
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error{
    
    NSLog(@"定位失败,Error:%@",error);
}


#pragma mark - BMKPoiSearchDelegate

// 实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        
        for (BMKPoiInfo *info in poiResultList.poiInfoList) {
            
            BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(info.pt.latitude, info.pt.longitude);
            annotation.coordinate = coordinate;
            annotation.title = info.name;
            annotation.subtitle = info.address;
            [self.mapView addAnnotation:annotation];
        }
        
        
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
    
    NSLog(@"%d",poiResultList.totalPoiNum);
}


#pragma mark - BMKMapViewDelegate


/**
 *地图初始化完毕时会调用此接口
 *@param mapview 地图View
 */
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView{
    
    
}



// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

#pragma mark - lazy

- (UIButton *)poiButton{
    if (_poiButton == nil) {
        _poiButton = [[UIButton alloc] init];
        _poiButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _poiButton.layer.borderColor = [UIColor js_colorWithHex:0x7B68EE].CGColor;
        _poiButton.layer.borderWidth = 2;
        [_poiButton setTitle:@"POI搜索" forState:UIControlStateNormal];
        [_poiButton setTitleColor:[UIColor js_colorWithHex:0x8B658B] forState:UIControlStateNormal];
        [_poiButton addTarget:self action:@selector(clickPoiButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _poiButton;
}

- (UIButton *)trackingButton{
    if (_trackingButton == nil) {
        _trackingButton = [[UIButton alloc] init];
        _trackingButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _trackingButton.layer.borderColor = [UIColor js_colorWithHex:0x7B68EE].CGColor;
        _trackingButton.layer.borderWidth = 2;
        [_trackingButton setTitle:@"定位" forState:UIControlStateNormal];
        [_trackingButton setTitleColor:[UIColor js_colorWithHex:0x8B658B] forState:UIControlStateNormal];
        [_trackingButton addTarget:self action:@selector(clickTrackingButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _trackingButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
