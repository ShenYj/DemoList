//
//  JSADPictureCollectionViewCell.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/5.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSADPictureCollectionViewCell.h"
#import "JSADModel.h"

/** 每部间距 */
static CGFloat const kADPictureCollectionViewMargin = 8.f;
/** 标题字体大小 */
static CGFloat const kTitleLabelFontSize = 13.f;
/** 标题距离父视图右边间距 */
static CGFloat const kTitleLabelRigthMargin = 120.f;

@interface JSADPictureCollectionViewCell ()

/** 图片框 */
@property (nonatomic) UIImageView *pictureView;
/** 标题 */
@property (nonatomic) UILabel *titleLabel;

@end

@implementation JSADPictureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareView];
    }
    return self;
}

- (void)prepareView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.pictureView];
    [self.contentView addSubview:self.titleLabel];
    
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(kADPictureCollectionViewMargin);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-kADPictureCollectionViewMargin);
        make.right.mas_equalTo(self.contentView).mas_offset(-kTitleLabelRigthMargin);
    }];
    
}

- (void)setModel:(JSADModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    [self.pictureView yy_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholder:nil];
}
#pragma mark
#pragma mark - lazy

- (UIImageView *)pictureView {
    if (!_pictureView) {
        _pictureView = [[UIImageView alloc] init];
        _pictureView.backgroundColor = [UIColor whiteColor];
    }
    return _pictureView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kTitleLabelFontSize];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

@end
