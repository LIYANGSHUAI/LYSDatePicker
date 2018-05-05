//
//  LYSDatePickerTypeBase.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSDatePickerTypeBase : NSObject<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,weak)UIView *view;
@property (nonatomic,weak)UIPickerView *pickView;

// 日期开始时间
@property (nonatomic,assign)int fromYear;
// 日期结束时间
@property (nonatomic,assign)int toYear;

@property (nonatomic,assign)int currentYear;
@property (nonatomic,assign)int currentMonth;
@property (nonatomic,assign)int currentDay;
@property (nonatomic,assign)int currentHour;
@property (nonatomic,assign)int currentMinute;

@property (nonatomic,strong)NSArray<NSString *> *years;
@property (nonatomic,strong)NSArray<NSString *> *months;
@property (nonatomic,strong)NSArray<NSString *> *days;
@property (nonatomic,strong)NSArray<NSString *> *weekDays;
@property (nonatomic,strong)NSArray<NSString *> *weekDaysShortName;
@property (nonatomic,strong)NSArray<NSString *> *hours;
@property (nonatomic,strong)NSArray<NSString *> *minutes;

// 拆分日期对象,获取时间粒度
- (void)defaultWithDate:(NSDate *)date;
// 更新选择器
- (void)updateDatePicker;

@end
