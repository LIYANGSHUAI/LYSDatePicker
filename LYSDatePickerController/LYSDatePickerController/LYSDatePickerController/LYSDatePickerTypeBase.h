//
//  LYSDatePickerTypeBase.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LYSDatePickerWeakDayTypeCNDefault,
    LYSDatePickerWeakDayTypeCNShort,
    LYSDatePickerWeakDayTypeUSDefault,
    LYSDatePickerWeakDayTypeUSShort
} LYSDatePickerWeakDayType;

@interface LYSDatePickerTypeBase : NSObject<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,weak)UIPickerView *pickView;

@property(nonatomic, copy)void(^didSelectItem)(NSDate *date);

- (instancetype)initWithPickerView:(UIPickerView *)pickerView;

// 日期开始时间
@property (nonatomic,assign)int fromYear;
// 日期结束时间
@property (nonatomic,assign)int toYear;

@property(nonatomic, weak)UILabel *titleLabel;

@property (nonatomic,assign)int currentYear;
@property (nonatomic,assign)int currentMonth;
@property (nonatomic,assign)int currentDay;
@property (nonatomic,assign)int currentHour;
@property (nonatomic,assign)int currentMinute;

@property(nonatomic, assign)BOOL yearLoop;
@property(nonatomic, assign)BOOL monthLoop;
@property(nonatomic, assign)BOOL dayLoop;
@property(nonatomic, assign)BOOL hourLoop;
@property(nonatomic, assign)BOOL minuteLoop;

@property(nonatomic, assign)BOOL showWeakDay;
@property(nonatomic, assign)LYSDatePickerWeakDayType weakDayType;

@property (nonatomic,strong,readonly)NSArray<NSString *> *years;
@property (nonatomic,strong,readonly)NSArray<NSString *> *months;
@property (nonatomic,strong,readonly)NSArray<NSString *> *days;
@property (nonatomic,strong,readonly)NSArray<NSString *> *weekDays;
@property (nonatomic,strong,readonly)NSArray<NSString *> *weekDaysShortName;
@property (nonatomic,strong,readonly)NSArray<NSString *> *hours;
@property (nonatomic,strong,readonly)NSArray<NSString *> *minutes;

// 拆分日期对象,获取时间粒度
- (void)defaultWithDate:(NSDate *)date;
// 更新选择器
- (void)updateDatePicker;

@end
