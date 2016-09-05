//
//  SJFriendsCell.m
//  申延杰(UI基础)
//
//  Created by ShenYj on 16/4/21.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSHeadCell.h"
#import "JSFriendsModel.h"
#import "Masonry.h"


#define KUserIconWH 50
#define KMargin 15

@interface JSHeadCell ()

@property (nonatomic,weak) UIImageView *userIconImageView;
@property (nonatomic,weak) UILabel *userNameLabel;
@property (nonatomic,weak) UILabel *userContentLabel;
@property (nonatomic,weak) UIImageView *userPicturesImageView;
@property (nonatomic,strong) MASConstraint *sizeConstrain;

@end
@implementation JSHeadCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIImageView *userIconImageView = [[UIImageView alloc]init];
        self.userIconImageView = userIconImageView;
        [self addSubview:userIconImageView];
        
        UILabel *userNameLabel = [[UILabel alloc]init];
        self.userNameLabel = userNameLabel;
        [self addSubview:userNameLabel];
        
        UILabel *userContentLabel = [[UILabel alloc]init];
        self.userContentLabel = userContentLabel;
        [self addSubview:userContentLabel];
        
        UIImageView *userPicturesImageView = [[UIImageView alloc]init];
        self.userPicturesImageView = userPicturesImageView;
        [self addSubview:userPicturesImageView];
        
        //设置约束
        [self setSubViewsContraints];

        //设置属性
        [self setSubViewsProperty];
        
    }
    
    return self;
    
}
#pragma mark --  subViewsContraints

- (void)setSubViewsContraints{
    
    [self.userIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).mas_offset(KMargin);
        make.top.mas_equalTo(self).mas_offset(KMargin);
        make.width.height.mas_offset(KUserIconWH);
        
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.userIconImageView);
        make.left.mas_equalTo(self.userIconImageView.mas_right).mas_offset(KMargin);
        make.height.mas_offset(KMargin);
        
    }];
    
    [self.userContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).mas_offset(KMargin);
        make.right.mas_equalTo(self).mas_offset(-KMargin);
        make.top.mas_equalTo(self.userIconImageView.mas_bottom).mas_offset(KMargin);
        
    }];
    
    [self.userPicturesImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.userContentLabel.mas_bottom).mas_offset( KMargin );
        make.bottom.mas_equalTo(self).mas_offset( -KMargin );
        make.centerX.mas_equalTo(self);
        self.sizeConstrain = make.size.mas_offset(CGSizeZero);
    }];
    
}

- (void)setSubViewsProperty{
    
    //图片未做处理
    self.userIconImageView.layer.cornerRadius = 25;
    self.userIconImageView.clipsToBounds = YES;//self.userIconImageView.layer.masksToBounds = YES;
    
    self.userNameLabel.font = [UIFont systemFontOfSize:14];
    
    self.userContentLabel.numberOfLines = 0;
    self.userContentLabel.font = [UIFont systemFontOfSize:13];
    
}

- (void)setFriends:(JSFriendsModel *)friends{
    
    _friends = friends;
    
    self.userIconImageView.image = friends.headImgImage;
    self.userNameLabel.text = friends.nickname;
    self.userContentLabel.text = friends.content;
    
    if (self.friends.picture.length > 0) {
        
        self.userPicturesImageView.hidden = NO;
        self.userPicturesImageView.image = friends.pictureImage;
        
        [self.userPicturesImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            self.sizeConstrain = make.size.mas_offset(friends.pictureImage.size);
            
        }];
        
    }else{
        
        self.userPicturesImageView.hidden = YES;
        [self.userPicturesImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            self.sizeConstrain = make.size.mas_offset(CGSizeZero);
            
        }];
        
    }

}



@end
