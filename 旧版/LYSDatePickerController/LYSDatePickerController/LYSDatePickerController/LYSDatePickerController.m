//
//  LYSDatePickerController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/2.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerController.h"

#define Rect(x,y,w,h) CGRectMake(x, y, w, h)
#define ScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@interface LYSDatePickerController ()

@end

@implementation LYSDatePickerController

#pragma mark - 设置视图高度 -
+ (void)customPickerViewHeight:(CGFloat)height
{
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.pickViewHeight = height;
}

#pragma mark - 设置开始年份 -
+ (void)customFromYear:(int)fromYear
{
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.fromYear = fromYear;
}

#pragma mark - 设置结束年份 -
+ (void)customToYear:(int)toYear
{
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.toYear = toYear;
}

#pragma mark - 设置默认选中日期 -
+ (void)customSelectDate:(NSDate *)date
{
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.selectDate = date;
}

#pragma mark - 设置弹出类型 -
+ (void)customPickerType:(LYSDatePickerType)type
{
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.pickType = type;
}
#pragma mark - 设置代理 -
+ (void)customPickerDelegate:(id<LYSDatePickerSelectDelegate>)delegate {
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.delegate = delegate;
}

#pragma mark - 监听日期选择回调 -
+ (void)customdidSelectDatePicker:(void(^)(NSDate *date))didSelectDatePicker {
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.didSelectDatePicker = didSelectDatePicker;
}

#pragma mark - 点击页面空白部分是否隐藏日期选择器 -
+ (void)customClickOuterHiddenEnable:(BOOL)clickOuterHiddenEnable {
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.clickOuterHiddenEnable = clickOuterHiddenEnable;
}

#pragma mark - 设置头视图高度 -
+ (void)customPickHeaderHeight:(CGFloat)pickHeaderHeight {
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.pickHeaderHeight = pickHeaderHeight;
}
#pragma mark - 自定义头视图 -
+ (void)customHeaderView:(LYSDatePickerHeaderView *)headerView {
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.headerView = headerView;
}
#pragma mark - 设置是否显示分割线 -
+ (void)customShowIndicator:(BOOL)showIndicator {
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.showIndicator = showIndicator;
}
#pragma mark - 设置分割线颜色 -
+ (void)customIndicatorColor:(UIColor *)indicatorColor {
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.indicatorColor = indicatorColor;
}
#pragma mark - 设置分割线高度 -
+ (void)customIndicatorHeight:(CGFloat)indicatorHeight {
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.indicatorHeight = indicatorHeight;
}
// 设置是否显示星期几
+ (void)customShowWeakDay:(BOOL)showWeakDay {
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.showWeakDay = showWeakDay;
}
// 设置是星期类型
+ (void)customWeakDayType:(BOOL)showWeakDay {
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.showWeakDay = showWeakDay;
}

#pragma mark - 弹出日期选择器 -
+ (void)alertDatePickerInWindowRootVC
{
    [LYSDatePickerController showDatePickerInWindowRootVC];
}

+ (void)alertDatePickerWithController:(UIViewController *)controller
{
    [LYSDatePickerController showDatePickerWithController:controller];
}

#pragma mark - 弹出日期选择器,附带类型 -
+ (void)alertDatePickerInWindowRootVCWithType:(LYSDatePickerType)pickerType
{
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.selectDate = [NSDate date];
    datePicker.pickType = pickerType;
    [LYSDatePickerController showDatePickerInWindowRootVC];
}

+ (void)alertDatePickerWithController:(UIViewController *)controller type:(LYSDatePickerType)pickerType
{
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.selectDate = [NSDate date];
    datePicker.pickType = pickerType;
    [LYSDatePickerController showDatePickerWithController:controller];
}

#pragma mark - 弹出日期选择器,附带类型和默认选中日期 -
+ (void)alertDatePickerInWindowRootVCWithType:(LYSDatePickerType)pickerType selectDate:(NSDate *)selectDate
{
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.selectDate = selectDate;
    datePicker.pickType = pickerType;
    [LYSDatePickerController showDatePickerInWindowRootVC];
}

+ (void)alertDatePickerWithController:(UIViewController *)controller type:(LYSDatePickerType)pickerType selectDate:(NSDate *)selectDate
{
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.selectDate = selectDate;
    datePicker.pickType = pickerType;
    [LYSDatePickerController showDatePickerWithController:controller];;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.clickOuterHiddenEnable) {
        [self hiddenDatePicker];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"释放");
#endif
}

@end
