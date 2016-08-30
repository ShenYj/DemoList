//
//  JSMenumHeader.h
//  Demos
//
//  Created by ShenYj on 16/8/30.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSSectionModel.h"

@interface JSMenumHeader : UITableViewHeaderFooterView

@property (nonatomic,assign) JSSectionModel *model;

@property (nonatomic,copy) void (^handler)();

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
