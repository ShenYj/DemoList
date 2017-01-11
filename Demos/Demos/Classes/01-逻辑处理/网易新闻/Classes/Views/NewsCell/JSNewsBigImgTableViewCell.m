//
//  JSNewsBigImgTableViewCell.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/5.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSNewsBigImgTableViewCell.h"
#import "JSNewsModel.h"

/** 大图样式Cell中配图距离父视图左边间距 */
extern CGFloat const kNewsCellMargin;
/** 主标题字体大小 */
static CGFloat const kNewsBigImgTitleLabelFontSize = 12.f;
static CGFloat const kNewsBigImgTitleLableHeight = 25.f;
/** 副标题字体大小 */
static CGFloat const kNewsBigImgSubTitleLabelFontSize = 10.f;
static CGFloat const kNewsBigImgSubTitleLabelHeight = 24.f;
/** 评论数 */
static CGFloat const kNewsReplyCountLabelFontSize = 8.f;
static CGFloat const kNewsReplyCountLabelWidth = 60.f;
static CGFloat const kNewsReplyCountLabelHeight = 20.f;

@interface JSNewsBigImgTableViewCell ()

/** 标题 */
@property (nonatomic) UILabel *titleLabel;
/** 大图 */
@property (nonatomic) UIImageView *bigImageView;
/** 副标题 */
@property (nonatomic) UILabel *subTitleLabel;
/** 回复数 */
@property (nonatomic) UILabel *replyCountLabel;

@end

@implementation JSNewsBigImgTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self prepareBigImgCell];
    }
    return self;
}

- (void)prepareBigImgCell {
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.bigImageView];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.replyCountLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.contentView).mas_offset(kNewsCellMargin);
        make.right.mas_equalTo(self.contentView).mas_offset(-kNewsCellMargin);
        make.height.mas_equalTo(kNewsBigImgTitleLableHeight);
    }];
    
    [self.replyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-kNewsCellMargin);
        make.width.mas_equalTo(kNewsReplyCountLabelWidth);
        make.height.mas_equalTo(kNewsReplyCountLabelHeight);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-kNewsCellMargin);
        make.height.mas_equalTo(kNewsBigImgSubTitleLabelHeight);
        make.right.mas_equalTo(self.replyCountLabel.mas_left).mas_offset(-kNewsCellMargin);
    }];
    
    [self.bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(kNewsCellMargin);
        make.left.right.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(self.subTitleLabel.mas_top).mas_offset(-kNewsCellMargin);
    }];
    
}

- (void)setNewsModel:(JSNewsModel *)newsModel {
    _newsModel = newsModel;
    self.titleLabel.text = newsModel.title;
    self.subTitleLabel.text = newsModel.digest;
    self.replyCountLabel.text = [NSString stringWithFormat:@"回复数:%@",newsModel.replyCount];
    [self.bigImageView yy_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholder:nil];
}


#pragma mark
#pragma mark - lazy

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kNewsBigImgTitleLabelFontSize];;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UIImageView *)bigImageView {
    if (!_bigImageView) {
        _bigImageView = [[UIImageView alloc] init];
    }
    return _bigImageView;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont systemFontOfSize:kNewsBigImgSubTitleLabelFontSize];
        _subTitleLabel.textColor = [UIColor grayColor];
    }
    return _subTitleLabel;
}

- (UILabel *)replyCountLabel {
    if (!_replyCountLabel) {
        _replyCountLabel = [[UILabel alloc] init];
        _replyCountLabel.font = [UIFont systemFontOfSize:kNewsReplyCountLabelFontSize];
        _replyCountLabel.textColor = [UIColor lightGrayColor];
    }
    return _replyCountLabel;
}

@end
