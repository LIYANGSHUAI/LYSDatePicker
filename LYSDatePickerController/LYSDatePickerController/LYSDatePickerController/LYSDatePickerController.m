//
//  LYSDatePickerController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/2.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerController.h"

#define Rect(x,y,w,h) CGRectMake(x, y, w, h)
#define ScreenWidth CGRectGetWidth(self.view.frame)
#define ScreenHeight CGRectGetHeight(self.view.frame)

@interface LYSDatePickerController ()

@end

// 当使用类方法弹出选择器时,默认使用单例模式
static LYSDatePickerController *datePicker = nil;

@implementation LYSDatePickerController

#pragma mark - 弹出日期选择器 -
+ (void)alertDatePicker
{
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    [[self ly_getOuterViewController] presentViewController:datePicker animated:NO completion:^{
        [datePicker showAnimationContentViewWithCompletion:nil];
    }];
}

#pragma mark - 弹出日期选择器,附带类型 -
+ (void)alertDatePickerWithType:(LYSDatePickerType)pickerType
{
    [self alertDatePickerWithType:pickerType selectDate:[NSDate date]];
}

#pragma mark - 弹出日期选择器,附带类型和默认选中日期 -
+ (void)alertDatePickerWithType:(LYSDatePickerType)pickerType selectDate:(NSDate *)selectDate
{
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.selectDate = selectDate;
    datePicker.pickType = pickerType;
    [[self ly_getOuterViewController] presentViewController:datePicker animated:NO completion:^{
        [datePicker showAnimationContentViewWithCompletion:nil];
    }];
}

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

#pragma mark - 创建单例 -
+ (instancetype)shareInstance
{
    if (!datePicker) {
        datePicker = [[LYSDatePickerController alloc] init];
    }
    return datePicker;
}

#pragma mark - 释放单例 -
+ (void)shareRelease
{
    datePicker = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hiddenAnimationContentViewWithCompletion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            datePicker = nil;
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"释放");
}

@end
