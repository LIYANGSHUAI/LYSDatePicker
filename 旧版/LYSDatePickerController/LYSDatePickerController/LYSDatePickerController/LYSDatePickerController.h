//
//  LYSDatePickerController.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/2.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDateLogicViewController.h"
#import "LYSDatePickerSelectDelegate.h"

@interface LYSDatePickerController : LYSDateLogicViewController

// 设置视图高度
+ (void)customPickerViewHeight:(CGFloat)height;
// 设置开始年份
+ (void)customFromYear:(int)fromYear;
// 设置结束年份
+ (void)customToYear:(int)toYear;
// 设置默认选中日期
+ (void)customSelectDate:(NSDate *)date;
// 设置弹出类型
+ (void)customPickerType:(LYSDatePickerType)type;
// 设置代理
+ (void)customPickerDelegate:(id<LYSDatePickerSelectDelegate>)delegate;
// 监听日期选择回调
+ (void)customdidSelectDatePicker:(void(^)(NSDate *date))didSelectDatePicker;
// 点击页面空白部分是否隐藏日期选择器
+ (void)customClickOuterHiddenEnable:(BOOL)clickOuterHiddenEnable;
// 设置头视图高度
+ (void)customPickHeaderHeight:(CGFloat)pickHeaderHeight;
// 自定义头视图
+ (void)customHeaderView:(LYSDatePickerHeaderView *)headerView;
// 设置是否显示分割线
+ (void)customShowIndicator:(BOOL)showIndicator;
// 设置分割线颜色
+ (void)customIndicatorColor:(UIColor *)indicatorColor;
// 设置分割线高度
+ (void)customIndicatorHeight:(CGFloat)indicatorHeight;
// 设置是否显示星期几
+ (void)customShowWeakDay:(BOOL)showWeakDay;
// 设置是星期类型
+ (void)customWeakDayType:(BOOL)weakDayType;

// 弹出日期选择器,此方法没有设置类型和默认选中日期
+ (void)alertDatePickerInWindowRootVC;
+ (void)alertDatePickerWithController:(UIViewController *)controller;

// 弹出日期选择器,附带类型,日期为当前时间
+ (void)alertDatePickerInWindowRootVCWithType:(LYSDatePickerType)pickerType;
+ (void)alertDatePickerWithController:(UIViewController *)controller type:(LYSDatePickerType)pickerType;

// 弹出日期选择器,附带类型和默认选中日期
+ (void)alertDatePickerInWindowRootVCWithType:(LYSDatePickerType)pickerType selectDate:(NSDate *)selectDate;
+ (void)alertDatePickerWithController:(UIViewController *)controller type:(LYSDatePickerType)pickerType selectDate:(NSDate *)selectDate;

@end
