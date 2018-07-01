//
//  LYSDatePickerSelectDelegate.h
//  LYSDatePickerController
//
//  Created by liyangshuai on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LYSDatePickerController;

@protocol LYSDatePickerSelectDelegate <NSObject>

@optional
// 日期选择器点击确定按钮时触发
- (void)pickerViewController:(LYSDatePickerController *)pickerVC didSelectDate:(NSDate *)date;
// 日期选择器生命周期
- (void)pickerViewControllerWillAppear:(LYSDatePickerController *)pickerVC;
- (void)pickerViewControllerDidAppear:(LYSDatePickerController *)pickerVC;
- (void)pickerViewControllerWillDisAppear:(LYSDatePickerController *)pickerVC;
- (void)pickerViewControllerdidDisAppear:(LYSDatePickerController *)pickerVC;
// 日期选择器点击取消按钮时触发
- (void)pickerViewControllerDidCancel:(LYSDatePickerController *)pickerVC;

@end
