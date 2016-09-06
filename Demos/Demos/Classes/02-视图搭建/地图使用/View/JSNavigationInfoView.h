//
//  JSNavigationInfoView.h
//  Demos
//
//  Created by ShenYj on 16/9/6.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    JSNavigationInputViewTypeSystemType,
    JSNavigationInputViewTypeCustomType,
} JSNavigationInputViewType;

@class JSNavigationInfoView;

@protocol JSNavigationInfoViewDelegate <NSObject>

@optional
- (void)navigationInfoView:(JSNavigationInfoView *)navigationInfoView withDestinationString:(NSString *)destinationString withCompletionHandler:(void(^)())completionHandler;


@end

@interface JSNavigationInfoView : UIView

// 输入视图类型
@property (nonatomic,assign) JSNavigationInputViewType inputViewType;
@property (nonatomic,weak) id <JSNavigationInfoViewDelegate> delegate;

@end
