//
//  LYSDatePickerTypeBase.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerTypeBase.h"
#import "LYSDatePickerManager.h"

@interface LYSDatePickerTypeBase ()

@property (nonatomic,strong)LYSDatePickerManager *pickerManager;

@end

@implementation LYSDatePickerTypeBase

- (instancetype)initWithPickerView:(UIPickerView *)pickerView
{
    if (self = [super init]) {
        self.pickView = pickerView;
        self.pickerManager = [[LYSDatePickerManager alloc] init];
    }
    return self;
}

- (NSArray<NSString *> *)years
{
    return [self.pickerManager fetchYearsWithFromYear:self.fromYear to:self.toYear];
}

- (NSArray<NSString *> *)months
{
    return [self.pickerManager fetchMonthsWithYear:self.currentYear];
}

- (NSArray<NSString *> *)days
{
    return [self.pickerManager fetchDaysWithYear:self.currentYear month:self.currentMonth];
}

- (NSArray<NSString *> *)weekDays
{
    if (self.weakDayType == LYSDatePickerWeakDayTypeCNDefault) {
        return [self.pickerManager fetchDaysAndWeekDayWithYear:self.currentYear month:self.currentMonth isShortWeekName:NO identifier:@"zh_CN"];
    }
    if (self.weakDayType == LYSDatePickerWeakDayTypeUSDefault) {
        return [self.pickerManager fetchDaysAndWeekDayWithYear:self.currentYear month:self.currentMonth isShortWeekName:NO identifier:@"en_US"];
    }
    return [self.pickerManager fetchDaysAndWeekDayWithYear:self.currentYear month:self.currentMonth isShortWeekName:NO identifier:@"zh_CN"];
}

- (NSArray<NSString *> *)weekDaysShortName
{
    if (self.weakDayType == LYSDatePickerWeakDayTypeCNShort) {
        return [self.pickerManager fetchDaysAndWeekDayWithYear:self.currentYear month:self.currentMonth isShortWeekName:YES identifier:@"zh_CN"];
    }
    if (self.weakDayType == LYSDatePickerWeakDayTypeUSShort) {
        return [self.pickerManager fetchDaysAndWeekDayWithYear:self.currentYear month:self.currentMonth isShortWeekName:YES identifier:@"en_US"];
    }
    return [self.pickerManager fetchDaysAndWeekDayWithYear:self.currentYear month:self.currentMonth isShortWeekName:YES identifier:@"zh_CN"];
}

- (NSArray<NSString *> *)hours
{
    return [self.pickerManager fetchHour];
}

- (NSArray<NSString *> *)minutes
{
    return [self.pickerManager fetchMinutes];
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView
{
    return 0;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 0;
}
// 拆分日期对象,获取时间粒度
- (void)defaultWithDate:(NSDate *)date {}
// 更新选择器
- (void)updateDatePicker {}

@end
