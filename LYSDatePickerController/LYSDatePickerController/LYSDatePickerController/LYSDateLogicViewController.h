//
//  LYSDateLogicViewController.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerViewController.h"
#import "LYSDatePickerTypeDayAndTimeDelegate.h"
#import "LYSDatePickerTypeDayDelegate.h"
#import "LYSDatePickerTypeTimeDelegate.h"

typedef enum : NSUInteger {
    LYSDatePickerTypeDay,                       // 年月日
    LYSDatePickerTypeDayAndTime,                // 年月日,时分
    LYSDatePickerTypeTime,                      // 时分
} LYSDatePickerType;

@interface LYSDateLogicViewController : LYSDatePickerViewController

// 选择器itemLabel,可以通过此属性对选择器设置字体大小和颜色,背景色以及对其方式
@property (nonatomic,strong,readonly)UILabel *subLabel;
// 日期开始时间
@property (nonatomic,assign)int fromYear;
// 日期结束时间
@property (nonatomic,assign)int toYear;
// 默认选中日期
@property (nonatomic,strong)NSDate *selectDate;
// 选择器类型
@property (nonatomic,assign)LYSDatePickerType pickType;

// 是否对某一粒度进行无限循环,默认是NO
@property(nonatomic, assign)BOOL yearLoop;
@property(nonatomic, assign)BOOL monthLoop;
@property(nonatomic, assign)BOOL dayLoop;
@property(nonatomic, assign)BOOL hourLoop;
@property(nonatomic, assign)BOOL minuteLoop;

// 是否显示星期几
@property(nonatomic, assign)BOOL showWeakDay;
// 星期显示类型
@property(nonatomic, assign)LYSDatePickerWeakDayType weakDayType;

@end
