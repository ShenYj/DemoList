//
//  JSNewsImgsTableViewCell.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/5.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSNewsImgsTableViewCell.h"
#import "JSNewsModel.h"

/** 多图样式Cell中配图距离父视图左边间距 */
extern CGFloat const kNewsCellMargin;
/** 标题Label高度 */
static CGFloat const kNewsImgsTitleLabelHeight = 25.f;
/** 标题字体大小 */
static CGFloat const kNewsImgsTitleLabelFontSize = 12.f;
/** 回复数字体大小 */
static CGFloat const kNewsImgsReplyCountLabelFontSize = 8.f;
/** 回复数Label宽度 */
static CGFloat const kNewsImgsReplyCountLabelWidth = 60.f;

@interface JSNewsImgsTableViewCell ()

/** 标题 */
@property (nonatomic) UILabel *titleLabel;
/** 多图 */
@property (nonatomic) NSArray <UIImageView *>* imageViews;
/** 回复数 */
@property (nonatomic) UILabel *replyCount;


@end

@implementation JSNewsImgsTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self prepareImgsCellContent];
    }
    return self;
}

- (void)prepareImgsCellContent {
    
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.replyCount];
    for (UIImageView *imageView in self.imageViews) {
        [self.contentView addSubview:imageView];
    }
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).mas_offset(kNewsCellMargin);
        make.height.mas_equalTo(kNewsImgsTitleLabelHeight);
    }];
    [self.replyCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(kNewsCellMargin);
        make.right.mas_equalTo(self.contentView).mas_offset(-kNewsCellMargin);
        make.height.mas_equalTo(kNewsImgsTitleLabelHeight);
        make.width.mas_equalTo(kNewsImgsReplyCountLabelWidth);
    }];
    [self.imageViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:kNewsCellMargin leadSpacing:5 tailSpacing:kNewsCellMargin];
    [self.imageViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(kNewsCellMargin);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-kNewsCellMargin);
    }];
    
}

- (void)setNewsModel:(JSNewsModel *)newsModel {
    _newsModel = newsModel;
    self.titleLabel.text = newsModel.title;
    self.replyCount.text = [NSString stringWithFormat:@"回复数:%@",newsModel.replyCount];
    [self.imageViews enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            [obj yy_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholder:nil];
        } else {
            NSDictionary *imgDict = newsModel.imgextra[idx - 1];
            [obj yy_setImageWithURL:[NSURL URLWithString:imgDict[@"imgsrc"]] placeholder:nil];
        }
    }];
}


#pragma mark
#pragma mark - lazy

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kNewsImgsTitleLabelFontSize];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (NSArray<UIImageView *> *)imageViews {
    if (!_imageViews) {
        NSMutableArray *tempArr = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [tempArr addObject:imageView];
        }
        _imageViews = tempArr.copy;
    }
    return _imageViews;
}

- (UILabel *)replyCount {
    if (!_replyCount) {
        _replyCount = [[UILabel alloc] init];
        _replyCount.font = [UIFont systemFontOfSize:kNewsImgsReplyCountLabelFontSize];
        _replyCount.textColor = [UIColor lightGrayColor];
    }
    return _replyCount;
}

@end
