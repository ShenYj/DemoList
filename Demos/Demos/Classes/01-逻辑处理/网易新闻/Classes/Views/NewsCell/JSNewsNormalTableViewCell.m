//
//  JSNewsNormalTableViewCell.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/4.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSNewsNormalTableViewCell.h"
#import "JSNewsModel.h"

#pragma mark
#pragma mark - 常量
/** 普通样式Cell中配图的尺寸 */
static CGFloat const kNewsNormalCellImgViewHeight = 60.f;
static CGFloat const kNewsNormalCellImgViewWidth = 80.f;
/** 普通样式Cell中配图距离父视图左边间距 */
extern CGFloat const kNewsCellMargin;
/** 主标题字体大小 */
static CGFloat const kNewsNormalTitleLabelFontSize = 12.f;
/** 副标题字体大小 */
static CGFloat const kNewsNormalSubTitleLabelFontSize = 10.f;
/** 跟帖数Label尺寸 */
static CGFloat const kNewsNormalReplyCountLabelWidth = 60.f;
static CGFloat const kNewsNormalReplyCountLabelFontSize = 8.f;

@interface JSNewsNormalTableViewCell ()

/** 配图 */
@property (nonatomic) UIImageView *img_ImageView;
/** 主标题 */
@property (nonatomic) UILabel *titleLabel;
/** 副标题 */
@property (nonatomic) UILabel *subtitleLabel;
/** 跟帖数 */
@property (nonatomic) UILabel *replyCountLabel;

@end

@implementation JSNewsNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self prepareContentView];
    }
    return self;
}

- (void)prepareContentView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.img_ImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subtitleLabel];
    [self.contentView addSubview:self.replyCountLabel];
    
    [self.img_ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).mas_offset(kNewsCellMargin);
        make.size.mas_offset(CGSizeMake(kNewsNormalCellImgViewWidth, kNewsNormalCellImgViewHeight));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.img_ImageView.mas_right).mas_offset(kNewsCellMargin);
        make.top.mas_equalTo(self.img_ImageView);
        make.right.mas_equalTo(self.contentView).mas_offset(-kNewsCellMargin*2);
    }];
    
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.img_ImageView.mas_right).mas_offset(kNewsCellMargin);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(kNewsCellMargin);
        make.bottom.mas_equalTo(self.img_ImageView);
        make.right.mas_equalTo(self.contentView).mas_offset(-kNewsCellMargin*2);
    }];
    
    [self.replyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.img_ImageView.mas_bottom);
        make.right.mas_equalTo(self.contentView).mas_offset(-kNewsCellMargin);
        make.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(kNewsNormalReplyCountLabelWidth);
    }];

}

- (void)setNewsModel:(JSNewsModel *)newsModel {
    _newsModel = newsModel;
    [self.img_ImageView yy_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] options:YYWebImageOptionShowNetworkActivity];
    self.titleLabel.text = newsModel.title;
    self.subtitleLabel.text = newsModel.digest;
    self.replyCountLabel.text = [NSString stringWithFormat:@"回复量:%@",newsModel.replyCount.stringValue];
}

#pragma mark
#pragma mark - lazy

- (UIImageView *)img_ImageView {
    if (!_img_ImageView) {
        _img_ImageView = [[UIImageView alloc] init];
    }
    return _img_ImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kNewsNormalTitleLabelFontSize];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = [UIFont systemFontOfSize:kNewsNormalSubTitleLabelFontSize];
        _subtitleLabel.numberOfLines = 2;
        _subtitleLabel.textColor = [UIColor grayColor];
    }
    return _subtitleLabel;
}

- (UILabel *)replyCountLabel {
    if (!_replyCountLabel) {
        _replyCountLabel = [[UILabel alloc] init];
        _replyCountLabel.font = [UIFont systemFontOfSize:kNewsNormalReplyCountLabelFontSize];
        _replyCountLabel.textColor = [UIColor lightGrayColor];
        _replyCountLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _replyCountLabel;
}

@end
