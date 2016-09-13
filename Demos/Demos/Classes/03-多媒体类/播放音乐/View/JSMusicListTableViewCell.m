//
//  JSMusicListTableViewCell.m
//  Demos
//
//  Created by ShenYj on 16/9/14.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

static CGFloat const JSMusicListTableViewCellMusicNameLabelHeight = 30;
static CGFloat const JSMusicListTableViewCellMusicNameLabelHorizontalMargin = 20;

static CGFloat const JSMusicListTableViewCellSingerNameLabelHeight = 30;
static CGFloat const JSMusicListTableViewCellSingerNameLabelVerticalMargin = 20;

static CGFloat const JSMusicListTableViewCellAlbumImageViewSize = 40;
static CGFloat const JSMusicListTableViewCellAlbumImageViewMargin = 10;

#import "JSMusicListTableViewCell.h"

@interface JSMusicListTableViewCell ()

@property (nonatomic,strong) UILabel *musicNameLabel;
@property (nonatomic,strong) UILabel *singerNameLabel;
@property (nonatomic,strong) UIImageView *albumImageView;

@end

@implementation JSMusicListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self prepareView];
    }
    return self;
}

- (void)prepareView{
    
    
    [self.contentView addSubview:self.albumImageView];
    [self.contentView addSubview:self.musicNameLabel];
    [self.contentView addSubview:self.singerNameLabel];
    
    
    [self.albumImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).mas_offset(JSMusicListTableViewCellAlbumImageViewMargin);
        make.size.mas_equalTo(CGSizeMake(JSMusicListTableViewCellAlbumImageViewSize, JSMusicListTableViewCellAlbumImageViewSize));
    }];
    
    
    [self.musicNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.albumImageView.mas_right).mas_offset(JSMusicListTableViewCellMusicNameLabelHorizontalMargin);
        make.centerY.mas_equalTo(self.albumImageView);
        make.height.mas_equalTo(JSMusicListTableViewCellMusicNameLabelHeight);
        make.right.mas_equalTo(self.contentView).mas_offset(-JSMusicListTableViewCellMusicNameLabelHorizontalMargin);
    }];
    
    [self.singerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.albumImageView);
        make.top.mas_equalTo(self.albumImageView.mas_bottom).mas_offset(JSMusicListTableViewCellSingerNameLabelVerticalMargin);
        make.right.mas_equalTo(self.musicNameLabel);
        make.height.mas_equalTo(JSMusicListTableViewCellSingerNameLabelHeight);
    }];
}

- (void)setModel:(JSMModel *)model{
    
    _model = model;
    
    self.musicNameLabel.text = model.name;
    self.singerNameLabel.text = model.singer;
    self.albumImageView.image = [UIImage imageNamed:model.image];
}

#pragma mark - lazy

- (UILabel *)musicNameLabel {
    
    if (_musicNameLabel == nil) {
        _musicNameLabel = [[UILabel alloc] init];
    }
    return _musicNameLabel;
}

- (UILabel *)singerNameLabel {
    
    if (_singerNameLabel == nil) {
        _singerNameLabel = [[UILabel alloc] init];
    }
    return _singerNameLabel;
}

- (UIImageView *)albumImageView {
    
    if (_albumImageView == nil) {
        _albumImageView = [[UIImageView alloc] init];
    }
    return _albumImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    NSLog(@"%s",__func__);
    // Configure the view for the selected state
}



@end
