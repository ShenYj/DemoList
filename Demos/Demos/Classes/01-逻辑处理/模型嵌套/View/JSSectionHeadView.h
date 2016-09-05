//
//  JSSectionHeaderView.h
//  模型嵌套
//
//  Created by ShenYj on 16/8/30.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSCategoryModel.h"

@interface JSSectionHeadView : UITableViewHeaderFooterView

@property (nonatomic,assign) JSCategoryModel *model;

@property (nonatomic,copy) void (^handler)();

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
