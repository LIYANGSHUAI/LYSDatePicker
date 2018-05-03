//
//  LYSDatePickerController.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/2.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LYSDatePickerTypeDay,
    LYSDatePickerTypeDayAndTime,
    LYSDatePickerTypeTime,
} LYSDatePickerType;

@interface LYSDatePickerController : UIViewController

@property (nonatomic,assign)CGFloat pickViewHeight;
@property (nonatomic,assign)int fromYear;
@property (nonatomic,assign)int toYear;

@property (nonatomic,strong)NSDate *selectDate;

@property (nonatomic,assign)LYSDatePickerType pickType;

- (void)showDatePickerAnimation;
- (void)hiddenDatePickerAnimation;


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
// 弹出日期选择器,附带类型
+ (void)alertDatePickerWithType:(LYSDatePickerType)pickerType;
// 弹出日期选择器,附带类型和默认选中日期
+ (void)alertDatePickerWithType:(LYSDatePickerType)pickerType selectDate:(NSDate *)selectDate;
@end
