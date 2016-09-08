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


// AK:  Ew7oKDgl3PMv1NGm6aaTG8eOhLLiZxkh

@interface JSBaiduMapViewController () <BMKMapViewDelegate,BMKPoiSearchDelegate>

@property (nonatomic,weak) BMKMapView *mapView;
@property (nonatomic,strong) BMKPoiSearch *searcher;

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
    self.searcher.delegate = nil;
}

- (void)prepareView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.view = mapView;
    self.mapView = mapView;
    
    // 查询时保证地图初始化完成
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //初始化检索对象
        self.searcher =[[BMKPoiSearch alloc]init];
        self.searcher.delegate = self;
        //发起检索
        BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
        option.pageIndex = 0;
        option.pageCapacity = 10;
        option.location = CLLocationCoordinate2DMake(39.915, 116.404);
        option.keyword = @"小吃";
        BOOL flag = [_searcher poiSearchNearBy:option];
        if(flag)
        {
            NSLog(@"周边检索发送成功");
        }
        else
        {
            NSLog(@"周边检索发送失败");
        }
        
    });
    

}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
