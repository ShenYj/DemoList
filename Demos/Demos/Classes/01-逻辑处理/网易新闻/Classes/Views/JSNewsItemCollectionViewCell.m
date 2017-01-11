//
//  JSNewsItemCollectionViewCell.m
//  SYJNeteaseNews
//
//  Created by ShenYj on 2017/1/4.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSNewsItemCollectionViewCell.h"
#import "JSNewsTableViewController.h"

@interface JSNewsItemCollectionViewCell ()

/** NewsTableViewController */
@property (nonatomic) JSNewsTableViewController *newsTableViewController;

@end

@implementation JSNewsItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareNewsItemCollectionViewCell];
    }
    return self;
}

- (void)prepareNewsItemCollectionViewCell {
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.newsTableViewController.tableView];
    [self.newsTableViewController.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    self.newsTableViewController.urlString = urlString;
}


#pragma mark
#pragma mark - lazy

- (JSNewsTableViewController *)newsTableViewController {
    if (!_newsTableViewController) {
        _newsTableViewController = [[JSNewsTableViewController alloc] init];
    }
    return _newsTableViewController;
}

@end
