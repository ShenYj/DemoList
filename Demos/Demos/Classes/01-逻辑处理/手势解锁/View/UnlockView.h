//
//  UnlockView.h
//  09-手势解锁
//
//  Created by Apple on 16/5/6.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UnlockView;

@protocol  UnlockViewDelegate <NSObject>

- (void) unlockView:(UnlockView *) unLockView withPwd:(NSString *) pwd;

@end

@interface UnlockView : UIView

//定义属性
@property (nonatomic,weak) id<UnlockViewDelegate> delegate;
@end
