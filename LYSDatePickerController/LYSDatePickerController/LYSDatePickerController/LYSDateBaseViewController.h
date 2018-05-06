//
//  LYSDateBaseViewController.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYSDatePickerSelectDelegate.h"

extern NSString *const LYSDatePickerWillAppearNotifition;           // 窗口将要出现
extern NSString *const LYSDatePickerDidAppearNotifition;            // 窗口已经出现
extern NSString *const LYSDatePickerWillDisAppearNotifition;        // 窗口将要消失
extern NSString *const LYSDatePickerDidDisAppearNotifition;         // 窗口已经消失

extern NSString *const LYSDatePickerDidCancelNotifition;            // 取消弹窗
extern NSString *const LYSDatePickerDidSelectDateNotifition;        // 提交日期

@interface LYSDateBaseViewController : UIViewController

// 监听代理
@property(nonatomic, assign)id<LYSDatePickerSelectDelegate> delegate;

// 提交日期选择器
@property(nonatomic, copy)void(^didSelectDatePicker)(NSDate *date);

// 获取选择日期
@property(nonatomic, strong)NSDate *date;

// 提交日期
- (void)commitDatePicker;

// 取消弹窗
- (void)cancelDatePicker;

// 创建单例
+ (instancetype)shareInstance;
// 释放单例
+ (void)shareRelease;

// 获取最外层控制器
+ (UIViewController *)getOuterViewController;
// 创建给定颜色和透明度的图片
- (UIImage *)imageWithColor:(UIColor *)color alpha:(CGFloat)alpha;

@end
