//
//  JSCoordinateView.m
//  Demos
//
//  Created by ShenYj on 16/9/6.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSCoordinateView.h"

@interface JSCoordinateView ()

// 纬度坐标
@property (nonatomic,strong) UILabel *latitudeLabel;
// 经度坐标
@property (nonatomic,strong) UILabel *longitudeLabel;

@end

@implementation JSCoordinateView


- (instancetype)init{
    self = [super init];
    if (self) {
        
        [self prepareView];
    }
    return self;
}

- (void)setCoordinate:(CLLocationCoordinate2D)coordinate{
    
    _coordinate = coordinate;
    
    self.latitudeLabel.text = [NSString stringWithFormat:@"纬度:%.5f",coordinate.latitude];
    self.longitudeLabel.text = [NSString stringWithFormat:@"经度:%.5f",coordinate.longitude];
    
}

#pragma mark - prepare view
- (void)prepareView{
    
    self.backgroundColor = [UIColor js_colorWithHex:0xF5DEB3];
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor js_colorWithHex:0xA020F0].CGColor;
    
    [self addSubview:self.latitudeLabel];
    [self addSubview:self.longitudeLabel];
    
    NSArray *coordinateArr = @[self.latitudeLabel,self.longitudeLabel];
    [coordinateArr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:5 leadSpacing:5 tailSpacing:5];
    [coordinateArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self).mas_offset(-10);
        make.centerX.mas_equalTo(self);
    }];
    
}

#pragma mark - lazy

- (UILabel *)latitudeLabel{
    if (_latitudeLabel == nil) {
        _latitudeLabel = [[UILabel alloc ]init];
        _latitudeLabel.font = [UIFont systemFontOfSize:10];
        _latitudeLabel.textAlignment = NSTextAlignmentCenter;
        _latitudeLabel.layer.borderColor = [UIColor js_colorWithHex:0x8B658B].CGColor;
        _latitudeLabel.layer.borderWidth = 2;
    }
    return _latitudeLabel;
}
- (UILabel *)longitudeLabel{
    if (_longitudeLabel == nil) {
        _longitudeLabel = [[UILabel alloc] init];
        _longitudeLabel.font = [UIFont systemFontOfSize:10];
        _longitudeLabel.textAlignment = NSTextAlignmentCenter;
        _longitudeLabel.layer.borderColor = [UIColor js_colorWithHex:0x8B658B].CGColor;
        _longitudeLabel.layer.borderWidth = 2;
    }
    return _longitudeLabel;
}

@end
