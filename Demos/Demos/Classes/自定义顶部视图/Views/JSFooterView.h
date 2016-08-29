//
//  SJFriendsFooterView.h
//  申延杰(UI基础)
//
//  Created by ShenYj on 16/4/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSFriendsModel.h"

@protocol friendsFooterViewBtnClickDelegate <NSObject>

@optional
- (void)friendsFooterViewDelegateWithFooterView:(UIView *)footerView;

@end

@interface JSFooterView : UIView

@property (nonatomic,strong) NSArray *friends;
@property (nonatomic,weak) id<friendsFooterViewBtnClickDelegate> delegate;


@end
