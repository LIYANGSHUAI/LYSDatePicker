//
//  LYSDatePopViewController.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDateBaseViewController.h"
#import "LYSDateContentView.h"

@interface LYSDatePopViewController : LYSDateBaseViewController
// 弹窗弹出视图
@property (nonatomic,strong,readonly)LYSDateContentView *contentView;

@property(nonatomic, assign)BOOL clickOuterHiddenEnable;

// 动画显示contentView
- (void)showAnimationContentViewWithCompletion:(void(^)(BOOL finished))completion;
// 动画隐藏contentView
- (void)hiddenAnimationContentViewWithCompletion:(void(^)(BOOL finished))completion;

// 弹出
- (void)showDatePickerWithController:(UIViewController *)controller;
// 弹出
+ (void)showDatePickerWithController:(UIViewController *)controller;

// 在UIWindow的根视图上弹出
- (void)showDatePickerInWindowRootVC;
// 在UIWindow的根视图上弹出
+ (void)showDatePickerInWindowRootVC;

// 隐藏
- (void)hiddenDatePicker;
// 隐藏
+ (void)hiddenDatePicker;

@end
